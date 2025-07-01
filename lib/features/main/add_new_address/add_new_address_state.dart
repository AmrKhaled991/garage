import 'package:flutter/material.dart';
import 'package:garage/core/networking/loading_state.dart';
import 'package:get/get.dart';

class AddNewAddressState {
  var details = TextEditingController();
  var extraDetails = TextEditingController();
  var name = TextEditingController();
  var lat = RxnDouble(null);
  var lng = RxnDouble(null);
  var mapDesc = RxnString(null);
  var timeId=RxnInt(null);
  var isActive = false.obs;
  var isDefault = false.obs;
  var isLoading = LoadingState().obs;
  AddNewAddressState() {
    ///Initialize variables
  }

}
