import 'package:flutter/material.dart';
import 'package:garage/core/ui/MyLoadingButton.dart';
import 'package:garage/core/ui/my_scaffold.dart';
import 'package:garage/core/ui/select_drop_list%20.dart';
import 'package:garage/core/ui/widgets/my_text_form.dart';
import 'package:garage/features/main/add_price_request/add_price_request_widgets/select_company_and_service.dart';
import 'package:garage/theme/styles.dart';
import 'package:get/get.dart';

import 'add_price_request_controller.dart';
import 'add_price_request_state.dart';

class AddPriceRequestPage extends StatelessWidget {
  const AddPriceRequestPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AddPriceRequestController logic = Get.put(
      AddPriceRequestController(),
    );

    return MyScaffold(
      title: "إضافه طلب سعر".tr,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        child: Column(
          spacing: 8,
          children: [
            const SelectCompanyAndService(),
            MyTextForm(
              // controller: state.phoneNumber,
              hint: "order_description".tr,
              textInputType: TextInputType.phone,
              lines: 5,
            ),
            MyTextForm(
              // controller: state.phoneNumber,
              hint: "quantity".tr,
              textInputType: TextInputType.phone,
            ),
            const AddAttachment(),
          ],
        ),
      ),
      fab: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
        color: colorBlack,
        child: MyLoadingButton(
          title: "add".tr,
          onClick: (p0) {
            p0.success();
            Future.delayed(const Duration(seconds: 1), () => Get.back());
          },
        ),
      ),
    );
  }
}

class AddAttachment extends StatelessWidget {
  const AddAttachment({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: MyshapesStyle.PrimaryDecoration,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'إرفاق مستند صورة اوفيديو  ',
                textAlign: TextAlign.right,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontFamily: 'Zain',
                  fontWeight: FontWeight.w400,
                  height: 1.20,
                ),
              ),
              Text(
                'حجم الملف بالطلب لا يزيد عن 5 ميجا بايت',
                textAlign: TextAlign.right,
                style: TextStyle(
                  color: Color(0xFFCCCAC7),
                  fontSize: 14,
                  fontFamily: 'Zain',
                  fontWeight: FontWeight.w400,
                  height: 1.20,
                ),
              ),
            ],
          ),
          Icon(Icons.attach_file_rounded, color: Colors.white),
        ],
      ),
    );
  }
}
