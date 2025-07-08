import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:garage/core/networking/models/address.dart';
import 'package:get/get.dart';
import 'package:garage/core/controllers/address_controller.dart';
import 'package:garage/core/ui/LoadingWidget.dart';
import 'package:garage/theme/styles.dart';

class AreaSheet extends StatelessWidget {
  final AddressController addressController = Get.find();
  Function(Country?)? onSelected;
  bool? singleSelection;

  AreaSheet({super.key, this.singleSelection = false, this.onSelected});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Obx(
          () => LoadingWidget(
            loadingState: addressController.addresses.value,
            onRetryCall: () {
              addressController.fetchAddresses();
            },
            isEmpty: addressController.addresses.value.data?.isEmpty == true,
            child: ListView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              itemCount: addressController.addresses.value.data?.length,
              itemBuilder: (context, index) {
                var item = addressController.addresses.value.data?[index];
                return SizedBox(
                  width: double.infinity,
                  child: InkWell(
                    onTap: () {
                      onSelected?.call(item);
                      Get.back();
                    },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      padding: const EdgeInsets.only(
                        top: 12,
                        bottom: 12,
                        left: 50,
                        right: 16,
                      ),
                      decoration: MyshapesStyle.PrimaryDecoration,
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              item?.title ?? "",
                              textAlign: TextAlign.center,
                              style: MyTextStyle.normalStyle,
                            ),
                          ),
                          // Obx(()=>Visibility(
                          //   visible: selectedAreas.contains(e),
                          //     child: Image.asset("assets/images/check.png", width: 25,))
                          // )
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
