import 'package:garage/core/networking/loading_state.dart';
import 'package:garage/core/repositories/home_repository.dart';
import 'package:get/get.dart';

import 'home_state.dart';

class HomeController extends GetxController {
  final HomePageState state = HomePageState();
  final HomeRepository _homeRepository = Get.find();

  @override
  void onInit() {
    super.onInit();
    // getCurrencies();
    // getSlider();
    getCategories();
    // getVendors();
  }

  getCategories({bool forceRefresh = false}) async {
    if (state.categoriesList.value.data != null && !forceRefresh) {
      return;
    }
    state.categoriesList.value = LoadingState.loading();
    state.categoriesList.value = await _homeRepository.getCategories();
  }
}
