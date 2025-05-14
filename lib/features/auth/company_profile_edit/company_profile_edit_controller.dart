import 'package:get/get.dart';

import 'company_profile_edit_state.dart';

class CompanyProfileEditController extends GetxController {
  final CompanyProfileEditState state = CompanyProfileEditState();

  bool validations() {

    return true;
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
      if(state.selectedAvatarImage.value != null)
        "image": state.selectedAvatarImage.value,
      if(state.selectedCompanyImages.isNotEmpty)
        "images": state.selectedCompanyImages,
    };
  }
}
