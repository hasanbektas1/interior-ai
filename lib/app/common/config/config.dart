enum Environment { production, development }

final class Config {
  static late Environment currentEnvironment;

  // ---- Roomora generation Worker (Cloudflare) ----
  // The app calls this Worker instead of the AI provider directly. The Worker
  // spends the user's RevenueCat credit server-side and calls fal.ai with keys
  // that never ship in the app. See worker/ for the deployed source.
  static const String workerBaseUrl =
      'https://roomora-generate.roomora.workers.dev';

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
