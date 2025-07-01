import 'dart:async';

import 'package:flutter/material.dart';
import 'package:garage/core/ui/MyLoadingButton.dart';
import 'package:garage/core/ui/my_scaffold.dart';
import 'package:garage/core/ui/sheet/normal_sheet.dart';
import 'package:garage/core/ui/widgets/my_text_form.dart';
import 'package:garage/features/main/complete_cart_order/complete_cart_order_controller.dart';
import 'package:garage/features/other/sheet/area_sheet.dart';
import 'package:garage/routes/app_pages.dart';
import 'package:garage/routes/arguments.dart';
import 'package:garage/theme/styles.dart';
import 'package:garage/utils/utlis.dart';
import 'package:get/get.dart';
import 'package:rounded_loading_button_plus/rounded_loading_button.dart';

class CompleteCartOrderPage extends StatefulWidget {
  const CompleteCartOrderPage({Key? key}) : super(key: key);

  @override
  State<CompleteCartOrderPage> createState() => _CompleteCartOrderPageState();
}

class _CompleteCartOrderPageState extends State<CompleteCartOrderPage> {
  CompleteCartOrderController get controller => Get.find();

  final state = Get.find<CompleteCartOrderController>().state;

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      resizeToAvoidBottomInset: false,
      title: "complete_order".tr,
      body: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.only(top: 16, left: 8, right: 8, bottom: 100),
        children: <Widget>[
          MyTextForm(
            controller: state.nameController,
            hint: "name".tr,
            textInputType: TextInputType.text,
          ),
          const SizedBox(height: 16),
          MyTextForm(
            controller: state.phoneController,
            hint: "phone_number".tr,
            textInputType: TextInputType.phone,
          ),
          const SizedBox(height: 16),

          GestureDetector(
            onTap:
                () => Utils.showSheet(
                  context,
                  isScrollable: true,
                  NormalSheet(
                    title: "select_area".tr,

                    child: AreaSheet(
                      // singleSelection: widget.stateId != null ? true : false,
                      onSelected: (states) {
                        state.stateController.value = states;
                      },
                    ),
                  ),
                ),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
              margin: const EdgeInsets.all(8),
              decoration: MyshapesStyle.PrimaryDecoration,
              child: Column(
                children: [
                  Text(
                    "select_area".tr,
                    textAlign: TextAlign.right,
                    style: const TextStyle(
                      color: Color(0xFF9E9B94),
                      fontSize: 14,
                      fontFamily: 'Zain',
                      fontWeight: FontWeight.w400,
                      height: 1.50,
                    ),
                  ),
                  Obx(() {
                    return Text(
                      state.stateController.value == null
                          ? "select_area".tr
                          : state.stateController.value!.title ?? '',
                      textAlign: TextAlign.right,
                      style: const TextStyle(
                        color: Color(0xFFF7F8F9),
                        fontSize: 18,
                        fontFamily: 'Zain',
                        fontWeight: FontWeight.w400,
                        height: 1.20,
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          MyTextForm(
            controller: state.streetController,
            hint: "street".tr,
            textInputType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 16),
          MyTextForm(
            controller: state.squareNumberController,
            hint: "message".tr,
            textInputType: TextInputType.text,
          ),
          const SizedBox(height: 16),

          MyTextForm(
            controller: state.jadaNumberController,
            hint: "jada".tr,
            textInputType: TextInputType.text,
          ),
          const SizedBox(height: 16),

          MyTextForm(
            controller: state.notesController,
            hint: "note".tr,
            textInputType: TextInputType.text,
            lines: 5,
          ),
          Obx(
            () => Visibility(
              visible: state.completeOrderLoading.value.error,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  state.completeOrderLoading.value.message,
                  textAlign: TextAlign.center,
                  style: MyTextStyle.myErrorSubTitle,
                ),
              ),
            ),
          ),
          const SizedBox(height: 30),
        ],
      ),
      fab: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
        color: colorBlack,
        child: MyLoadingButton(
          title: "complete_order".tr,
          onClick: (RoundedLoadingButtonController _controller) {
            if (controller.validation()) {
              controller.completeOrder(
                {
                  "name": state.nameController.text,
                  "phone": state.phoneController.text,
                  "country_code": '956',
                  "region_id": state.stateController.value!.id.toString(),
                  "street_name": state.streetController.text,
                  "block_number": state.jadaNumberController.text,
                  "building_number": state.squareNumberController.text,
                  "avenue_number": state.squareNumberController.text,
                  "note": state.notesController.text,
                },
                (success, payment) async {
                  if (success) {
                    _controller.reset();
                    print("payment url: ${payment?.url}");
                    var resultJson = await Get.toNamed(
                      Routes.WEBVIEW_PAYMENT,
                      arguments: {MyArguments.URL: payment?.url},
                    );
                    if (resultJson != null) {
                      if (resultJson["key"] == "success") {
                        _controller.success();
                        Get.offNamed(Routes.SuccessDialogScreen);
                        Utils.showSnackBar("payment_success".tr);
                      } else {
                        _controller.error();
                        Utils.showSnackBar("payment_error".tr);
                      }
                      Timer(const Duration(seconds: 1), () {
                        _controller.reset();
                      });
                    }
                  } else {
                    _controller.error();
                    Utils.showSnackBar(state.payment.value.message);
                  }

                  Timer(const Duration(seconds: 1), () {
                    _controller.reset();
                  });
                },
              );
            }
            Timer(const Duration(seconds: 1), () {
              _controller.reset();
            });
          },
        ),
      ),
    );
  }
}
