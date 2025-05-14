import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:garage/core/controllers/checkout_controller.dart';
import 'package:garage/core/networking/models/delivery_type.dart';
import 'package:garage/core/ui/MyButton.dart';
import 'package:garage/theme/styles.dart';

class TimesSheet extends StatelessWidget {
  final CheckoutController checkoutController = Get.find();
  var selectedDate = Rx<String?>(
    DateFormat("yyyy-MM-dd").format(DateTime.now()),
  );
  var selectedTime = Rx<TimesData?>(null);

  TimesSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Scaffold(
        appBar: appBar(context),
        body: SafeArea(
          bottom: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CalendarDatePicker(
                initialDate: DateTime.now(),
                firstDate: DateTime.now(),
                lastDate: DateTime.now().add(const Duration(days: 30)),
                onDateChanged: (date) {
                  selectedDate.value = DateFormat("yyyy-MM-dd").format(date);
                  selectedTime.value = null;
                },
              ),
              Text(
                "available_times".tr,
                style: MyTextStyle.myBlackBoldTitle,
              ).marginAll(16),
              Expanded(
                child: Obx(() {
                  return checkoutController.selectedDeliveryType.value?.times
                              ?.firstWhereOrNull(
                                (element) => element.date == selectedDate.value,
                              )
                              ?.times ==
                          null
                      ? Center(
                        child: Text(
                          "no_available_times".tr,
                          style: MyTextStyle.myBlackTitle,
                        ),
                      )
                      : GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 3,
                              crossAxisSpacing: 16,
                              mainAxisSpacing: 16,
                            ),
                        padding: const EdgeInsets.all(16),
                        itemCount:
                            checkoutController.selectedDeliveryType.value?.times
                                ?.firstWhereOrNull(
                                  (element) =>
                                      element.date == selectedDate.value,
                                )
                                ?.times
                                ?.length ??
                            0,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          var time = checkoutController
                              .selectedDeliveryType
                              .value
                              ?.times
                              ?.firstWhereOrNull(
                                (element) => element.date == selectedDate.value,
                              )
                              ?.times
                              ?.elementAt(index);
                          return Obx(() {
                            return InkWell(
                              onTap: () {
                                selectedTime.value = time;
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color:
                                      selectedTime.value?.timeFrom ==
                                              time?.timeFrom
                                          ? Theme.of(context).primaryColor
                                          : Colors.grey.shade200,
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  "${time?.timeFrom} , ${time?.timeTo}",
                                  style: MyTextStyle.myBlackTitle.copyWith(
                                    color:
                                        selectedTime.value?.timeFrom ==
                                                time?.timeFrom
                                            ? Colors.white
                                            : Colors.black,
                                  ),
                                ),
                              ),
                            );
                          });
                        },
                      );
                }),
              ),
              MyButton(
                title: "select".tr,
                onClick: () {
                  if (selectedTime.value == null) {
                    Get.snackbar(
                      "alert".tr,
                      "please_select_time".tr,
                      colorText: Colors.white,
                      backgroundColor: Colors.black,
                    );
                  } else {
                    checkoutController.selectedTime.value = selectedTime.value;
                    checkoutController.selectedDate.value = selectedDate.value;
                    Get.back();
                  }
                },
              ).marginAll(16),
            ],
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget appBar(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size(double.infinity, 60),
      child: ClipRect(
        child: Container(
          child: Align(
            alignment: Alignment.centerLeft,
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  margin: const EdgeInsets.only(left: 14, right: 14),
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.close,
                    size: 24,
                    color: Colors.black54,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
