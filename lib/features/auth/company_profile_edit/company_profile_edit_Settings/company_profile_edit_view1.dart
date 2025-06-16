// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:time_picker_spinner_pop_up/time_picker_spinner_pop_up.dart';

import 'package:garage/core/controllers/user_controller.dart';
import 'package:garage/core/helpers/time_formater.dart';
import 'package:garage/core/ui/my_image.dart';
import 'package:garage/core/ui/widgets/custom_country_code_and_flag.dart';
import 'package:garage/core/ui/widgets/my_text_form.dart';
import 'package:garage/features/auth/company_profile_edit/company_profile_edit_Settings/work_categories_drop_down.dart';
import 'package:garage/features/auth/company_profile_edit/company_profile_edit_controller.dart';
import 'package:garage/features/auth/company_profile_edit/company_profile_edit_state.dart';
import 'package:garage/features/auth/company_profile_edit/models/time_slot.dart';
import 'package:garage/features/auth/register/register_controller.dart';
import 'package:garage/features/auth/register/register_state.dart';
import 'package:garage/theme/styles.dart';

class CompanyProfileEditView1 extends StatelessWidget {
  CompanyProfileEditController controller = Get.put(
    CompanyProfileEditController(),
  );

  CompanyProfileEditState dataState =
      Get.find<CompanyProfileEditController>().state;
  RegisterState state = Get.find<RegisterController>().state;

  RegisterController userController = Get.find();
  CompanyProfileEditView1({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "welcome_mp_part".tr,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 32,
              fontFamily: 'Zain',
              fontWeight: FontWeight.w700,
              height: 1.50,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "company_info".tr,
            textAlign: TextAlign.right,
            style: const TextStyle(
              color: Color(0xFFCCCAC7),
              fontSize: 18,
              fontFamily: 'Zain',
              fontWeight: FontWeight.w400,
              height: 1.50,
            ),
          ),
          const SizedBox(height: 24),
          WorkCategoriesDropDown(controller: controller, state: dataState),
          const SizedBox(height: 16),
          MyTextForm(
            // controller: state.companyDescription,
            hint: "company_description".tr,
            textInputType: TextInputType.text,
          ),
          const SizedBox(height: 16),

          Container(
            decoration: BoxDecoration(
              color: colorContainer,

              borderRadius: BorderRadiusDirectional.circular(8),
            ),

            child: ListTile(
              trailing: const MyImage(
                image: "assets/images/ic_location.svg",
                width: 24,
              ),
              title: Text(
                "address".tr,
                style: const TextStyle(
                  color: Color(0xFF9E9B94),
                  fontSize: 14,
                  fontFamily: 'Zain',
                  fontWeight: FontWeight.w400,
                  height: 1.50,
                ),
              ),
              subtitle: const Text(
                '44 طريق شارع الفهيدي, العاصمة, الكويت',
                style: TextStyle(
                  color: Color(0xFFF7F8F9),
                  fontSize: 18,
                  fontFamily: 'Zain',
                  fontWeight: FontWeight.w400,
                  height: 1.20,
                ),
              ),
            ),
          ),
          // CurrentLocationMap()
          const SizedBox(height: 16),
          MyTextForm(
            icon: const TextFormFieldIcon(
              assets: "assets/images/ic_whatsapp.svg",
            ),
            controller: state.website,
            hint: "whatsapp".tr,
            textInputType: TextInputType.phone,
          ),
          const SizedBox(height: 8),
          MyTextForm(
            icon: const TextFormFieldIcon(assets: "assets/images/ic_call.svg"),

            controller: state.phoneNumber,
            hint: "phone_number".tr,
            textInputType: TextInputType.phone,
          ),
          const SizedBox(height: 8),
          MyTextForm(
            icon: const TextFormFieldIcon(
              assets: "assets/images/ic_website.svg",
            ),
            controller: state.email,
            hint: "website".tr,
            textInputType: TextInputType.text,
          ),
          const SizedBox(height: 8),
          MyTextForm(
            icon: const TextFormFieldIcon(
              assets: "assets/images/ic_termsCode.svg",
            ),
            controller: state.commercialRegistrationNumber,
            hint: "fax".tr,
            textInputType: TextInputType.text,
          ),
          const SizedBox(height: 24),
          Text(
            "social_links".tr,
            textAlign: TextAlign.right,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontFamily: 'Zain',
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 8),
          MyTextForm(
            icon: const TextFormFieldIcon(assets: "assets/images/twitter.svg"),
            controller: state.whatsapp,
            textInputType: TextInputType.text,
          ),
          const SizedBox(height: 8),
          MyTextForm(
            icon: const TextFormFieldIcon(
              assets: "assets/images/ic_tiktok.svg",
            ),

            controller: state.tiktok,
            textInputType: TextInputType.text,
          ),
          const SizedBox(height: 8),
          MyTextForm(
            icon: const TextFormFieldIcon(
              assets: "assets/images/instagram.svg",
            ),
            controller: state.instagram,
            textInputType: TextInputType.text,
          ),
          const SizedBox(height: 8),
          MyTextForm(
            icon: const TextFormFieldIcon(assets: "assets/images/ic_snap.svg"),
            controller: state.snapchat,
            textInputType: TextInputType.text,
          ),
          const SizedBox(height: 8),
          MyTextForm(
            icon: const TextFormFieldIcon(assets: "assets/images/youtube.png"),
            controller: state.youtube,
            textInputType: TextInputType.text,
          ),
          const SizedBox(height: 24),
          Text(
            "work_time".tr,
            textAlign: TextAlign.right,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontFamily: 'Zain',
              fontWeight: FontWeight.w700,
              height: 1.20,
            ),
          ),
          WeeklyTimeSelector(controller: userController),
        ],
      ),
    );
  }
}

class WeeklyTimeSelector extends StatefulWidget {
  final RegisterController controller;
  const WeeklyTimeSelector({Key? key, required this.controller})
    : super(key: key);

  @override
  State<WeeklyTimeSelector> createState() => _WeeklyTimeSelectorState();
}

class _WeeklyTimeSelectorState extends State<WeeklyTimeSelector> {
  final List<TimeSlot> days = [
    TimeSlot(day: 'saturday'.tr, start: null, end: null, isSelected: false),
    TimeSlot(day: 'sunday'.tr, start: null, end: null, isSelected: false),
    TimeSlot(day: 'monday'.tr, start: null, end: null, isSelected: false),
    TimeSlot(day: 'tuesday'.tr, start: null, end: null, isSelected: false),
    TimeSlot(day: 'wednesday'.tr, start: null, end: null, isSelected: false),
    TimeSlot(day: 'thursday'.tr, start: null, end: null, isSelected: false),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: days.map((day) => _buildDayRow(day, context: context)).toList(),
    );
  }

  Widget _buildDayRow(TimeSlot day, {required BuildContext context}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: Row(
                    children: [
                      CheckboxTheme(
                        data: CheckboxThemeData(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              6,
                            ), // 👈 Border Radius
                          ),
                          side: const BorderSide(
                            color:
                                Colors.orange, // 👈 Border Color when unchecked
                            width: 2,
                          ),
                          fillColor: WidgetStateProperty.resolveWith<Color>((
                            states,
                          ) {
                            if (states.contains(WidgetState.selected)) {
                              return Colors
                                  .orange; // 👈 Fill color when checked
                            }
                            return Colors.transparent;
                          }),
                        ),
                        child: Checkbox(
                          value: day.isSelected,
                          onChanged: (val) {
                            setState(() {
                              day.isSelected = val ?? false;
                            });
                            widget.controller.addAndRemoveTimeSlot(day);
                          },
                        ),
                      ),

                      Text(
                        day.day ?? "",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.right,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  flex: 5,
                  child: TimeRow(
                    startTime: day.start,
                    endTime: day.end,
                    startTimeChange: (time) => day.start = time,
                    endTimeChange: (time) => day.end = time,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TimeRow extends StatefulWidget {
  final Function(String) startTimeChange;
  final Function(String) endTimeChange;
  final String? startTime;
  final String? endTime;
  const TimeRow({
    Key? key,
    required this.startTimeChange,
    required this.endTimeChange,
    this.startTime,
    this.endTime,
  }) : super(key: key);

  @override
  State<TimeRow> createState() => _TimeRowState();
}

class _TimeRowState extends State<TimeRow> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TimePickerSpinnerPopUp(
            barrierColor: Colors.black12,
            timeWidgetBuilder:
                (p0) => _buildTimeBox(
                  widget.startTime ?? DateTimeFormatter.formatHour12(p0),
                  context: context,
                ),
            mode: CupertinoDatePickerMode.time,
            initTime: DateTime.now(),
            onChange: (dateTime) {
              widget.startTimeChange(DateTimeFormatter.formatHour12(dateTime));
              // Implement your logic with select dateTime
            },
          ),
        ),

        const SizedBox(width: 10),
        Expanded(
          child: TimePickerSpinnerPopUp(
            barrierColor: Colors.black12,
            timeWidgetBuilder:
                (p0) => _buildTimeBox(
                  widget.endTime ?? DateTimeFormatter.formatHour12(p0),
                  context: context,
                ),
            mode: CupertinoDatePickerMode.time,
            initTime: DateTime.now(),
            onChange: (dateTime) {
              widget.endTimeChange(DateTimeFormatter.formatHour12(dateTime));
            },
          ),
        ),
      ],
    );
  }

  Widget _buildTimeBox(String time, {required BuildContext context}) {
    return Container(
      width: 80,
      height: 45,
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(time, style: const TextStyle(color: Colors.white, fontSize: 14)),
          const Icon(Icons.access_time, color: Colors.white70, size: 18),
        ],
      ),
    );
  }
}
