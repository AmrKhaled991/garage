import 'dart:ui';
import 'package:garage/core/networking/loading_state.dart';
import 'package:garage/core/networking/models/page.dart';
import 'package:garage/core/networking/models/settings.dart';
import 'package:garage/core/networking/models/supportedCountry.dart';
import 'package:garage/core/repositories/main_repository.dart';
import 'package:garage/core/storage/preference_manager.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

class MainController extends GetxController {

  final PreferenceManager preferenceManager = Get.find();
  final MainRepository mainRepository = Get.find();

  @override
  void onInit() async{
    language.listen((lang) {
      preferenceManager.setLocale(lang);
      fetchPages(force: true);
    });

    settings.listen((s) {
      if(s!=null && s!=null) {
        preferenceManager.setSettings(s);
      }
    });

    language.value = preferenceManager.getLocale;
    settings.value = preferenceManager.getSettings;
    fetchSettings();
    fetchSupportedCountries();

    final PackageInfo info = await PackageInfo.fromPlatform();
    packageInfo.value =  info;
  }


  var language = 'en'.obs;
  var  pages = LoadingState<List<PagesData>?>().obs;
  Rx<PackageInfo?> packageInfo = Rx<PackageInfo?>(null);
  Rx<Settings?> settings = Rx<Settings?>(null);
  Rx<List<SupportedCountry>?> supportedCountries = Rx<List<SupportedCountry>?>(null);
  Rx<SupportedCountry?> selectedSupportedCountry = Rx<SupportedCountry?>(null);

  void changeLanguage(String lang){
    language.value = lang;//(language.value == "en")? "ar" : "en";
    Get.updateLocale(Locale(language.value));
  }

  void toggleLanguage(){
    language.value = (language.value == "en")? "ar" : "en";
    Get.updateLocale(Locale(language.value));
  }


  void fetchSettings() async{
    LoadingState<Settings?> response = await mainRepository.getSettings();
    if(response.success){
      settings.value = response.data!;
    }
  }

  void fetchSupportedCountries() async{
    var response = await mainRepository.getSupportedCountries();
    if(response.success){
      supportedCountries.value = response.data;
      selectedSupportedCountry.value = response.data?.firstOrNull;
    }
  }

  void fetchPages({bool force = false}) async{
    if(pages.value.data != null && !force)
      return;
    pages.value = LoadingState.loading();
    LoadingState<List<PagesData>?> data = await mainRepository.getPages();
    if(data.success && data.data!=null) {
      pages.value = data;
    }

  }
}