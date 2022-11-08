import 'package:flutter/material.dart';

import '../shared/constant.dart';

extension MaterialContextExtension on BuildContext {
  bool get isDark => Theme.of(this).brightness == Brightness.dark;

  TextStyle? get displayLarge => Theme.of(this).textTheme.displayLarge;

  TextStyle? get displayMedium => Theme.of(this).textTheme.displayMedium;

  TextStyle? get displaySmall => Theme.of(this).textTheme.displaySmall;

  TextStyle? get headlineLarge => Theme.of(this).textTheme.headlineLarge;

  TextStyle? get headlineMedium => Theme.of(this).textTheme.headlineMedium;

  TextStyle? get headlineSmall => Theme.of(this).textTheme.headlineSmall;

  TextStyle? get titleLarge => Theme.of(this).textTheme.titleLarge;

  TextStyle? get titleMedium => Theme.of(this).textTheme.titleMedium;

  TextStyle? get titleSmall => Theme.of(this).textTheme.titleSmall;

  TextStyle? get labelLarge => Theme.of(this).textTheme.labelLarge;

  TextStyle? get labelMedium => Theme.of(this).textTheme.labelMedium;

  TextStyle? get labelSmall => Theme.of(this).textTheme.labelSmall;

  TextStyle? get bodyLarge => Theme.of(this).textTheme.bodyLarge;

  TextStyle? get bodyMedium => Theme.of(this).textTheme.bodyMedium;

  TextStyle? get bodySmall => Theme.of(this).textTheme.bodySmall;

  double get safeAreaHeight {
    var mediaQuery = MediaQuery.of(this);
    return mediaQuery.size.height -
        mediaQuery.padding.top -
        mediaQuery.padding.bottom;
  }

  Color get primaryColor => Theme.of(this).primaryColor;

  Color get mainColor => !isDark ? brandColor : brandDarkColor;

  Color get backgroundColor => Theme.of(this).backgroundColor;

  /*Color get defaultCardColor => !isDark ? Colors.grey[300]! : backgroundColor;

  Color get defaultCardBorderColor =>
      !isDark ? Colors.grey[300]! : primaryColor;*/

  Color get defaultCardColor => !isDark ? Colors.white : Colors.grey[900]!;

  Color get defaultOutlineColor =>
      !isDark ? Colors.grey[300]! : Colors.grey[800]!;

  Color get favoriteColor => !isDark ? darkGold : gold;
}
