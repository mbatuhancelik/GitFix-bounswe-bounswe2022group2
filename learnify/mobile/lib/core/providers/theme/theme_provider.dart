import 'package:flutter/material.dart';

import '../../../product/theme/dark_theme.dart';
import '../../../product/theme/light_theme.dart';
import '../../../product/theme/theme_types.dart';

/// Provider of theme, manages theme actions.
class ThemeProvider extends ChangeNotifier with LightAppTheme, DarkAppTheme {
  ThemeData? _theme;
  ThemeTypes _themeEnum = ThemeTypes.light;

  /// Gets the value of current theme as [ThemeTypes] enum.
  ThemeTypes get currentThemeEnum => _themeEnum;

  /// Gets the current theme as [ThemeData].
  ThemeData get currentTheme {
    // TODO: Fix
    // if (_theme == null) _getStoredTheme();
    return _theme ?? LightAppTheme.lightTheme;
  }

  // TODO: Fix
  // void _getStoredTheme() {
  //   final ThemeTypes? storedTheme = SettingsLocalManager.instance
  //       .get(SettingsOptions.theme)
  //       ?.toEnum<ThemeTypes>(ThemeTypes.values);
  //   if (storedTheme != null) _themeEnum = storedTheme;
  //   _assignTheme(_themeEnum);
  // }

  void _assignTheme(ThemeTypes themeEnum) {
    if (themeEnum == ThemeTypes.dark) {
      _theme = DarkAppTheme.darkTheme;
    } else if (themeEnum == ThemeTypes.light) {
      _theme = LightAppTheme.lightTheme;
    }
  }

  /// Sets the current theme to the given one.
  Future<void> setTheme(ThemeTypes themeEnum) async {
    _assignTheme(themeEnum);
    _themeEnum = themeEnum;
    // TODO: Fix
    // await SettingsLocalManager.instance
    //     .set(SettingsOptions.theme, _themeEnum.name);
    notifyListeners();
  }

  /// Switches between the light-dark themes.
  Future<void> switchTheme() async {
    if (_themeEnum == ThemeTypes.light) {
      await setTheme(ThemeTypes.dark);
    } else if (_themeEnum == ThemeTypes.dark) {
      await setTheme(ThemeTypes.light);
    }
  }

  /// Returns a bool that represents whether the current theme is dark.
  bool get isDark => _themeEnum == ThemeTypes.dark;
}