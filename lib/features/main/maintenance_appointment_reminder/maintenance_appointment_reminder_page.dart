import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:garage/core/helpers/time_formater.dart';
import 'package:garage/core/networking/models/reminder/reminder.dart';
import 'package:garage/core/networking/models/user_prices_request/user_prices_request.dart';
import 'package:garage/core/ui/MyButton.dart';
import 'package:garage/core/ui/MyLoadingButton.dart';
import 'package:garage/core/ui/my_error_widget.dart';
import 'package:garage/core/ui/my_loading_widget.dart';
import 'package:garage/core/ui/my_scaffold.dart';
import 'package:garage/core/ui/sheet/normal_sheet.dart';
import 'package:garage/core/ui/widgets/my_text_form.dart';
import 'package:garage/features/main/maintenance_appointment_reminder/widgets/maintenance_appointment_reminder_item.dart';
import 'package:garage/theme/styles.dart';
import 'package:garage/utils/utlis.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:intl/intl.dart';
import 'package:time_picker_spinner_pop_up/time_picker_spinner_pop_up.dart';

import 'maintenance_appointment_reminder_controller.dart';

class MaintenanceAppointmentReminderPage extends StatefulWidget {
  const MaintenanceAppointmentReminderPage({Key? key}) : super(key: key);

  @override
  State<MaintenanceAppointmentReminderPage> createState() =>
      _MaintenanceAppointmentReminderPageState();
}

class _MaintenanceAppointmentReminderPageState
    extends State<MaintenanceAppointmentReminderPage> {
  @override
  Widget build(BuildContext context) {
    MaintenanceAppointmentReminderController controller =
        Get.find<MaintenanceAppointmentReminderController>();
    var state = Get.find<MaintenanceAppointmentReminderController>().state;
    return MyScaffold(
      title: "maintenance_appointment_reminder".tr,
      body: Padding(
        padding: const EdgeInsets.only(bottom: 100.0),
        child: PagedListView<int, Reminder>(
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          pagingController: controller.state.pagingController,
          padding: const EdgeInsets.all(8),
          builderDelegate: PagedChildBuilderDelegate<Reminder>(
            itemBuilder:
                (context, item, index) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  child: MaintenanceAppointmentReminderItem(item: item),
                ),
            firstPageProgressIndicatorBuilder: (_) => const MyLoadingWidget(),
            newPageProgressIndicatorBuilder: (_) => const MyLoadingWidget(),
            noItemsFoundIndicatorBuilder:
                (_) => MyErrorWidget(
                  onRetryCall: () {
                    controller.state.pagingController.refresh();
                  },
                  errorMsg: "no_data_found".tr,
                  errorType: ErrorType.EMPTY,
                ),
            firstPageErrorIndicatorBuilder:
                (_) => MyErrorWidget(
                  onRetryCall: () {
                    controller.state.pagingController.refresh();
                  },
                  errorMsg: controller.state.pagingController.error
                      .toString()
                      .substring(
                        controller.state.pagingController.error
                                .toString()
                                .lastIndexOf("(") +
                            2,
                        controller.state.pagingController.error
                                .toString()
                                .length -
                            2,
                      ),
                  withLogin: true,
                ),
          ),
        ),
      ),
      fab: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
        color: colorBlack,
        child: MyButton(
          title: "add_new_reminder".tr,
          onClick: () {
            Utils.showSheet(
              context,
              isScrollable: true,
              NormalSheet(
                title: "add_new_reminder".tr,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    spacing: 8,
                    children: [
                      MyTextForm(
                        controller: state.title,
                        hint: "address".tr,
                        textInputType: TextInputType.text,
                      ),
                      MyTextForm(
                        controller: state.description,
                        hint: "add_notes".tr,
                        textInputType: TextInputType.text,
                        lines: 5,
                      ),
                      MyTextForm(
                        controller: state.kilometer,
                        hint: "read_kilometer".tr,
                        textInputType: TextInputType.number,
                      ),
                      Appointment(controller: controller),
                      MyLoadingButton(
                        title: "add".tr,
                        onClick: (status) {
                          if (controller.validations() == false) {
                            status.reset();
                            return;
                          }
                          controller.storeReminder((success) {
                            if (success) {
                              status.success();
                              Future.delayed(const Duration(seconds: 1), () {
                                controller.state.pagingController.refresh();
                                controller.resetForm();
                                Get.back();
                              });
                            } else {
                              status.error();
                              Future.delayed(
                                const Duration(seconds: 1),
                                () => status.reset(),
                              );
                            }
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class Appointment extends StatelessWidget {
  MaintenanceAppointmentReminderController controller =
      Get.find<MaintenanceAppointmentReminderController>();
  Appointment({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
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

          // Your widget
          InkWell(
            onTap: () async {
              // Parse current value or fallback to today
              DateTime initialDate;
              try {
                initialDate =
                    controller.state.date.value.isEmpty
                        ? DateTime.now()
                        : DateFormat(
                          'yyyy-MM-dd',
                        ).parse(controller.state.date.value);
              } catch (_) {
                initialDate = DateTime.now();
              }

              final DateTime? picked = await showDatePicker(
                context: context,
                initialDate:
                    initialDate.isBefore(DateTime.now())
                        ? DateTime.now()
                        : initialDate,
                firstDate: DateTime.now(), // 🔒 only allow today and future
                lastDate: DateTime(2100),
                builder: (context, child) {
                  return Theme(
                    data: Theme.of(context).copyWith(
                      colorScheme: const ColorScheme.dark(
                        primary: Colors.teal,
                        onPrimary: Colors.white,
                        surface: Colors.black,
                        onSurface: Colors.white,
                      ),
                      dialogTheme: DialogThemeData(
                        backgroundColor: Colors.grey.shade900,
                      ),
                    ),
                    child: child!,
                  );
                },
              );

              if (picked != null) {
                final formatted = DateFormat('yyyy-MM-dd').format(picked);
                controller.state.date.value = formatted;
              }
            },
            child: Obx(
              () => Container(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                decoration: MyshapesStyle.lightGrayDecoration,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      controller.state.date.value.isEmpty
                          ? DateFormat('yyyy-MM-dd').format(DateTime.now())
                          : controller.state.date.value,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontFamily: 'Zain',
                        fontWeight: FontWeight.w400,
                        height: 1.20,
                      ),
                    ),
                    const SizedBox(width: 10),
                    const Icon(
                      Icons.calendar_month_outlined,
                      color: Colors.white,
                      size: 24,
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            decoration: MyshapesStyle.lightGrayDecoration,
            child: TimePickerSpinnerPopUp(
              barrierColor: Colors.black12,
              timeWidgetBuilder:
                  (p0) => _buildTimeBox(
                    DateTimeFormatter.formatHour12(p0),
                    context: context,
                  ),
              mode: CupertinoDatePickerMode.time,
              initTime: DateTime.now(),
              onChange: (dateTime) {
                controller.state.hour.value = DateTimeFormatter.formatHour24(
                  dateTime,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeBox(String time, {required BuildContext context}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(
          time,
          style: const TextStyle(
            color: Color(0xFFF7F8F9),
            fontSize: 18,
            fontFamily: 'Zain',
            fontWeight: FontWeight.w400,
            height: 1.50,
          ),
        ),
      ],
    );
  }
}
