import 'dart:ffi';

import 'package:garage/core/networking/loading_state.dart';
import 'package:garage/core/networking/models/adress/user_address.dart';
import 'package:garage/core/repositories/main_repository.dart';
import 'package:garage/utils/utlis.dart';
import 'package:get/get.dart';

import 'add_new_address_state.dart';

class AddNewAddressController extends GetxController {
  final AddNewAddressState state = AddNewAddressState();
  final MainRepository mainRepository = Get.find<MainRepository>();

  @override
  onInit() {
    super.onInit();
    final UserAddress? address = Get.arguments;

    if (address != null) {
      state.timeId.value = address.id ?? 0;
      state.name.text = address.title!;
      state.details.text = address.description!;
      state.lat.value = double.parse(address.lat ?? "0.0");
      state.lng.value = double.parse(address.lng ?? "0.0");
      state.isActive.value = address.isActive ?? false;
      state.mapDesc.value = address.extraDescription;
    }
  }

  bool validate() {
    if (state.name.text.isBlank == true) {
      Utils.showSnackBar("error_name".tr);
      return false;
    }
    if (state.details.text.isBlank == true) {
      Utils.showSnackBar("a".tr);
      return false;
    }
    if (state.lat.value == null) {
      Utils.showSnackBar("error_location".tr);
      return false;
    }
    return true;
  }

  latLngChanged(double latitude, double longitude, String? mapDesc) {
    state.lat.value = latitude;
    state.lng.value = longitude;
    state.mapDesc.value = mapDesc;
  }

  addNewAddress({
    required Map<String, dynamic>? body,
    required Function(bool) onFinish,
  }) async {
    state.isLoading.value = LoadingState.loading();
    state.isLoading.value =
        state.timeId.value != null
            ? await mainRepository.updateAddress(
              body: body,
              id:  state.timeId.value,
            )
            : await mainRepository.storeAddress(body: body);
    if (state.isLoading.value.success) {
      onFinish.call(state.isLoading.value.success);
    } else {
      onFinish.call(state.isLoading.value.success);
      Utils.showSnackBar(state.isLoading.value.message);
    }
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    Get.delete<AddNewAddressController>();
  }
}
