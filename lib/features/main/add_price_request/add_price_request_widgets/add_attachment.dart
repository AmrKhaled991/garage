// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:garage/core/ui/LoadingWidget.dart';
import 'package:garage/core/ui/select_drop_list%20.dart';
import 'package:garage/features/main/add_price_request/add_price_request_controller.dart';
import 'package:garage/features/main/add_price_request/add_price_request_page.dart';
import 'package:garage/features/main/add_price_request/add_price_request_state.dart';
import 'package:garage/theme/styles.dart';
import 'package:garage/utils/utlis.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

class AddAttachment extends StatefulWidget {
  final AddPriceRequestController controller;
  final AddPriceRequestState state;

  const AddAttachment({Key? key, required this.controller, required this.state})
    : super(key: key);

  @override
  State<AddAttachment> createState() => _AddAttachmentState();
}

class _AddAttachmentState extends State<AddAttachment> {
  Future<bool> requestPermissions() async {
    if (Platform.isAndroid) {
      var status =
          await Permission.storage
              .request(); // or Permission.mediaLibrary for Android 13+
      return status.isGranted;
    } else if (Platform.isIOS) {
      var status = await Permission.photos.request(); // iOS photo/video access
      return status.isGranted;
    }
    return false;
  }

  Future<void> loadAssets() async {
    // if (await requestPermissions()) {
    final List<AssetEntity>? assets = await AssetPicker.pickAssets(
      context,
      pickerConfig: const AssetPickerConfig(
        maxAssets: 1,
        requestType: RequestType.image,
        textDelegate: EnglishAssetPickerTextDelegate(),
      ),
    );
    // );

    if (assets != null && assets.isNotEmpty) {
      widget.controller.addAttachment(assets.first);
    }
    // } else {
    //   Utils.showSnackBar("plese_grant_permission".tr);
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final selectedAsset = widget.state.selectedAsset.value;

      return InkWell(
        onTap: () => loadAssets(),
        child: Container(
          decoration: MyshapesStyle.PrimaryDecoration,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (selectedAsset == null) ...[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "add_attachment".tr,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontFamily: 'Zain',
                        fontWeight: FontWeight.w400,
                        height: 1.20,
                      ),
                    ),
                    Text(
                      "file_size".tr,
                      style: const TextStyle(
                        color: Color(0xFFCCCAC7),
                        fontSize: 14,
                        fontFamily: 'Zain',
                        fontWeight: FontWeight.w400,
                        height: 1.20,
                      ),
                    ),
                  ],
                ),
                const Icon(Icons.attach_file_rounded, color: Colors.white),
              ] else ...[
                _buildImagePreview(selectedAsset),
              ],
            ],
          ),
        ),
      );
    });
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
                  widget.controller.removeAttachment();
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

class WorkCategoriesDropDown extends StatefulWidget {
  final AddPriceRequestController controller;
  final AddPriceRequestState state;
  final Function(OptionItem)?  onOptionSelected;
  const WorkCategoriesDropDown({
    super.key,
    required this.controller,
    required this.state,
    this.onOptionSelected,
  });
  @override
  State<WorkCategoriesDropDown> createState() => _WorkCategoriesDropDownState();
}

class _WorkCategoriesDropDownState extends State<WorkCategoriesDropDown> {
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return LoadingWidget(
        loadingState: widget.state.categoriesList.value,
        child: SelectDropList(
          selectedItem:
              widget.controller.state.categoryItem.value ??
              OptionItem(id: null, title: null),
          dropListModel: DropListModel(
            widget.state.categoriesList.value.data != null
                ? widget.state.categoriesList.value.data!
                    .map((e) => OptionItem(id: e.id?.toInt(), title: e.name))
                    .toList()
                : [],
          ),
          onOptionSelected: (item) {
            widget.onOptionSelected?.call(item);
            widget.controller.setCategoryItem(item);
          },
          selectedTextStyle: const TextStyle(color: colorWhite, fontSize: 18),
          dropDownDecoration: const BoxDecoration(color: colorContainer),
          itemTextStyle: const TextStyle(color: colorWhite),
          iconColor: colorWhite,
          boxDecoration: BoxDecoration(
            color: colorContainer,
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      );
    });
  }
}
