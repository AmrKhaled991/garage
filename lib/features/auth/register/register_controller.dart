import 'package:get/get.dart';
import 'package:garage/utils/utlis.dart';
import 'register_state.dart';

class RegisterController extends GetxController {
  final RegisterState state = RegisterState();

  bool validations() {
    if(state.phoneNumber.text.isBlank == true){
      Utils.showSnackBar("error_phone".tr);
      return false;
    }else if(state.password.text.isBlank == true){
      Utils.showSnackBar("error_password".tr);
      return false;
    }else if(state.passwordConfirm.text.isBlank == true){
      Utils.showSnackBar("error_password_confirm".tr);
      return false;
    }else if(state.password.text != state.passwordConfirm.text){
      Utils.showSnackBar("error_not_match".tr);
      return false;
    }
    return true;
  }

  Map<String, dynamic> getRegisterData() {
    Map<String, dynamic> result = {
      "name": state.name.text,
      "country_code": "965",
      "phone": state.phoneNumber.text,
      "email": state.email.text,
      "password": state.password.text,
      "password_confirmation": state.passwordConfirm.text,
      // "image": state.selectedAvatarImage.value,
    };

    print("register data: $result");
    return result;
  }
}
