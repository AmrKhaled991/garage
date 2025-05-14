import 'package:get/get.dart';
import 'package:garage/utils/utlis.dart';

import 'login_state.dart';

class LoginController extends GetxController {
  final LoginState state = LoginState();

  bool validations() {
    if(state.phoneOrEmail.text.isBlank == true){
      Utils.showSnackBar("error_phone".tr);
      return false;
    }else if(state.password.text.isBlank == true){
      Utils.showSnackBar("error_password".tr);
      return false;
    }else{
      return true;
    }
  }
}
