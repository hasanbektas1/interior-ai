/**
 * Roomora AI — generation proxy Worker (fal.ai).
 *
 * The app calls POST /generate instead of hitting fal.ai/RevenueCat directly,
 * so secrets never ship in the app and credits are spent server-side (the only
 * secure way — RevenueCat's SDK can't deduct).
 *
 * Flow:
 *   1. Reserve 1 credit in RevenueCat (atomic; HTTP 422 if the user has none).
 *   2. Generate the image on fal.ai with the secret key.
 *   3. Refund the credit if generation fails.
 *   4. Return { image_b64, balance }.
 *
 * Secrets (wrangler secret put ...): RC_SECRET_KEY, FAL_KEY
 * Vars (wrangler.toml): RC_PROJECT_ID, CREDITS_CURRENCY, GENERATION_COST,
 *   FAL_MODEL
 */

export default {
  async fetch(request, env) {
    const url = new URL(request.url);

    if (request.method === 'GET' && url.pathname === '/health') {
      return json({ ok: true });
    }
    if (request.method !== 'POST' || url.pathname !== '/generate') {
      return json({ error: 'not_found' }, 404);
    }

    let body;
    try {
      body = await request.json();
    } catch {
      return json({ error: 'bad_json' }, 400);
    }

    // refB64 is an optional second image (e.g. a style reference); when present
    // it's passed alongside the primary image so the model can use both.
    const { appUserId, prompt, imageB64, refB64 } = body;

    if (!appUserId || !prompt || !imageB64) {
      return json({ error: 'missing_fields' }, 400);
    }

    const currency = env.CREDITS_CURRENCY || 'CREDITS';
    const cost = Number(env.GENERATION_COST || '1');
    const rcBase =
      `https://api.revenuecat.com/v2/projects/${env.RC_PROJECT_ID}` +
      `/customers/${encodeURIComponent(appUserId)}/virtual_currencies`;
    const rcHeaders = {
      Authorization: `Bearer ${env.RC_SECRET_KEY}`,
      'Content-Type': 'application/json',
    };

    // 1) Reserve the credit (atomic: 422 = not enough, nothing deducted).
    const reserve = await fetch(`${rcBase}/transactions`, {
      method: 'POST',
      headers: rcHeaders,
      body: JSON.stringify({ adjustments: { [currency]: -cost } }),
    });
    if (reserve.status === 422) {
      return json({ error: 'insufficient_credits' }, 402);
    }
    if (!reserve.ok) {
      return json({ error: 'rc_deduct_failed', status: reserve.status }, 502);
    }
    const reserveData = await reserve.json().catch(() => null);
    const balanceAfter = balanceFrom(reserveData, currency);

    // 2) Generate on fal.ai (nano-banana/edit: instruction-based image edit,
    //    takes image_urls[] and no strength/steps). The credit is already
    //    reserved, so we can retry fal a few times on transient failures
    //    without double-charging (the client never retries POST /generate).
    try {
      const model = env.FAL_MODEL || 'fal-ai/nano-banana/edit';
      const imageUrls = [`data:${mimeFromB64(imageB64)};base64,${imageB64}`];
      if (refB64) {
        imageUrls.push(`data:${mimeFromB64(refB64)};base64,${refB64}`);
      }
      const falBody = JSON.stringify({
        prompt,
        image_urls: imageUrls,
        num_images: 1,
        output_format: 'jpeg',
      });

      let image_b64 = null;
      let lastErr = null;
      for (let attempt = 0; attempt < 3; attempt++) {
        try {
          const falRes = await fetch(`https://fal.run/${model}`, {
            method: 'POST',
            headers: {
              Authorization: `Key ${env.FAL_KEY}`,
              'Content-Type': 'application/json',
            },
            body: falBody,
          });
          if (!falRes.ok) throw new Error(`fal_status_${falRes.status}`);
          const falData = await falRes.json();
          const imageUrl = imageUrlFrom(falData);
          if (!imageUrl) throw new Error('no_image_in_response');
          const imgRes = await fetch(imageUrl);
          if (!imgRes.ok) throw new Error(`img_fetch_${imgRes.status}`);
          const bytes = new Uint8Array(await imgRes.arrayBuffer());
          image_b64 = base64FromBytes(bytes);
          break;
        } catch (e) {
          lastErr = e;
        }
      }
      if (image_b64 === null) throw lastErr || new Error('fal_failed');

      return json({ image_b64, balance: balanceAfter }, 200);
    } catch (_) {
      // 3) Refund on failure — don't charge for a failed generation.
      await fetch(`${rcBase}/transactions`, {
        method: 'POST',
        headers: rcHeaders,
        body: JSON.stringify({ adjustments: { [currency]: cost } }),
      }).catch(() => {});
      return json({ error: 'generation_failed' }, 502);
    }
  },
};

function json(obj, status = 200) {
  return new Response(JSON.stringify(obj), {
    status,
    headers: { 'Content-Type': 'application/json' },
  });
}

/// Detect the image type from the leading base64 chars so the data URI carries
/// the right mime (camera photos are usually JPEG, example assets PNG).
function mimeFromB64(b64) {
  if (b64.startsWith('/9j/')) return 'image/jpeg';
  if (b64.startsWith('iVBOR')) return 'image/png';
  if (b64.startsWith('UklGR')) return 'image/webp';
  return 'image/png';
}

function base64FromBytes(bytes) {
  let binary = '';
  const chunk = 0x8000;
  for (let i = 0; i < bytes.length; i += chunk) {
    binary += String.fromCharCode.apply(null, bytes.subarray(i, i + chunk));
  }
  return btoa(binary);
}

/// fal responses vary by model; find the first image URL anywhere.
function imageUrlFrom(data) {
  let found = null;
  const walk = (o) => {
    if (found || !o || typeof o !== 'object') return;
    if (Array.isArray(o)) return o.forEach(walk);
    if (typeof o.url === 'string' && o.url.startsWith('http')) {
      found = o.url;
      return;
    }
    for (const k in o) walk(o[k]);
  };
  walk(data);
  return found;
}

/// RC responses vary; find the balance for [code] anywhere.
function balanceFrom(data, code) {
  let found = null;
  const walk = (o) => {
    if (!o || typeof o !== 'object') return;
    if (Array.isArray(o)) return o.forEach(walk);
    if (
      (o.code === code || o.currency_code === code) &&
      (typeof o.balance === 'number' || typeof o.amount === 'number')
    ) {
      found = typeof o.balance === 'number' ? o.balance : o.amount;
    }
    for (const k in o) walk(o[k]);
  };
  walk(data);
  return found;
}
