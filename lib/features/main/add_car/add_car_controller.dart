import 'dart:math';

import 'package:garage/core/networking/loading_state.dart';
import 'package:garage/core/repositories/user_car_repository.dart';
import 'package:garage/features/main/specifies_the_brand/select_the_brand_controller.dart';
import 'package:garage/routes/app_pages.dart';
import 'package:garage/utils/utlis.dart';
import 'package:get/get.dart';

import 'add_car_state.dart';

class AddCarLogic extends GetxController {
  final AddCarState state = AddCarState();
  final UserCarRepository _userCarRepository = Get.find<UserCarRepository>();

  bool validations() {
    if (state.model.isBlank == true) {
      Utils.showSnackBar("error_model".tr);
      return false;
    } else if (state.year.text.isBlank == true) {
      Utils.showSnackBar("error_model_year".tr);
      return false;
    } else if (state.carOwnerName.text.isBlank == true) {
      Utils.showSnackBar("error_car_owner_name".tr);
      return false;
    }
    return true;
  }

  Map<String, dynamic> getRegisterData() {
    Map<String, dynamic> result = {
      "brand_id": state.brandId.value,
      "model": state.model.text,
      "year": state.year.text,
      "car_owner_name": state.carOwnerName.text,
    };
    return result;
  }

  storCar(Function(bool) onFinish) async {
    state.addCar.value = LoadingState.loading();

    state.addCar.value = await _userCarRepository.postUserCar(
      getRegisterData(),
    );
    onFinish.call(state.addCar.value.success);
    if (state.addCar.value.success == false) {
      Utils.showSnackBar(state.addCar.value.message);
    } else {
      Future.delayed(const Duration(seconds: 1), () {
        Get.offAllNamed(Routes.MAIN);
      });
    }
  }
}
