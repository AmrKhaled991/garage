import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

class CompanyProfileEditState {

  var companyDescription = TextEditingController();
  var website = TextEditingController();
  var phoneNumber = TextEditingController();
  var email = TextEditingController();
  var fax = TextEditingController();
  var address = TextEditingController();
  var location = TextEditingController();


  var selectedAvatarImage = Rx<String?>(null);
  var selectedCompanyImages = RxList<String>([]);

  var imagesToRemove = RxList<String>([]); // media ids

  CompanyProfileEditState() {
    ///Initialize variables
  }
}
