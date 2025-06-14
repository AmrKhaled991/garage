import 'package:flutter/material.dart';
import 'package:garage/core/ui/MyButton.dart';
import 'package:garage/core/ui/MyLoadingButton.dart';
import 'package:garage/core/ui/my_scaffold.dart';
import 'package:garage/core/ui/widgets/my_text_form.dart';
import 'package:garage/theme/styles.dart';
import 'package:garage/utils/utlis.dart';
import 'package:get/get.dart';

import 'maintenance_appointment_reminder_controller.dart';

class MaintenanceAppointmentReminderPage extends StatelessWidget {
  const MaintenanceAppointmentReminderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MaintenanceAppointmentReminderLogic logic = Get.put(
      MaintenanceAppointmentReminderLogic(),
    );

    return MyScaffold(
      title: "maintenance_appointment_reminder".tr,
      body:
      //  EmptyWidget(title: "لا يوجد مواعيد"),
      ListView.separated(
        padding: const EdgeInsets.only(top: 16, left: 8, right: 8, bottom: 100),
        itemBuilder:
            (context, index) => const MaintenanceAppointmentReminderItem(),
        separatorBuilder: (context, index) => const SizedBox(height: 8),
        itemCount: 10,
      ),
      fab: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
        color: colorBlack,
        child: MyButton(
          title: "add_new_reminder".tr,
          onClick: () {
            Utils.showSheet(
              context,
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  spacing: 8,
                  children: [
                    MyTextForm(
                      // controller: state.phoneNumber,
                      hint: "address".tr,
                      textInputType: TextInputType.text,
                    ),
                    MyTextForm(
                      // controller: state.phoneNumber,
                      hint: "add_notes".tr,
                      textInputType: TextInputType.text,
                      lines: 5,
                    ),
                    MyTextForm(
                      // controller: state.phoneNumber,
                      hint: "read_kilometer".tr,
                      textInputType: TextInputType.text,
                    ),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: MyshapesStyle.PrimaryDecoration,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "appointment".tr,

                            style: const TextStyle(
                              color: Color(0xFFF7F8F9),
                              fontSize: 18,
                              fontFamily: 'Zain',
                              fontWeight: FontWeight.w400,
                              height: 1.20,
                            ),
                          ),
                          const Spacer(),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 4,
                              vertical: 8,
                            ),

                            decoration: MyshapesStyle.lightGrayDecoration,
                            child: const Row(
                              spacing: 10,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  '2022-12-12',

                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontFamily: 'Zain',
                                    fontWeight: FontWeight.w400,
                                    height: 1.20,
                                  ),
                                ),
                                Icon(
                                  Icons.calendar_month_outlined,
                                  color: Colors.white,
                                  size: 24,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 4,
                              vertical: 8,
                            ),
                            decoration: MyshapesStyle.lightGrayDecoration,
                            child: const Text(
                              '08:00PM',

                              style: TextStyle(
                                color: Color(0xFFF7F8F9),
                                fontSize: 18,
                                fontFamily: 'Zain',
                                fontWeight: FontWeight.w400,
                                height: 1.50,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    MyLoadingButton(
                      title: "add".tr,
                      onClick: (status) {
                        status.success();
                        Future.delayed(
                          const Duration(seconds: 1),
                          () => Get.back(),
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class MaintenanceAppointmentReminderItem extends StatelessWidget {
  const MaintenanceAppointmentReminderItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: MyshapesStyle.PrimaryDecoration,
      child: Column(
        spacing: 4,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "موعد تغيير زيت للسيارة ",
            style: TextStyle(
              color: Color(0xFFF7F8F9),
              fontSize: 20,
              fontFamily: 'Zain',
              fontWeight: FontWeight.w700,
            ),
          ),
          const Text(
            "وريم إيبسوم هو نص مؤقت يستخدم في التصميم والنشر لإظهار شكل الوثيقة أو الخط دون الاعتماد على محتوى معنوي. قد يستخدم لوريم إيبسوم كنص بديل قبل وضع النص",

            style: TextStyle(
              color: Color(0xFFCCCAC7),
              fontSize: 14,
              fontFamily: 'Zain',
              fontWeight: FontWeight.w400,
              height: 1.50,
            ),
          ),

          Container(
            padding: const EdgeInsets.all(8),
            width: double.infinity,

            decoration: MyshapesStyle.lightGrayDecoration,
            child: const Text(
              "تاريخ الطلب: 15 مارس, 2025 - 08:30 م",
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontFamily: 'Zain',
                fontWeight: FontWeight.w400,
                height: 1.50,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
