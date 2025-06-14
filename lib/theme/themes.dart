import 'package:flutter/material.dart';
import 'package:garage/theme/styles.dart';

final ThemeData lightTheme = buildLightTheme();
final ThemeData darkTheme = buildDarkTheme();

ThemeData buildLightTheme() {
  final ColorScheme colorScheme = const ColorScheme.light().copyWith(
    primary: colorPrimary,
    secondary: colorSecondary,
  );
  final ThemeData base = ThemeData(
    brightness: Brightness.light,
    fontFamily: appFontFamily,
    platform: TargetPlatform.iOS,
  );
  return base.copyWith(
    visualDensity: VisualDensity.adaptivePlatformDensity,
    colorScheme: colorScheme,
    primaryColor: colorPrimary,
    primaryColorLight: primaryColorLight,
    indicatorColor: Colors.white,
    splashColor: Colors.white24,
    splashFactory: InkRipple.splashFactory,
    canvasColor: Colors.white,
    scaffoldBackgroundColor: Colors.white,
    buttonTheme: ButtonThemeData(
      colorScheme: colorScheme,
      textTheme: ButtonTextTheme.primary,
    ),
    textTheme: _buildTextTheme(base.textTheme),
    primaryTextTheme: _buildTextTheme(base.primaryTextTheme),
    appBarTheme: base.appBarTheme.copyWith(
      color: Colors.white /*,
        brightness: Brightness.light*/,
    ),
  );
}

ThemeData buildDarkTheme() {
  final ColorScheme colorScheme = const ColorScheme.dark().copyWith(
    primary: colorPrimary,
    secondary: colorSecondary,
  );
  final ThemeData base = ThemeData(
    brightness: Brightness.dark,
    fontFamily: appFontFamily,
    platform: TargetPlatform.iOS,
  );
  return base.copyWith(
    primaryColor: colorPrimary,
    indicatorColor: Colors.white,
    canvasColor: const Color(0xFF202124),
    scaffoldBackgroundColor: const Color(0xFF202124),
    buttonTheme: ButtonThemeData(
      colorScheme: colorScheme,
      textTheme: ButtonTextTheme.primary,
    ),
    textTheme: _buildTextTheme(base.textTheme),
    primaryTextTheme: _buildTextTheme(base.primaryTextTheme),
    appBarTheme: base.appBarTheme.copyWith(
      color: Colors.black /*,
        brightness: Brightness.light*/,
    ),
  );
}

TextTheme _buildTextTheme(TextTheme base) {
  return base.copyWith(
    headlineLarge: base.headlineLarge?.copyWith(
      fontFamily: appFontFamily,
      height: linesHeight,
    ),
    headlineMedium: base.headlineMedium?.copyWith(
      fontFamily: appFontFamily,
      height: linesHeight,
    ),
    headlineSmall: base.headlineSmall?.copyWith(
      fontFamily: appFontFamily,
      height: linesHeight,
    ),
    titleLarge: base.titleLarge?.copyWith(
      fontFamily: appFontFamily,
      height: linesHeight,
    ),
    titleMedium: base.titleMedium?.copyWith(
      fontFamily: appFontFamily,
      height: linesHeight,
    ),
    titleSmall: base.titleSmall?.copyWith(
      fontFamily: appFontFamily,
      height: linesHeight,
    ),
    bodyLarge: base.bodyLarge?.copyWith(
      fontFamily: appFontFamily,
      height: linesHeight,
    ),
    bodyMedium: base.bodyMedium?.copyWith(
      fontFamily: appFontFamily,
      height: linesHeight,
    ),
    bodySmall: base.bodySmall?.copyWith(
      fontFamily: appFontFamily,
      height: linesHeight,
    ),
    labelLarge: base.labelLarge?.copyWith(
      fontFamily: appFontFamily,
      height: linesHeight,
    ),
    labelMedium: base.labelMedium?.copyWith(
      fontFamily: appFontFamily,
      height: linesHeight,
    ),
    labelSmall: base.labelSmall?.copyWith(
      fontFamily: appFontFamily,
      height: linesHeight,
    ),
    displayLarge: base.displayLarge?.copyWith(
      fontFamily: appFontFamily,
      height: linesHeight,
    ),
    displayMedium: base.displayMedium?.copyWith(
      fontFamily: appFontFamily,
      height: linesHeight,
    ),
    displaySmall: base.displaySmall?.copyWith(
      fontFamily: appFontFamily,
      height: linesHeight,
    ),
  );
}
