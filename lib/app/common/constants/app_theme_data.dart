import 'package:flutter/material.dart';
import 'package:interior_ai/app/common/constants/app_colors.dart';

final class AppThemeData {
  static final ThemeData themeData = ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
    useMaterial3: true,
    scaffoldBackgroundColor: AppColors.ghostWhite,
    bottomNavigationBarTheme: _bottomNavigationBarTheme,
    appBarTheme: _appBarTheme,
  );

  static const BottomNavigationBarThemeData _bottomNavigationBarTheme =
      BottomNavigationBarThemeData(
        backgroundColor: AppColors.ghostWhite,
        elevation: 0,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColors.ghostWhite,
        unselectedItemColor: AppColors.ghostWhite,
        unselectedLabelStyle: TextStyle(
          color: AppColors.ghostWhite,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
        selectedLabelStyle: TextStyle(
          color: AppColors.ghostWhite,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      );

  static const AppBarTheme _appBarTheme = AppBarTheme(
    backgroundColor: AppColors.ghostWhite,
    centerTitle: false,
    elevation: 0,
    titleTextStyle: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w600,
      color: AppColors.ghostWhite,
    ),
    scrolledUnderElevation: 0,
  );
}
