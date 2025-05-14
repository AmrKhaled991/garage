import 'package:garage/core/networking/loading_state.dart';
import 'package:get/get.dart';
import 'package:garage/core/repositories/contact_us_repository.dart';
import 'package:garage/utils/utlis.dart';

import 'contact_us_state.dart';

class ContactUsController extends GetxController {
  final ContactUsState state = ContactUsState();
  final ContactUsRepository contactUsRepository = Get.find();

  bool validation(){
    if (state.nameController.text.isEmpty) {
      Utils.showSnackBar("error_name".tr);
      return false;
    } else if (state.phoneController.text.isEmpty) {
      Utils.showSnackBar("error_phone".tr);
      return false;
    } else if (state.emailController.text.isEmpty) {
      Utils.showSnackBar("error_mail".tr);
      return false;
    } else if (state.messageController.text.isEmpty) {
      Utils.showSnackBar("error_message".tr);
      return false;
    }
    return true;
  }

  void contactUs(Map<String, String> data, Function(bool) onFinish) async{
    state.contactUsLoading.value = LoadingState.loading();
    state.contactUsLoading.value = await contactUsRepository.contactUs(data);
    onFinish.call(state.contactUsLoading.value.success);
    if(state.contactUsLoading.value.success == false){
      Utils.showSnackBar(state.contactUsLoading.value.message);
    }
  }
}
