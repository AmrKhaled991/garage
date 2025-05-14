import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:garage/features/auth/company_profile_edit/company_profile_edit_controller.dart';
import 'package:garage/features/auth/company_profile_edit/company_profile_edit_state.dart';
import 'package:get/get.dart';
import 'package:garage/core/controllers/user_controller.dart';
import 'package:garage/core/ui/MyLoadingButton.dart';
import 'package:garage/core/ui/my_image.dart';
import 'package:garage/theme/styles.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rounded_loading_button_plus/rounded_loading_button.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

class CompanyProfileEditView2 extends StatefulWidget {
  const CompanyProfileEditView2({Key? key}) : super(key: key);

  @override
  State<CompanyProfileEditView2> createState() =>
      _CompanyProfileEditView2State();
}

class _CompanyProfileEditView2State extends State<CompanyProfileEditView2> {
  final CompanyProfileEditController controller = Get.put(
    CompanyProfileEditController(),
  );

  final CompanyProfileEditState state =
      Get.find<CompanyProfileEditController>().state;

  UserController userController = Get.find();

  Future<void> loadAssets(String type) async {
    final List<AssetEntity>? assets = await AssetPicker.pickAssets(
      context,
      pickerConfig: AssetPickerConfig(
        maxAssets: type == "avatar" ? 1 : 5,
        requestType: RequestType.image,
        textDelegate: const EnglishAssetPickerTextDelegate(),
      ),
    );

    if (assets != null && assets.isNotEmpty) {
      if (type == "avatar") {
        var file = await assets.first.file;
        if (file != null) {
          var xfile = await compressImageAndGetFile(file);
          state.selectedAvatarImage.value = xfile?.path;
        }
      } else {
        assets.forEach((element) async {
          var file = await element.file;
          if (file != null) {
            var xfile = await compressImageAndGetFile(file);
            state.selectedCompanyImages.add(xfile?.path ?? "");
          }
        });
      }
    }
  }

  Future<XFile?> compressImageAndGetFile(File file) async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String appDocPath = appDocDir.path;
    // final extension = p.extension(file.absolute.path);

    var result = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path,
      appDocPath + "/${DateTime.now().millisecondsSinceEpoch}.jpeg",
      quality: 88,
      format: CompressFormat.jpeg,
    );

    print(
      "original file: ${file.absolute.path}\ncompresed file: ${result?.path}",
    );
    // print(file.lengthSync());
    // print(result.lengthSync());

    return result;
  }

  @override
  void initState() {
    var user = userController.user.value;
    if (user != null) {
      state.phoneNumber.text = user.phone ?? "";
      state.email.text = user.email ?? "";
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        SizedBox(
          height: 160,
          child: Stack(
            children: [
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
                          return state.selectedAvatarImage.value != null
                              ? ClipOval(
                                child: Image.file(
                                  File(state.selectedAvatarImage.value ?? ""),
                                  fit: BoxFit.cover,
                                  width: 100,
                                  height: 100,
                                ),
                              )
                              : ClipOval(
                                child: MyImage(
                                  image: userController.user.value?.image,
                                  fit: BoxFit.cover,
                                  width: 100,
                                  height: 100,
                                ),
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
        editForm(),
        const SizedBox(height: 16),
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

            userController.updateProfile(controller.updateDate(), (success) {
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
      ],
    );
  }

  Widget editForm() => Column(
    key: const ValueKey<int>(0),
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      
    
      const SizedBox(height: 16),
      Text("company_images".tr, style: MyTextStyle.myBlackBoldTitle),
      const SizedBox(height: 16),
      GestureDetector(
        onTap: () {
          loadAssets("images");
        },
        child: Container(
          decoration: BoxDecoration(
            color: colorContainer,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: colorContainerBorder),
          ),
          width: Get.width,
          height: Get.width * 0.3,
          alignment: Alignment.center,
          child: MyImage(
            image: "assets/images/ic_images.svg",
            height: Get.width * 0.1,
          ),
        ),
      ),
    ],
  );
}
