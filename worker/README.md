# Roomora AI — generation Worker (fal.ai)

Server-side proxy so the app never ships secrets and credits are spent through
RevenueCat (the only secure way — the SDK can't deduct). Image generation runs
on **fal.ai**; the Worker is just hosted on Cloudflare.

## Endpoint

`POST /generate`

```json
{ "appUserId": "<RevenueCat app user id>", "prompt": "...", "imageB64": "..." }
```

Responses:
- `200 { "image_b64": "...", "balance": 29 }` — success
- `402 { "error": "insufficient_credits" }` — user has no credits (nothing generated)
- `502 { "error": "generation_failed" }` — fal.ai failed (credit refunded)

## Deploy

1. `npm i -g wrangler` (once), then `cd worker`.
2. Confirm `RC_PROJECT_ID` in `wrangler.toml` (RevenueCat dashboard URL) and
   `FAL_MODEL` (default: `fal-ai/flux/dev/image-to-image`).
3. Set the secrets:
   ```
   wrangler secret put RC_SECRET_KEY   # RevenueCat → API keys → SECRET key (sk_...), customer read/write
   wrangler secret put FAL_KEY         # fal.ai → API Keys
   ```
4. `wrangler deploy`
5. Copy the deployed URL (e.g. `https://roomora-generate.<sub>.workers.dev`) and send it to me —
   I'll point the app at `<url>/generate` and remove the AI token from the app.

## Notes
- The credit is **reserved before** the fal.ai call, so a user without credits can
  never consume your fal.ai balance. It's **refunded** if generation fails.
- RC deduct is atomic (HTTP 422 if insufficient) — no race condition.
- fal.ai returns a hosted image URL; the Worker fetches it and returns base64 so the
  app keeps its current image handling.
