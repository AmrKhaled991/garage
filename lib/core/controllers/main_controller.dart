import 'dart:ui';
import 'package:garage/core/controllers/user_controller.dart';
import 'package:garage/core/networking/loading_state.dart';
import 'package:garage/core/networking/models/page.dart';
import 'package:garage/core/networking/models/settings.dart';
import 'package:garage/core/networking/models/socials/socials.dart';
import 'package:garage/core/networking/models/supportedCountry.dart';
import 'package:garage/core/repositories/main_repository.dart';
import 'package:garage/core/storage/preference_manager.dart';
import 'package:garage/features/main/home/home_logic.dart';
import 'package:garage/features/main/my_orders/my_orders_controller.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

class MainController extends GetxController {
  final PreferenceManager preferenceManager = Get.find();
  final MainRepository mainRepository = Get.find();

  @override
  void onInit() async {
    language.listen((lang) {
      preferenceManager.setLocale(lang);
      fetchPages(force: true);
      fetchSocials(force: true);
    });

    settings.listen((s) {
      if (s != null) {
        preferenceManager.setSettings(s);
      }
    });

    language.value = preferenceManager.getLocale;
    settings.value = preferenceManager.getSettings;
    fetchSettings();
    fetchSupportedCountries();

    final PackageInfo info = await PackageInfo.fromPlatform();
    packageInfo.value = info;
  }

  var language = 'en'.obs;
  var pages = LoadingState<List<PagesData>?>().obs;
  var socials = LoadingState<List<GarageSocials>?>().obs;

  Rx<PackageInfo?> packageInfo = Rx<PackageInfo?>(null);
  Rx<Settings?> settings = Rx<Settings?>(null);
  Rx<List<SupportedCountry>?> supportedCountries = Rx<List<SupportedCountry>?>(
    null,
  );
  Rx<SupportedCountry?> selectedSupportedCountry = Rx<SupportedCountry?>(null);

  void changeLanguage(String lang) {
    language.value = lang; //(language.value == "en")? "ar" : "en";
    Get.updateLocale(Locale(language.value));
  }

  void toggleLanguage() {
    Get.updateLocale(Locale(language.value));
    Get.reload<MainController>(force: true);
    Get.reload<UserController>(force: true);
    Get.reload<HomeController>(force: true);
    Get.reload<MyOrdersController>(force: true);
    language.value = (language.value == "en") ? "ar" : "en";
  }

  void fetchSettings() async {
    LoadingState<Settings?> response = await mainRepository.getSettings();
    if (response.success) {
      settings.value = response.data!;
    }
  }

  void fetchSupportedCountries() async {
    var response = await mainRepository.getSupportedCountries();
    if (response.success) {
      supportedCountries.value = response.data;
      selectedSupportedCountry.value = response.data?.firstOrNull;
    }
  }

  void fetchPages({bool force = false}) async {
    if (pages.value.data != null && !force) return;
    pages.value = LoadingState.loading();
    LoadingState<List<PagesData>?> data = await mainRepository.getPages();
    if (data.success && data.data != null) {
      pages.value = data;
    }
  }

  void fetchSocials({bool force = false}) async {
    if (socials.value.data != null && !force) return;
    socials.value = LoadingState.loading();
    socials.value = await mainRepository.getSocials();
  }
}
