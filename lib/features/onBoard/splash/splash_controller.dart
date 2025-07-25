import 'package:get/get.dart';
import 'package:garage/core/storage/preference_manager.dart';
import 'package:garage/routes/app_pages.dart';
import 'splash_state.dart';

class SplashController extends GetxController {
  final PreferenceManager preferenceManager = Get.find();
  final SplashState state = SplashState();

  navigate() {
    if (!preferenceManager.getIntroShown) {
      preferenceManager.setIntroShown();
      Get.offAllNamed(Routes.INTRO);
    } else {
      Get.offAllNamed(Routes.MAIN);
    }
  }

  @override
  void onReady() {
    // FirebaseNotifications().setUpFirebase();
    super.onReady();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }
}
