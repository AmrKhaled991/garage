import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

class RegisterState {

  var name = TextEditingController();
  var email = TextEditingController();
  var phoneNumber = TextEditingController();
  var password = TextEditingController();
  var passwordConfirm = TextEditingController();

  var agreeTerms = false.obs;


  var selectedAvatarImage = Rx<AssetEntity?>(null);

  RegisterState() {
    ///Initialize variables
  }
}