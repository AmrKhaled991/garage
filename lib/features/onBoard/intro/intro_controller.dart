import 'package:garage/core/networking/models/IntroSlider.dart';
import 'package:get/get.dart';
import 'package:garage/core/networking/loading_state.dart';
import 'package:garage/core/repositories/main_repository.dart';
import 'package:garage/routes/app_pages.dart';
import 'intro_state.dart';

class IntroController extends GetxController {
  final IntroState state = IntroState();
  MainRepository mainRepository = Get.find();

  @override
  void onInit() {
    fetchIntro();
    super.onInit();
  }

  void fetchIntro() async {
    state.intros.value = LoadingState.loading();
    // state.intros.value = await mainRepository.getIntroSliders();

    state.intros.value?.data = [
      IntroSlider(
        id: 1,
        title: "test_title".tr,
        description: "test_description".tr,
        image: "assets/images/logo.png",
      ),
      IntroSlider(
        id: 1,
        title: "test_title".tr,
        description: "test_description".tr,
        image: "assets/images/logo.png",
      ),
      IntroSlider(
        id: 1,
        title: "test_title".tr,
        description: "test_description".tr,
        image: "assets/images/logo.png",
      ),
    ];

    // state.intros.value = await mainRepository.getIntroSliders();

    if (state.intros.value?.error == true ||
        state.intros.value?.data?.isEmpty == true) {
      // Get.offAllNamed(Routes.MAIN);
    }
  }
}
