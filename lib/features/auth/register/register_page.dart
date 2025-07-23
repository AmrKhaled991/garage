import 'dart:async';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:garage/core/ui/MyButton.dart';
import 'package:garage/core/controllers/main_controller.dart';
import 'package:garage/core/controllers/user_controller.dart';
import 'package:garage/core/ui/MyLoadingButton.dart';
import 'package:garage/core/ui/my_scaffold.dart';
import 'package:garage/core/ui/widgets/my_text_form.dart';
import 'package:garage/routes/app_pages.dart';
import 'package:garage/theme/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rounded_loading_button_plus/rounded_loading_button.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';
import 'register_controller.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  UserController userController = Get.find();
  MainController mainController = Get.find();
  final controller = Get.find<RegisterController>();
  final state = Get.find<RegisterController>().state;

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: <Widget>[
            const SizedBox(height: 30),
            UserTypeSelector(controller: controller),
            const SizedBox(height: 30),
            userRegisterView(),
            SizedBox(height: 100.h),
            // const Spacer(),
            Obx(() {
              var userType = controller.state.userType.value;
              return MyLoadingButton(
                title: "create_account".tr,
                onClick: (RoundedLoadingButtonController _controller) async {
                  if (!controller.validations()) {
                    _controller.error();
                    Timer(const Duration(seconds: 1), () {
                      _controller.reset();
                    });
                    return;
                  }

                  if (userType == 1) {
                    var data = await controller.getRegisterData();
                    userController.register(data, (success) async {
                      if (success) {
                        _controller.success();
                      } else {
                        _controller.error();
                      }
                      Timer(const Duration(seconds: 1), () {
                        _controller.reset();
                      });
                    });
                  } else {
                    Get.toNamed(Routes.COMPANY_PROFILE_EDIT);
                    _controller.reset();
                  }
                },
              );
            }),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("have_account".tr, style: MyTextStyle.myWhiteSubTitle),
                const SizedBox(width: 4),
                InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Text(
                    "sign_in".tr,
                    style: MyTextStyle.myPrimarySubTitle,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget userRegisterView() => Column(
    key: const ValueKey<int>(0),
    children: [
      // Stack(
      //   children: [
      //     CircleAvatar(
      //       radius: 70,
      //       backgroundColor: colorLightGrey,
      //       child: FutureBuilder(
      //           future: state.selectedAvatarImage.value?.file,
      //           builder: (context, data) {
      //             if (data.hasData && data.data != null) {
      //               return ClipOval(
      //                   child: Image.file(data.data as File, fit: BoxFit.cover, width: 140, height: 140,));
      //             } else {
      //               return Center(
      //                 child: Text("technical_photo".tr, style: MyTextStyle.myBlackSubTitle,),
      //               );
      //             }
      //           }
      //       ),
      //     ),
      //     Positioned(
      //         bottom: 0,
      //         left: 0,
      //         child: InkWell(
      //             onTap: () {
      //               loadAssets("avatar");
      //             },
      //             child: CircleAvatar(
      //               backgroundColor: colorPrimary,
      //                 child: Icon(Icons.camera_alt, size: 20,)))
      //     )
      //   ],
      // ),
      // const SizedBox(
      //   height: 16,
      // ),
      MyTextForm(
        controller: state.name,
        hint: "name".tr,
        textInputType: TextInputType.text,
      ),
      const SizedBox(height: 16),
      MyTextForm(
        hasIconConstraints: false,
        controller: state.phoneNumber,
        hint: "phone_number".tr,
        textInputType: TextInputType.phone,
      ),
      const SizedBox(height: 16),
      MyTextForm(
        controller: state.email,
        hint: "email".tr,
        textInputType: TextInputType.emailAddress,
      ),
      const SizedBox(height: 16),
      MyTextForm(
        controller: state.password,
        hint: "password".tr,
        isPassword: true,
        textInputType: TextInputType.text,
      ),
      const SizedBox(height: 16),
      MyTextForm(
        controller: state.passwordConfirm,
        hint: "password_confirm".tr,
        isPassword: true,
        textInputType: TextInputType.text,
      ),
      const SizedBox(height: 16),
    ],
  );
}

class UserTypeSelector extends StatelessWidget {
  final RegisterController controller;
  const UserTypeSelector({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    // Assuming userType is an RxInt in RegisterState
    return Obx(() {
      return Row(
        children: [
          Expanded(
            child: MyButton(
              color:
                  controller.state.userType.value == 1
                      ? colorPrimary
                      : colorContainer,
              textColor:
                  controller.state.userType.value == 1
                      ? colorBlack
                      : Colors.white,
              borderRadius: 8,
              title: "person".tr,
              onClick: () {
                if (controller.state.userType.value != 1) {
                  controller.state.userType.value = 1;
                }
              },
            ),
          ),
          Expanded(
            child: MyButton(
              color:
                  controller.state.userType.value == 2
                      ? colorPrimary
                      : colorContainer,
              textColor:
                  controller.state.userType.value == 2
                      ? colorBlack
                      : Colors.white,
              borderRadius: 8,
              title: "company".tr,
              onClick: () {
                if (controller.state.userType.value != 2) {
                  controller.state.userType.value = 2;
                }
              },
            ),
          ),
        ],
      );
    });
  }
}
