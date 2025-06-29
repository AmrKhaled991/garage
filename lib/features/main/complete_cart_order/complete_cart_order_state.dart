import 'package:flutter/material.dart';
import 'package:garage/core/networking/loading_state.dart';
import 'package:garage/core/networking/models/payment.dart';
import 'package:get/get.dart';

class CompleteCartOrderState {
  var completeOrderLoading = LoadingState().obs;

  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var stateController = TextEditingController();
  var streetController = TextEditingController();
  var squareNumberController = TextEditingController();
  var jadaNumberController = TextEditingController();
  var notesController = TextEditingController();
  var payment = LoadingState<Payment?>().obs;

  CompleteCartOrderState() {
    ///Initialize variables
  }
}
