import 'dart:async';
import 'dart:io';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:garage/core/controllers/user_controller.dart';
import 'package:garage/core/ui/MyButton.dart';
import 'package:garage/core/ui/MyLoadingButton.dart';
import 'package:garage/core/ui/my_image.dart';
import 'package:garage/core/ui/my_scaffold.dart';
import 'package:garage/core/ui/widgets/my_text_form.dart';
import 'package:garage/routes/app_pages.dart';
import 'package:garage/routes/arguments.dart';
import 'package:garage/theme/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rounded_loading_button_plus/rounded_loading_button.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';
import 'profile_edit_controller.dart';

class ProfileEditPage extends StatefulWidget {
  @override
  State<ProfileEditPage> createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends State<ProfileEditPage> {
  final controller = Get.find<ProfileEditController>();
  UserController userController = Get.find();
  final state = Get
      .find<ProfileEditController>()
      .state;


  Future<void> loadAssets(String type) async {
    final List<AssetEntity>? assets = await AssetPicker.pickAssets(context,
      pickerConfig: AssetPickerConfig(
          maxAssets: 1,
          requestType: RequestType.image,
          textDelegate: EnglishAssetPickerTextDelegate()
      ),);

    if (assets != null && assets.isNotEmpty) {
      if (type == "avatar") {
        state.selectedAvatarImage.value = assets.first;
      } else if (type == "cover") {
        state.selectedCoverImage.value = assets.first;
      } else {
        state.selectedDocumentImage.value = assets.first;
      }
    }
  }

  @override
  void initState() {
    var user = userController.user.value;
    if (user != null) {
      state.name.text = user.name ?? "";
      state.phoneNumber.text = user.phone ?? "";
      state.email.text = user.email ?? "";
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      title: "edit_profile".tr,
      body: ListView(
          children: <Widget>[
            Container(
              height: 130,
              child: Stack(
                children: [
                  // MyImage(image: "assets/images/bar_header.png",
                  //   width: 1.sw,
                  //   height: 130,
                  //   fit: BoxFit.fill,
                  // ),
                  Positioned.fill(
                      bottom: 0,
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Stack(
                          children: [
                            CircleAvatar(
                              radius: 50,
                              backgroundColor: colorLightGrey,
                              child: Obx(() {
                                return FutureBuilder(
                                    future: state.selectedAvatarImage.value?.file,
                                    builder: (context, data) {
                                      if (data.hasData && data.data != null) {
                                        return ClipOval(
                                            child: Image.file(
                                              data.data as File, fit: BoxFit.cover, width: 140, height: 140,));
                                      } else {
                                        return ClipOval(
                                          child: MyImage(
                                            image: userController.user.value?.image,
                                            fit: BoxFit.cover,
                                            width: 100,
                                            height: 100,
                                          ),
                                        );
                                      }
                                    }
                                );
                              }),
                            ),
                            Positioned(
                                bottom: 0,
                                left: 0,
                                child: InkWell(
                                    onTap: () {
                                      loadAssets("avatar");
                                    },
                                    child: CircleAvatar(
                                        backgroundColor: colorPrimary,
                                        child: Icon(Icons.camera_alt, size: 20,)))
                            )
                          ],
                        ),
                      )
                  ),
                ],
              ),
            ),
            userRegisterView(),
            const SizedBox(
              height: 16,
            ),
            MyButton(
              title: "change_password".tr,
              isOutline: true,
              textColor: Colors.black,
              onClick: (){
                Get.toNamed(Routes.CHANGE_PASSWORD);
              },
            ).marginAll(16),
            MyLoadingButton(
              title: "save".tr,
              onClick: (RoundedLoadingButtonController _controller) async {
                if (!controller.validations()) {
                  _controller.error();
                  Timer(const Duration(seconds: 1), () {
                    _controller.reset();
                  });
                  return;
                }

                if (isPhoneChanged()) {
                  _controller.reset();
                  bool result = await Get.toNamed(
                      Routes.OTP_VERIFY, arguments: {MyArguments.PHONE: state.phoneNumber.text});
                  if (result) {
                    userController.updateProfile(controller.requestData(), (success) {
                      if (success) {
                        _controller.success();
                      } else {
                        _controller.error();
                      }
                      Timer(const Duration(seconds: 1), () {
                        _controller.reset();
                      });
                    });
                  }
                } else {
                  userController.updateProfile(controller.requestData(), (success) {
                    if (success) {
                      _controller.success();
                    } else {
                      _controller.error();
                    }
                    Timer(const Duration(seconds: 1), () {
                      _controller.reset();
                    });
                  });
                }
              },
            ).marginAll(16),
            const SizedBox(
              height: 16,
            ),
          ]),
    );
  }

  Widget userRegisterView() =>
      Column(
        key: const ValueKey<int>(0),
        children: [
          MyTextForm(
            controller: state.name,
            hint: "name".tr,
            textInputType: TextInputType.text,
          ),
          const SizedBox(
            height: 16,
          ),
          MyTextForm(
            controller: state.phoneNumber,
            hint: "phone_number".tr,
            textInputType: TextInputType.phone,
          ),
          const SizedBox(
            height: 16,
          ),
          MyTextForm(
            controller: state.email,
            hint: "email".tr,
            textInputType: TextInputType.emailAddress,
          ),
        ],
      ).paddingAll(16);


  bool isPhoneChanged() => userController.user.value?.phone != state.phoneNumber.text;
}
