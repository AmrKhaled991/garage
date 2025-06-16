import 'package:flutter/material.dart';
import 'package:garage/core/networking/loading_state.dart';
import 'package:get/get.dart';

class AddCarState {
  Rx<int?> brandId = Rx<int?>(null);
  var model = TextEditingController();
  var year = TextEditingController();
  var carOwnerName = TextEditingController();
  var addCar = LoadingState<dynamic>().obs;

  AddCarState() {
    ///Initialize variables
  }
}
