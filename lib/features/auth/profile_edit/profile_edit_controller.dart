import 'package:garage/core/controllers/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:garage/utils/utlis.dart';
import 'profile_edit_state.dart';

class ProfileEditController extends GetxController {
  final ProfileEditState state = ProfileEditState();
  UserController userController = Get.find();


  bool validations() {
    if(state.name.text.isBlank == true){
      Utils.showSnackBar("error_name".tr);
      return false;
    }else if(state.phoneNumber.text.isBlank == true){
      Utils.showSnackBar("error_phone".tr);
      return false;
    }else{
      return true;
    }
  }

  Map<String, dynamic> requestData() {
    Map<String, dynamic> data = {
      "email": state.email.text,
      "name": state.name.text,
      "phone_code": "965",
      "mobile": state.phoneNumber.text,
      "image": state.selectedAvatarImage.value
    };
    print("update data: $data");
    return data;
  }
}
