import 'package:garage/core/networking/loading_state.dart';
import 'package:garage/core/repositories/main_repository.dart';
import 'package:get/get.dart';

import 'company_profile_edit_state.dart';

class CompanyProfileEditController extends GetxController {
  final CompanyProfileEditState state = CompanyProfileEditState();
  final MainRepository _mainRepository = Get.find();

  bool validations() {
    return true;
  }

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
    state.categoriesList.value = await _mainRepository.getCategories();
  }

  Map<String, dynamic> updateDate() {
    return {
      "description_work": state.companyDescription.text,
      "website": state.website.text,
      "phone_number": state.phoneNumber.text,
      "country_id": "1",
      "email": state.email.text,
      "fax": state.fax.text,
      "address": state.address.text,
      if (state.selectedAvatarImage.value != null)
        "image": state.selectedAvatarImage.value,
      if (state.selectedCompanyImages.isNotEmpty)
        "images": state.selectedCompanyImages,
    };
  }
}
