import 'package:interior_ai/app/common/config/app_secrets.dart';

enum Environment { production, development }

final class Config {
  static late Environment currentEnvironment;

  // ---- Cloudflare Workers AI image generation (free tier) ----
  // Account ID is visible in your Cloudflare dashboard URL. The token is a
  // secret — prefer --dart-define and do NOT commit a real token to git.
  // Read from the git-ignored app_secrets.dart so the token never gets committed
  // while plain `flutter run` / the IDE run button still work (no flags needed).
  static const String cloudflareAccountId = AppSecrets.cloudflareAccountId;
  static const String cloudflareApiToken = AppSecrets.cloudflareApiToken;

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
