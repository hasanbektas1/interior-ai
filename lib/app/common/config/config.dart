enum Environment { production, development }

final class Config {
  static late Environment currentEnvironment;

  // ---- Cloudflare Workers AI image generation (free tier) ----
  // Account ID is visible in your Cloudflare dashboard URL. The token is a
  // secret — prefer --dart-define and do NOT commit a real token to git.
  static const String cloudflareAccountId = String.fromEnvironment(
    'CF_ACCOUNT_ID',
    defaultValue: 'af2701638e43c31eb51510c7673010de',
  );

  // Pass at run time: --dart-define=CF_API_TOKEN=your_token  (never commit it)
  static const String cloudflareApiToken =
      String.fromEnvironment('CF_API_TOKEN', defaultValue: '');

  static const String cloudflareImageModel =
      '@cf/runwayml/stable-diffusion-v1-5-img2img';

  static String get cloudflareRunBaseUrl =>
      'https://api.cloudflare.com/client/v4/accounts/$cloudflareAccountId/ai/run';

  static String get apiBaseUrl {
    switch (currentEnvironment) {
      case Environment.production:
        return 'https://xxx.com/api/prod';
      case Environment.development:
        return 'https://xxx.com/api/dev';
    }
  }

  static String get environmentName {
    switch (currentEnvironment) {
      case Environment.production:
        return 'Production';
      case Environment.development:
        return 'Development';
    }
  }
}
