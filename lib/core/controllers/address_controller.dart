import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:garage/core/controllers/user_controller.dart';
import 'package:garage/core/networking/loading_state.dart';
import 'package:garage/core/networking/models/city.dart';
import 'package:garage/core/repositories/address_repository.dart';
import 'package:garage/core/storage/preference_manager.dart';
import 'package:garage/utils/utlis.dart';
import '../networking/models/address.dart';

class AddressController extends GetxController {
  final PreferenceManager sharedPreferenceRepository = Get.find();
  UserController userController = Get.find();
  final AddressRepository addressRepository = Get.find();
  // late HomeController homeController;

  @override
  void onReady() {
    // homeController = Get.find();

    super.onReady();
  }

  @override
  void onInit() {
    fetchAreas();
    selectedArea.value = sharedPreferenceRepository.getLastSelectedArea;
    selectedAddress.value = null;

    selectedArea.stream.listen((a) {
      print("selectedArea: $a");
      // homeController.fetchVendors();
      sharedPreferenceRepository.setLastSelectedArea(a);
    });

    fetchAddresses();
    // addresses.stream.listen((a) {
    //   if(a.loading){
    //     return;
    //   }
    //
    //   if(a.data!=null){
    //     //set default address
    //     selectedAddress.value = addresses.value.data?.data?.firstWhereOrNull((element) => element.isDefault == true);
    //   }else{
    //     selectedAddress.value = null;
    //   }
    //
    //   if(selectedAddress.value == null){
    //     selectedArea.value = null;
    //   }else{
    //     selectedArea.value = areas.value.data?.data?.firstWhere((element) => element.states?.any((s) => s.id == selectedAddress.value?.stateId)??false).states?.firstWhere((ss) => ss.id == selectedAddress.value?.stateId);
    //   }
    //   print("set default address: ${selectedAddress.value}");
    // });
    super.onInit();
  }

  var addAddressLoading = LoadingState().obs;
  var deleteAddressLoading = LoadingState().obs;
  var addresses = LoadingState<List<Country>>().obs;
  var guestAddress = Rx<AddressData?>(null);
  var areas = LoadingState<List<City>?>().obs;
  var selectedArea = Rx<StateData?>(null);
  var selectedAddress = Rx<Country?>(null);

  void fetchAddresses() async {
    addresses.value = LoadingState.loading();
    addresses.value = await addressRepository.getRegions();
    print("11111111: ${addresses.value.data?.length}");
    if (selectedAddress.value == null) {
      selectedAddress.value = addresses.value.data?.firstWhereOrNull(
        (element) =>
            (element.title?.contains("الكويت") ??
                false || (element.title?.contains("kuwait") ?? false)),
      );
    }
  }

  void fetchAreas() async {
    if (areas.value.data != null) return;
    areas.value = LoadingState.loading();
    areas.value = await addressRepository.getAreas();
  }

  void addAddress(Map<String, String> data, Function(bool) onSuccess) async {
    addAddressLoading.value = LoadingState.loading();
    addAddressLoading.value = await addressRepository.addAddresses(data);
    onSuccess.call(addAddressLoading.value.success);
    if (!addAddressLoading.value.success) {
      Utils.showSnackBar(addAddressLoading.value.message);
    }
  }

  void deleteAddress(int id) async {
    deleteAddressLoading.value = LoadingState.loading();
    deleteAddressLoading.value = await addressRepository.deleteAddresses(id);
    if (deleteAddressLoading.value.success) {
      fetchAddresses();
    }
  }

  void setDefaultAddress(int? id) async {
    await addressRepository.setDefaultAddress(id ?? 0);
  }
}
