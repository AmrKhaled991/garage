import 'package:garage/core/networking/loading_state.dart';
import 'package:garage/core/repositories/user_car_repository.dart';
import 'package:get/get.dart';

import 'select_the_brand_state.dart';

class SelectTheBrandController extends GetxController {
  final SelectTheBrandState state = SelectTheBrandState();
  final UserCarRepository repository = Get.find<UserCarRepository>();

  @override
  void onInit() {
    super.onInit();
    getBrands();
  }

  getBrands() async {
    state.brands.value = LoadingState.loading();
    state.brands.value = await repository.getBrands();
  }

  void selectBrand(int? id, String? name) {
    state.selectedBrandId.value = id;
    state.selectedBrandName.value = name;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    Get.delete<SelectTheBrandController>();
  }
}
