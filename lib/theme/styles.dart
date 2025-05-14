import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

const String appFontFamily = 'Zain';
double? linesHeight = 1.3;
double? htmlLinesHeight = 1.3;

// bool get isDark => ThemeService().isSavedDarkMode;

const Color colorPrimary = Color(0xFFFFB727);
const Color primaryColorLight = Color(0xFFCCDCF5);
const Color colorSecondary = Color(0xFFA0ABBB);

const Color colorTransparent = Color(0x00000000);
const Color colorDisable = Color(0xFF848484);
const Color colorDisable2 = Color(0xFF001F32);
const Color colorWarring = Color(0xFFEE353D);
const Color colorOffWhite = Color(0xFFFBFBFB);
const Color colorBG = Color(0xFFffffff);
const Color colorBabyBlue = Color(0xFFDDE0E9);
const Color colorGreen = Color(0xFF2CB742);
const Color colorRed = Color(0xFFE75A5A);
const Color colorBlack = Color(0xFF14171A);
const Color colorWhite = Color(0xFFffffff);
const Color colorDarkGrey = Color(0xFFCCCAC7);
const Color colorGrey = Color(0xFFB4B4B4);
const Color colorLightGrey = Color(0xFFFCFCFC);
const Color colorTitle = Color(0xFFFFFFFF);
const Color colorButtonBG = Color(0xFFDAA427);
const Color colorHint = Color(0xFF848484);
const Color colorSubTitle = Color(0xFFEA5858);
const Color colorDialogTitle = Color(0xFF7857AE);
const Color colorCaption = Color(0xFF09578A);
const Color colorDivider = Color(0xFFD5D5D5);
const Color colorDividerDark = Color(0xFF212A3F);
const Color colorBadge = Color(0xFFD90000);
const Color colorBadgeTxt = Color(0xFFFFFFFF);
const Color colorContainer = Color(0xFF242424);
const Color colorContainerBorder = Color(0xFFD4E6F8);
const Color colorPink = Color(0xFFE513FA);
const Color colorDropShadow = Color(0xFFB3B3B3);

const Color colorNavigationBackground = Color(0xFF283353);
const Color colorNavigationSelected = Color(0xFF262A56);
const Color colorNavigationUnSelected = Color(0xFFB4B4B4);
const Color colorSliderSelected = Color(0xFF283353);
const Color colorSliderUnSelected = Color(0xFFFFFFFF);
const Color textButtoNColor = Color(0xFF201F1D);

const Color colorServiceBG = Color(0x0A142C43);
const Color colorCategoryBG = Color(0x24142C43);

const Gradient appGradient = LinearGradient(
  begin: FractionalOffset.topCenter,
  end: FractionalOffset.bottomCenter,
  colors: [Color(0xFFDAA427), Color(0xFFDAA427)],
);

class MyTextStyle {
  static ThemeData get _appTheme => Get.theme;

  static TextTheme get _textTheme => _appTheme.textTheme;

  static TextStyle get normalStyle =>
      const TextStyle(fontFamily: appFontFamily);

  static TextStyle get appBarStyle => TextStyle(
    fontFamily: appFontFamily,
    fontSize: 17.sp,
    fontWeight: FontWeight.bold,
    color: colorTitle,
  );

  static TextStyle get bottomNavigationStyle =>
      const TextStyle(fontFamily: appFontFamily, fontSize: 16,color: colorPrimary);

  static TextStyle get myWhiteLargeTitle =>
      _textTheme.titleMedium!.copyWith(color: Colors.white);

  static TextStyle get myWhiteBoldLargeTitle =>
      _textTheme.titleMedium!.copyWith(
        fontWeight: FontWeight.bold,
        fontSize: 18,
        fontFamily: 'Zain',
        color: Colors.white,
      );

  static TextStyle get myBlackTitle => _textTheme.titleMedium!.copyWith(
    color: textButtoNColor,
    fontSize: 18,
    fontFamily: 'Zain',
    fontWeight: FontWeight.w400,
  );

  static TextStyle get myWhiteSubTitle => _textTheme.titleSmall!.copyWith(
    fontSize: 18,
    fontFamily: 'Zain',
    color: Colors.white,
  );

  static TextStyle get myWhiteBoldTitle => _textTheme.titleMedium!.copyWith(
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  static TextStyle get myWhiteBoldSubTitle => _textTheme.titleSmall!.copyWith(
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  static TextStyle get myBlackSubTitle =>
      _textTheme.titleSmall!.copyWith(color: Colors.black);

  static TextStyle get myBlackBoldTitle => _textTheme.titleMedium!.copyWith(
    fontWeight: FontWeight.bold,
    fontFamily: appFontFamily,
  );

  static TextStyle get myBlackBoldLargeTitle =>
      _textTheme.titleMedium!.copyWith(
        fontWeight: FontWeight.bold,
        fontFamily: appFontFamily,
        color: colorWhite,
      );

  static TextStyle get myBlackBoldSubTitle => _textTheme.titleSmall!.copyWith(
    fontWeight: FontWeight.bold,
    fontFamily: appFontFamily,
  );

  static TextStyle get myPrimarySubTitle =>
      _textTheme.titleSmall!.copyWith(color: _appTheme.primaryColor);

  static TextStyle get myPrimaryTitle =>
      _textTheme.titleMedium!.copyWith(color: _appTheme.primaryColor);

  static TextStyle get myPrimaryBoldTitle => _textTheme.titleMedium!.copyWith(
    color: _appTheme.primaryColor,
    fontWeight: FontWeight.bold,
  );

  static TextStyle get myPrimaryBoldSubTitle => _textTheme.titleSmall!.copyWith(
    color: _appTheme.primaryColor,
    fontWeight: FontWeight.bold,
  );

  static TextStyle get myPrimaryLargeTitle =>
      _textTheme.titleMedium!.copyWith(color: _appTheme.primaryColor);

  static TextStyle get myPrimaryBoldLargeTitle => _textTheme.titleMedium!
      .copyWith(fontWeight: FontWeight.bold, color: _appTheme.primaryColor);

  static TextStyle get mySecondarySubTitle =>
      _textTheme.titleSmall!.copyWith(color: colorPrimary, fontSize: 16);

  static TextStyle get mySecondaryTitle =>
      _textTheme.titleMedium!.copyWith(color: _appTheme.colorScheme.secondary);

  static TextStyle get mySecondaryBoldTitle => _textTheme.titleMedium!.copyWith(
    color: _appTheme.colorScheme.secondary,
    fontWeight: FontWeight.bold,
  );

  static TextStyle get mySecondaryLargeTitle =>
      _textTheme.titleMedium!.copyWith(color: _appTheme.colorScheme.secondary);

  static TextStyle get mySecondaryBoldLargeTitle =>
      _textTheme.titleMedium!.copyWith(
        color: _appTheme.colorScheme.secondary,
        fontWeight: FontWeight.bold,
      );

  static TextStyle get myGreySubTitle => _textTheme.titleSmall!.copyWith(
    color: colorDarkGrey,
    fontSize: 18,
    fontFamily: 'Zain',
    fontWeight: FontWeight.w400,
  );

  static TextStyle get myGreyTitle =>
      _textTheme.titleMedium!.copyWith(color: colorDarkGrey);

  static TextStyle get myGreyBoldTitle => _textTheme.titleMedium!.copyWith(
    color: colorDarkGrey,
    fontWeight: FontWeight.bold,
    fontFamily: appFontFamily,
  );

  static TextStyle get myErrorSubTitle =>
      _textTheme.titleSmall!.copyWith(color: Colors.red);

  static Map<String, Style> htmlSubTitle({
    int? lines,
    TextOverflow? textOverflow,
    Color? color,
    double? fontSize,
    TextAlign? textAlign,
  }) {
    return {
      "html": Style(
        lineHeight: LineHeight(htmlLinesHeight),
        fontFamily: appFontFamily,
        maxLines: lines,
        textOverflow: textOverflow,
        textAlign: textAlign ?? TextAlign.center,
        color: color ?? Colors.black,
        fontSize: fontSize != null ? FontSize(fontSize) : null,
      ),
    };
  }
}
