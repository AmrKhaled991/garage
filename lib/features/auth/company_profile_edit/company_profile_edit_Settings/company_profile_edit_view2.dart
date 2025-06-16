import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:garage/features/auth/register/register_controller.dart';
import 'package:garage/features/main/common/add_container.dart';
import 'package:garage/features/main/common/text_header_widget.dart';
import 'package:get/get.dart';
import 'package:garage/theme/styles.dart';
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
      setState(() {
        selectedAsset = assets.first;
      });
      if (type == "main_image_of_project") {
        controller.setMainImage(assets.first);
      } else if (type == "upload_image") {
        controller.setImages(assets.first);
      } else {
        controller.setVideo(assets.first);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
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
                    : Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 22,
                        vertical: 14,
                      ),
                      decoration: MyshapesStyle.PrimaryDecoration,
                      child: Column(
                        spacing: 24,
                        children: [
                          Column(
                            spacing: 8,
                            children: [
                              FutureBuilder(
                                future: state.selectedCompanyImage.value?.file,
                                builder: (context, data) {
                                  if (data.hasData && data.data != null) {
                                    return ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.file(
                                        data.data as File,
                                        fit: BoxFit.cover,
                                        width: 88,
                                        height: 44,
                                      ),
                                    );
                                  } else {
                                    return Container(
                                      width: 88,
                                      height: 44,
                                      clipBehavior: Clip.antiAlias,
                                      decoration:
                                          MyshapesStyle.transparentDecoration,
                                    );
                                  }
                                },
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
            child: AddContainer(
              title: "upload_video_hint",
              padding: const EdgeInsets.symmetric(vertical: 24),
            ),
          ),
        ],
      ),
    );
  }
}
