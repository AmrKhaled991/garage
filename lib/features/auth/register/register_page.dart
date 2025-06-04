import 'dart:async';
import 'package:garage/core/ui/MyButton.dart';
import 'package:garage/core/ui/my_image.dart';
import 'package:garage/core/controllers/main_controller.dart';
import 'package:garage/core/controllers/user_controller.dart';
import 'package:garage/core/ui/MyLoadingButton.dart';
import 'package:garage/core/ui/my_scaffold.dart';
import 'package:garage/core/ui/widgets/custom_country_code_and_flag.dart';
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

  Future<void> loadAssets(String type) async {
    final List<AssetEntity>? assets = await AssetPicker.pickAssets(
      context,
      pickerConfig: const AssetPickerConfig(
        maxAssets: 1,
        requestType: RequestType.image,
        textDelegate: EnglishAssetPickerTextDelegate(),
      ),
    );

    if (assets != null && assets.isNotEmpty) {
      state.selectedAvatarImage.value;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: <Widget>[
            const SizedBox(height: 30),

            const UserTypeSelector(),
            const SizedBox(height: 30),
            userRegisterView(),

            const Spacer(),
            MyLoadingButton(
              title: "create_account".tr,
              onClick: (RoundedLoadingButtonController _controller) {
                if (!controller.validations()) {
                  _controller.error();
                  Timer(const Duration(seconds: 1), () {
                    _controller.reset();
                  });
                  return;
                }

                userController.register(controller.getRegisterData(), (
                  success,
                ) async {
                  if (success) {
                    _controller.success();
                  } else {
                    _controller.error();
                  }
                  Timer(const Duration(seconds: 1), () {
                    _controller.reset();
                  });
                });
              },
            ),
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

class UserTypeSelector extends StatefulWidget {
  const UserTypeSelector({super.key});

  @override
  State<UserTypeSelector> createState() => _UserTypeSelectorState();
}

class _UserTypeSelectorState extends State<UserTypeSelector> {
  List<String> userTypes = ["person", "company"];
  String? selectedUserType = "person";

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 8,
      children: [
        Expanded(
          child: MyButton(
            color:
                selectedUserType == userTypes[0]
                    ? colorPrimary
                    : colorContainer,
            textColor:
                selectedUserType == userTypes[0] ? colorBlack : Colors.white,

            borderRadius: 8,
            title: userTypes[0].tr,
            onClick: () {
              if (selectedUserType == userTypes[0]) return;
              setState(() {
                selectedUserType = userTypes[0];
              });
            },
          ),
        ),
        Expanded(
          child: MyButton(
            borderRadius: 8,
            color:
                selectedUserType == userTypes[1]
                    ? colorPrimary
                    : colorContainer,
            textColor:
                selectedUserType == userTypes[1] ? colorBlack : Colors.white,
            title: userTypes[1].tr,
            onClick: () {
              if (selectedUserType == userTypes[1]) return;
              setState(() {
                selectedUserType = userTypes[1];
              });
            },
          ),
        ),
      ],
    );
  }
}
