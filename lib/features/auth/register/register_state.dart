import 'package:flutter/material.dart';
import 'package:garage/features/auth/company_profile_edit/models/time_slot.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

class RegisterState {
  var name = TextEditingController();
  var email = TextEditingController();
  var phoneNumber = TextEditingController();
  var password = TextEditingController();
  var passwordConfirm = TextEditingController();
  var userType = 1.obs; // user or garage

  var agreeTerms = false.obs;

  var workTypeId = 0.obs;
  var description = TextEditingController();

  var directPhone = TextEditingController();
  var commercialRegistrationNumber = TextEditingController();
  var whatsapp = TextEditingController();
  var website = TextEditingController();
  var instagram = TextEditingController();
  var twitter = TextEditingController();
  var tiktok = TextEditingController();
  var snapchat = TextEditingController();
  var youtube = TextEditingController();
  var lat = 0.0.obs;
  var lng = 0.0.obs;
  var mapDesc = TextEditingController();
  Rx<AssetEntity?> selectedCompanyImage = Rx<AssetEntity?>(null);
  RxList<AssetEntity?> galleryImages = List<AssetEntity?>.filled(9, null).obs;
  Rx<AssetEntity?> video = Rx<AssetEntity?>(null);
  var listTimeSlot = <TimeSlot>[].obs;
  RegisterState() {
    ///Initialize variables
  }
}
