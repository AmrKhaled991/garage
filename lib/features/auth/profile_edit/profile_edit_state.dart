import 'package:flutter/cupertino.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

class ProfileEditState {
  var name = TextEditingController().obs;
  var phoneNumber = TextEditingController().obs;
  var email = TextEditingController().obs;

  var companyName = "".obs;
  var companyWorkTime = "".obs;

  var companyNameError = Rx<String?>(null);
  var companyWorkTimeError = Rx<String?>(null);

  var selectedAvatarImage = Rx<AssetEntity?>(null);
  var selectedCoverImage = Rx<AssetEntity?>(null);
  var selectedDocumentImage = Rx<AssetEntity?>(null);

  var deliveryEnable = false.obs;

  var facebook = Rx<String?>(null);
  var twitter = Rx<String?>(null);
  var instagram = Rx<String?>(null);
  var tiktok = Rx<String?>(null);
  var website = Rx<String?>(null);

  ProfileEditState() {
    ///Initialize variables
  }
}
