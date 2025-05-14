import 'package:flutter/material.dart';
import 'package:garage/core/controllers/user_controller.dart';
import 'package:garage/core/ui/my_image.dart';
import 'package:garage/core/ui/widgets/custom_country_code_and_flag.dart';
import 'package:garage/core/ui/widgets/my_text_form.dart';
import 'package:garage/features/auth/company_profile_edit/company_profile_edit_Settings/work_categories_drop_down.dart';
import 'package:garage/features/auth/company_profile_edit/company_profile_edit_controller.dart';
import 'package:garage/features/auth/company_profile_edit/company_profile_edit_state.dart';
import 'package:garage/theme/styles.dart';
import 'package:get/get.dart';

class CompanyProfileEditView1 extends StatelessWidget {
  CompanyProfileEditController controller = Get.put(
    CompanyProfileEditController(),
  );

  CompanyProfileEditState state =
      Get.find<CompanyProfileEditController>().state;

  UserController userController = Get.find();
  CompanyProfileEditView1({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'اهلاََ MB Parts,   لنقم بإدخال معلومات العمل.',
            textAlign: TextAlign.right,
            style: TextStyle(
              color: Colors.white,
              fontSize: 32,
              fontFamily: 'Zain',
              fontWeight: FontWeight.w700,
              height: 1.50,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'أملأ معلومات عملك الأساسية',
            textAlign: TextAlign.right,
            style: TextStyle(
              color: Color(0xFFCCCAC7),
              fontSize: 18,
              fontFamily: 'Zain',
              fontWeight: FontWeight.w400,
              height: 1.50,
            ),
          ),
          const SizedBox(height: 24),
          const WorkCategoriesDropDown(),
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

            child: const ListTile(
              trailing: MyImage(
                image: "assets/images/ic_location.svg",
                width: 24,
              ),
              title: Text(
                'العنوان',
                textAlign: TextAlign.right,
                style: TextStyle(
                  color: Color(0xFF9E9B94),
                  fontSize: 14,
                  fontFamily: 'Zain',
                  fontWeight: FontWeight.w400,
                  height: 1.50,
                ),
              ),
              subtitle: Text(
                '44 طريق شارع الفهيدي, العاصمة, الكويت',
                textAlign: TextAlign.right,
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
            icon: const TextFormFieldIcon(assets: "assets/images/ic_phone.svg"),

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
            controller: state.fax,
            hint: "fax".tr,
            textInputType: TextInputType.text,
          ),
          const SizedBox(height: 24),
          const Text(
            'التواصل الاجتماعي',
            textAlign: TextAlign.right,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontFamily: 'Zain',
              fontWeight: FontWeight.w700,
            ),
          ),
          MyTextForm(
            icon: const TextFormFieldIcon(assets: "assets/images/ic_xapp.svg"),
            controller: state.address,
            textInputType: TextInputType.text,
          ),
          const SizedBox(height: 8),
          MyTextForm(
            icon: const TextFormFieldIcon(
              assets: "assets/images/ic_tiktok.svg",
            ),

            controller: state.location,
            textInputType: TextInputType.text,
          ),
          const SizedBox(height: 8),
          MyTextForm(
            icon: const TextFormFieldIcon(
              assets: "assets/images/ic_instagram.svg",
            ),
            controller: state.location,
            textInputType: TextInputType.text,
          ),
          const SizedBox(height: 8),
          MyTextForm(
            icon: const TextFormFieldIcon(assets: "assets/images/ic_snap.svg"),
            controller: state.location,
            textInputType: TextInputType.text,
          ),
          const SizedBox(height: 8),
          MyTextForm(
            icon: const TextFormFieldIcon(
              assets: "assets/images/ic_youtube.svg",
            ),
            controller: state.location,
            textInputType: TextInputType.text,
          ),
          const SizedBox(height: 24),
          const Text(
            'مواعيد العمل',
            textAlign: TextAlign.right,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontFamily: 'Zain',
              fontWeight: FontWeight.w700,
              height: 1.20,
            ),
          ),
          WeeklyTimeSelector(),
        ],
      ),
    );
  }
}

class WeeklyTimeSelector extends StatelessWidget {
  final List<String> days = [
    'السبت',
    'الأحد',
    'الاثنين',
    'الثلاثاء',
    'الأربعاء',
    'الخميس',
  ];

  WeeklyTimeSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: days.map((day) => _buildDayRow(day)).toList());
  }

  Widget _buildDayRow(String day) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CheckboxTheme(
                
                  data: CheckboxThemeData(

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        6,
                      ), // 👈 Border Radius
                    ),
                    side: const BorderSide(
                      color: Colors.orange, // 👈 Border Color when unchecked
                      width: 2,
                    ),
                    fillColor: WidgetStateProperty.resolveWith<Color>((states) {
                      if (states.contains(WidgetState.selected)) {
                        return Colors.orange; // 👈 Fill color when checked
                      }
                      return Colors.transparent;
                    }),
                  ),
                  child: Checkbox(value: true, onChanged: (val) {}
                  ),
                ),

                Text(
                  day,
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                  textAlign: TextAlign.right,
                ),
              ],
            ),
          ),
          // Start time
          Expanded(child: _buildTimeBox("18:00")),
          const SizedBox(width: 10),
          // End time
          Expanded(child: _buildTimeBox("09:00")),
          const SizedBox(width: 10),
          
          // Day name

          // Active check icon
        ],
      ),
    );
  }

  Widget _buildTimeBox(String time) {
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
