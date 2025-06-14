import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'ar_EG.dart';
import 'en_US.dart';

class TranslationService extends Translations {
  static final fallbackLocale = Locale('ar');

  @override
  Map<String, Map<String, String>> get keys => {'ar': ar_EG, 'en': en_US};
}
