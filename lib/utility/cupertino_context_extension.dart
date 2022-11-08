import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nonoprice/shared/constant.dart';

extension CupertinoContextExtension on BuildContext {
  bool get isDark => MediaQuery.of(this).platformBrightness == Brightness.dark;

  TextStyle get displayLarge => GoogleFonts.nunito(
        fontSize: 57,
        fontWeight: FontWeight.w400,
        letterSpacing: 0,
      ).copyWith(inherit: true);

  TextStyle get displayMedium => GoogleFonts.nunito(
        fontSize: 45,
        fontWeight: FontWeight.w400,
        letterSpacing: 0,
      ).copyWith(inherit: true);

  TextStyle get displaySmall => GoogleFonts.nunito(
        fontSize: 36,
        fontWeight: FontWeight.w400,
        letterSpacing: 0,
      ).copyWith(inherit: true);

  TextStyle get headlineLarge => GoogleFonts.nunito(
        fontSize: 32,
        fontWeight: FontWeight.w400,
        letterSpacing: 0,
      ).copyWith(inherit: true);

  TextStyle get headlineMedium => GoogleFonts.nunito(
        fontSize: 28,
        fontWeight: FontWeight.w400,
        letterSpacing: 0,
      ).copyWith(inherit: true);

  TextStyle get headlineSmall => GoogleFonts.nunito(
        fontSize: 24,
        fontWeight: FontWeight.w400,
        letterSpacing: 0,
      ).copyWith(inherit: true);

  TextStyle get titleLarge => GoogleFonts.nunito(
        fontSize: 22,
        fontWeight: FontWeight.w400,
        letterSpacing: 0,
      ).copyWith(inherit: true);

  TextStyle get titleMedium => GoogleFonts.nunito(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.15,
      ).copyWith(inherit: true);

  TextStyle get titleSmall => GoogleFonts.nunito(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.1,
      ).copyWith(inherit: true);

  TextStyle get labelLarge => GoogleFonts.nunito(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.1,
      ).copyWith(inherit: true);

  TextStyle get labelMedium => GoogleFonts.nunito(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.5,
      ).copyWith(inherit: true);

  TextStyle get labelSmall => GoogleFonts.nunito(
        fontSize: 11,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.5,
      ).copyWith(inherit: true);

  TextStyle get bodyLarge => GoogleFonts.nunito(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.5,
      ).copyWith(inherit: true);

  TextStyle get bodyMedium => GoogleFonts.nunito(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.25,
      ).copyWith(inherit: true);

  TextStyle get bodySmall => GoogleFonts.nunito(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.4,
      ).copyWith(inherit: true);

  double get safeAreaHeight {
    var mediaQuery = MediaQuery.of(this);
    return mediaQuery.size.height -
        mediaQuery.padding.top -
        mediaQuery.padding.bottom;
  }

  Color get primaryColor => CupertinoTheme.of(this).primaryColor;

  Color get scaffoldBackgroundColor =>
      CupertinoTheme.of(this).scaffoldBackgroundColor;

  Color get barBackgroundColor => CupertinoTheme.of(this).barBackgroundColor;

  Color get mainColor => !isDark ? brandColor : brandDarkColor;

  Color get defaultCardColor =>
      !isDark ? Colors.white : CupertinoColors.darkBackgroundGray;

  Color get defaultOutlineColor =>
      !isDark ? Colors.grey[300]! : Colors.grey[800]!;

  Color get defaultNextIconColor =>
      !isDark ? Colors.grey[500]! : Colors.grey[300]!;
}
