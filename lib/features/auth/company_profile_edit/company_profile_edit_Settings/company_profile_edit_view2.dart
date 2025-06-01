import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:garage/features/auth/company_profile_edit/company_profile_edit_controller.dart';
import 'package:garage/features/auth/company_profile_edit/company_profile_edit_state.dart';
import 'package:garage/features/main/common/add_container.dart';
import 'package:garage/features/main/common/text_header_widget.dart';
import 'package:garage/features/main/home/widgets/custom_category_card.dart';
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
    return const UploadCompanyAssetsScreen();

    ListView(
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

class UploadCompanyAssetsScreen extends StatelessWidget {
  const UploadCompanyAssetsScreen({
    super.key,
    this.onPickLogo,
    this.onRemoveLogo,
    this.onPickImages,
    this.onPickVideo,
  });

  /// Callback for picking a single logo image.
  final VoidCallback? onPickLogo;

  /// Callback for removing the selected logo.
  final VoidCallback? onRemoveLogo;

  /// Callback for picking multiple images (max 10, each ≤ 1 MB).
  final VoidCallback? onPickImages;

  /// Callback for picking a video file (≤ 20 MB).
  final VoidCallback? onPickVideo;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SingleChildScrollView(
      child: Column(
        spacing: 24,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            width: 343,
            height: 48,
            child: Text(
              "upload_company_logo".tr,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 32,
                fontFamily: 'Zain',
                fontWeight: FontWeight.w700,
                height: 1.50,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
              decoration: MyshapesStyle.PrimaryDecoration,
              child: Column(
                spacing: 24,
                children: [
                  Column(
                    spacing: 8,
                    children: [
                      Container(
                        width: 88,
                        height: 44,
                        clipBehavior: Clip.antiAlias,
                        decoration: MyshapesStyle.transparentDecoration,
                      ),
                      Text(
                        "delete".tr,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.red,
                          fontSize: 14,
                          fontFamily: 'Zain',
                          fontWeight: FontWeight.w400,
                          height: 1.50,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          TextHeaderWidget(
            title: "company_gallery".tr,
            child: AddContainer(
              title: "company_gallery_hint".tr,
              padding: const EdgeInsets.symmetric(vertical: 24),
            ),
          ),

          TextHeaderWidget(
            title: "upload_video".tr,
            child:  AddContainer(
              title: "upload_video_hint",
              padding: EdgeInsets.symmetric(vertical: 24),
            ),
          ),
        ],
      ),
    );
  }
}

/// Reusable section widget with title, content, optional footer and action.
class _Section extends StatelessWidget {
  const _Section({
    required this.title,
    required this.child,
    this.footer,
    this.action,
  });

  final String title;
  final Widget child;
  final Widget? footer;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
            if (action != null) action!,
          ],
        ),
        const SizedBox(height: 12),
        child,
        if (footer != null) ...[const SizedBox(height: 8), footer!],
      ],
    );
  }
}

/// Dashed border box used for adding files.
class _DashedBox extends StatelessWidget {
  const _DashedBox({super.key, required this.child, this.onTap});

  final Widget child;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 120,
        decoration: BoxDecoration(
          color: const Color(0xFF1E1E1E),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: Colors.white24,
            width: 2,
            style: BorderStyle.solid, // Use a package for real dashed border.
          ),
        ),
        child: Center(child: child),
      ),
    );
  }
}
