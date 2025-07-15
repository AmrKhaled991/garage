import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:garage/features/auth/register/register_controller.dart';
import 'package:garage/features/main/common/add_container.dart';
import 'package:garage/features/main/common/text_header_widget.dart';
import 'package:garage/utils/utlis.dart';
import 'package:get/get.dart';
import 'package:garage/theme/styles.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

class CompanyProfileEditView2 extends StatefulWidget {
  const CompanyProfileEditView2({Key? key}) : super(key: key);

  @override
  State<CompanyProfileEditView2> createState() =>
      _CompanyProfileEditView2State();
}

class _CompanyProfileEditView2State extends State<CompanyProfileEditView2> {
  final RegisterController controller = Get.find<RegisterController>();
  final state = Get.find<RegisterController>().state;

  AssetEntity? selectedAsset;
  // Future<bool> requestPermissions() async {
  //   if (Platform.isAndroid) {
  //     var status =
  //         await Permission.storage
  //             .request(); // or Permission.mediaLibrary for Android 13+
  //     return status.isGranted;
  //   } else if (Platform.isIOS) {
  //     var status = await Permission.photos.request(); // iOS photo/video access
  //     return status.isGranted;
  //   }
  //   return false;
  // }

  Future<void> loadAssets(String type) async {
    if (type == 'upload_video') {
      // if (await requestPermissions()) {
      final List<AssetEntity>? assets = await AssetPicker.pickAssets(
        context,
        pickerConfig: const AssetPickerConfig(
          maxAssets: 1,
          requestType: RequestType.video,
          textDelegate: EnglishAssetPickerTextDelegate(),
        ),
      );
      assets != null ? controller.setVideo(assets.first) : null;
      setState(() {});
      // } else {
      //   Utils.showSnackBar("plese_grant_permission".tr);
      // }
    } else {
      final List<AssetEntity>? assets = await AssetPicker.pickAssets(
        context,
        pickerConfig: AssetPickerConfig(
          maxAssets: type == "main_image_of_project" ? 1 : 10,
          requestType: RequestType.image,
          textDelegate: const EnglishAssetPickerTextDelegate(),
        ),
      );

      if (assets != null && assets.isNotEmpty) {
        setState(() {
          selectedAsset = assets.first;
        });
        if (type == "main_image_of_project") {
          controller.setMainImage(assets.first);
        } else if (type == "upload_images") {
          controller.setImages(assets);
        } else {}
      }
    }
  }

  @override
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        spacing: 24,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Logo Upload
          Text(
            "upload_company_logo".tr,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 32,
              fontFamily: 'Zain',
              fontWeight: FontWeight.w700,
            ),
          ),
          AddContainer(
            onTap: () {
              state.selectedCompanyImage.value == null
                  ? loadAssets("main_image_of_project")
                  : controller.resetMainImage();
              setState(() {});
            },
            title: "add_logo".tr,
            content:
                state.selectedCompanyImage.value == null
                    ? null
                    : _buildImagePreview(
                      state.selectedCompanyImage.value!,
                      isSingle: true,
                    ),
          ),

          // Gallery Upload
          TextHeaderWidget(
            title: "company_gallery".tr,
            child: AddContainer(
              title: "company_gallery_hint".tr,
              onTap: () {
                state.galleryImages.isEmpty
                    ? loadAssets("upload_images")
                    : controller.resetImages();
                setState(() {});
              },
              content:
                  state.galleryImages.value.where((e) => e != null).isEmpty
                      ? null
                      : Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children:
                            state.galleryImages.value
                                .whereType<AssetEntity>()
                                .map((asset) => _buildImagePreview(asset))
                                .toList(),
                      ),
            ),
          ),

          // Video Upload
          TextHeaderWidget(
            title: "upload_video".tr,
            child: AddContainer(
              title: "upload_video_hint".tr,
              onTap: () {
                state.video.value == null
                    ? loadAssets("upload_video")
                    : controller.resetMainImage();
              },

              content:
                  state.video.value == null
                      ? null
                      : _buildImagePreview(
                        state.video.value!,
                        isVideo: true,
                        isSingle: true,
                      ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImagePreview(
    AssetEntity asset, {
    bool isVideo = false,
    bool isSingle = false,
  }) {
    return FutureBuilder<File?>(
      future: asset.file,
      builder: (context, snapshot) {
        if (!snapshot.hasData || snapshot.data == null) {
          return const SizedBox.shrink();
        }

        return Stack(
          children: [
            if (isVideo) ...[
              FutureBuilder(
                future: asset.thumbnailDataWithSize(
                  const ThumbnailSize(200, 200),
                ), // from AssetEntity
                builder: (_, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done &&
                      snapshot.hasData) {
                    return Image.memory(
                      snapshot.data!,
                      width: isSingle ? 88 : 60,
                      height: isSingle ? 44 : 60,
                      fit: BoxFit.cover,
                    );
                  } else {
                    return Container(
                      width: isSingle ? 88 : 60,
                      height: isSingle ? 44 : 60,
                      color: Colors.grey.shade300,
                      child: const Center(
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                    );
                  }
                },
              ),
            ] else
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.file(
                  snapshot.data!,
                  width: isSingle ? 88 : 60,
                  height: isSingle ? 44 : 60,
                  fit: BoxFit.cover,
                ),
              ),
            Positioned(
              top: 0,
              right: 0,
              child: InkWell(
                onTap: () {
                  if (isVideo) {
                    controller.state.video.value = null;
                  } else if (isSingle) {
                    controller.resetMainImage();
                  } else {
                    controller.state.galleryImages.value.remove(asset);
                  }
                  setState(() {});
                },
                child: const Icon(Icons.close, color: Colors.red, size: 20),
              ),
            ),
          ],
        );
      },
    );
  }
}
