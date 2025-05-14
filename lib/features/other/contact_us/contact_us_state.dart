import 'package:flutter/material.dart';
import 'package:garage/core/networking/loading_state.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

class ContactUsState {


  var contactUsLoading = LoadingState().obs;

  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var emailController = TextEditingController();
  var messageController = TextEditingController();

  ContactUsState() {
    ///Initialize variables
  }
}
