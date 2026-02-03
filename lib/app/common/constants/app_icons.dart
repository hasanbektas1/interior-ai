enum AppIcons {
  contact,
}

extension AppIconsExtension on AppIcons {
  String get fileName {
    switch (this) {
      case AppIcons.contact:
        return 'contact';
    }
  }

  String get assetPath => 'assets/icons/$fileName.png';
}
