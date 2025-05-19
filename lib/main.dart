import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:garage/core/binding.dart';
import 'package:garage/core/controllers/main_controller.dart';
import 'package:garage/core/lang/translation_service.dart';
import 'package:garage/core/storage/preference_manager.dart';
import 'package:garage/routes/app_pages.dart';
import 'package:garage/theme/theme_service.dart';
import 'package:garage/theme/themes.dart';
import 'package:garage/utils/logger_utils.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

Future<void> main() async {
  // VideoPlayerController.setCacheSize(100 * 1024 * 1024, 200 * 1024 * 1024);
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();

  runZonedGuarded<Future<void>>(
    () async {
      // Pass all uncaught errors from the framework to Crashlytics.
      // FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
      // FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
      await GetStorage.init();
      Binding().dependencies();
      HttpOverrides.global = MyHttpOverrides();
      // FirebaseNotifications().setUpFirebase();

      runApp(const MyApp());
      // The following lines are the same as previously explained in "Handling uncaught errors"
    },
    (error, stack) {
      // FirebaseCrashlytics.instance.recordError(error, stack);
    },
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();

  static restartAppMethod(BuildContext context) {
    context.findAncestorStateOfType<_MyAppState>()?.restartApp();
  }
}

class _MyAppState extends State<MyApp> {
  PreferenceManager preferenceManager = Get.find();
  Key key = UniqueKey();

  void restartApp() {
    Binding().dependencies();
    setState(() {
      key = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder:
          (context, child) => GetMaterialApp(
            // for testing ui translations
            builder: (context, child) {
              final locale = Get.find<PreferenceManager>();
              final change = Get.find<MainController>();
              return Stack(
                children: [
                  child!,
                  Positioned(
                    right: 16,
                    bottom: 100,
                    child: FloatingActionButton(
                      onPressed: () {
                        final isAr = locale.getLocale == 'ar';
                        if (isAr) {
                          change.changeLanguage('en');
                        } else {
                          change.changeLanguage('ar');
                        }
                      },
                      child: const Icon(Icons.language, color: Colors.white),
                    ),
                  ),
                ],
              );
            },
            key: key,
            debugShowCheckedModeBanner: false,
            enableLog: false,
            logWriterCallback: Logger.write,
            initialRoute: AppPages.INITIAL,
            getPages: AppPages.routes,
            locale: Locale(preferenceManager.getLocale),
            fallbackLocale: TranslationService.fallbackLocale,
            translations: TranslationService(),
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: ThemeService().getThemeMode(),
          ),
    );
  }
}
