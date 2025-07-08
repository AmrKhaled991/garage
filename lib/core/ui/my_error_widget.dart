import 'package:garage/core/controllers/user_controller.dart';
import 'package:garage/core/ui/my_image.dart';
import 'package:garage/routes/app_pages.dart';
import 'package:garage/theme/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyErrorWidget extends StatelessWidget {
  UserController userController = Get.find();

  final VoidCallback? onRetryCall;
  final String? errorMsg;
  final String? errorImage;
  final bool withLogin;
  final bool withPadding;
  final ErrorType errorType;

  MyErrorWidget({
    this.onRetryCall,
    this.errorMsg,
    this.errorImage,
    this.withLogin = false,
    this.withPadding = false,
    this.errorType = ErrorType.NETWORK,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String _errorImage() {
      if (errorType == ErrorType.EMPTY) {
        return "assets/images/no_data.png";
      } else if (errorType == ErrorType.API && errorMsg?.isNotEmpty == true) {
        return "assets/images/api_error.png";
      } else {
        return "assets/images/network_error.png";
      }
    }

    return Container(
      alignment: Alignment.center,
      margin: withPadding ? EdgeInsets.only(top: Get.height / 4) : null,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          MyImage(image: errorImage ?? _errorImage(), height: 100),
          Text(
            errorMsg ?? "error_try_again".tr,
            textAlign: TextAlign.center,
            style: MyTextStyle.myBlackSubTitle.copyWith(color: Colors.white),
          ),
          Visibility(
            visible: onRetryCall != null && errorType != ErrorType.EMPTY,
            child: TextButton.icon(
              label: Text("retry".tr, style: MyTextStyle.myBlackSubTitle),
              icon: const Icon(Icons.refresh),
              onPressed: onRetryCall,
            ).marginSymmetric(horizontal: 20),
          ),
          Visibility(
            visible: withLogin && !userController.isLogged.value,
            child: TextButton(
              child: Text("login".tr, style: MyTextStyle.myBlackSubTitle),
              onPressed: () {
                Get.toNamed(Routes.LOGIN);
              },
            ).marginSymmetric(horizontal: 20),
          ),
        ],
      ),
    );
  }
}

enum ErrorType { EMPTY, API, NETWORK }
