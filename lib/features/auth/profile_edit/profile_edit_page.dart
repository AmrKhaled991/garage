import 'dart:async';
import 'dart:io';
import 'package:garage/core/controllers/user_controller.dart';
import 'package:garage/core/ui/MyLoadingButton.dart';
import 'package:garage/core/ui/my_image.dart';
import 'package:garage/core/ui/my_scaffold.dart';
import 'package:garage/core/ui/widgets/my_text_form.dart';
import 'package:garage/theme/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rounded_loading_button_plus/rounded_loading_button.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';
import 'profile_edit_controller.dart';

class ProfileEditPage extends StatefulWidget {
  const ProfileEditPage({super.key});

  @override
  State<ProfileEditPage> createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends State<ProfileEditPage> {
  final controller = Get.find<ProfileEditController>();
  UserController userController = Get.find();
  final state = Get.find<ProfileEditController>().state;

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
      if (type == "avatar") {
        controller.updateUserProfileImage(assets.first);
      } else if (type == "cover") {
        state.selectedCoverImage.value = assets.first;
      } else {
        state.selectedDocumentImage.value = assets.first;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      title: "account_info".tr,
      body: ListView(
        children: <Widget>[
          SizedBox(
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
                                      data.data as File,
                                      fit: BoxFit.cover,
                                      width: 140,
                                      height: 140,
                                    ),
                                  );
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
                              },
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
                            child: const CircleAvatar(
                              backgroundColor: colorPrimary,
                              child: Icon(Icons.camera_alt, size: 20),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          userRegisterView(),
          const SizedBox(height: 16),

          Obx(() {
            return Visibility(
              visible: controller.isChanging.value,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: MyLoadingButton(
                  title: "update_profile".tr,
                  onClick: (RoundedLoadingButtonController _controller) {
                    if (!controller.validations()) {
                      _controller.error();
                      Timer(const Duration(seconds: 1), () {
                        _controller.reset();
                      });
                      return;
                    }
                    controller.updateProfile(
                      onFinish: (success) async {
                        if (success) {
                          _controller.success();
                          userController.fetchProfile();
                        } else {
                          _controller.error();
                        }
                        Timer(const Duration(seconds: 1), () {
                          _controller.reset();
                        });
                      },
                    );
                  },
                ),
              ),
            );
          }),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget userRegisterView() => Column(
    key: const ValueKey<int>(0),
    children: [
      MyTextForm(
        controller: state.name.value,
        hint: "name".tr,
        textInputType: TextInputType.text,
      ),
      const SizedBox(height: 16),
      MyTextForm(
        controller: state.email.value,
        hint: "email".tr,
        textInputType: TextInputType.emailAddress,
      ),
      const SizedBox(height: 16),
      MyTextForm(
        controller: state.phoneNumber.value,
        hint: "phone_number".tr,
        textInputType: TextInputType.phone,
      ),
    ],
  ).paddingAll(16);
}
