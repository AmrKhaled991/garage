import 'package:flutter/material.dart';
import 'package:garage/features/main/add_new_address/add_new_address_logic.dart';
import 'package:get/get.dart';

class AddNewAddressBinding extends Bindings {
  
  @override
  void dependencies() {
    Get.lazyPut(() => AddNewAddressController());
  }
}
