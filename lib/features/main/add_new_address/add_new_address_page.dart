import 'package:flutter/material.dart';
import 'package:garage/core/ui/MyLoadingButton.dart';
import 'package:garage/core/ui/my_scaffold.dart';
import 'package:garage/core/ui/widgets/my_text_form.dart';
import 'package:garage/features/main/add_new_address/add_new_address_logic.dart';
import 'package:garage/theme/styles.dart';
import 'package:get/get.dart';


class AddNewAddressPage extends StatefulWidget {
  const AddNewAddressPage({Key? key}) : super(key: key);

  @override
  State<AddNewAddressPage> createState() => _AddNewAddressPageState();
}

class _AddNewAddressPageState extends State<AddNewAddressPage> {
  bool isActive = false;
  @override
  Widget build(BuildContext context) {
    final AddNewAddressController logic = Get.put(AddNewAddressController());

    return MyScaffold(
      title: "add_new_address".tr,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          spacing: 8,
          children: [
            MyTextForm(
              // controller: state.phoneNumber,
              hint: "name".tr,
              textInputType: TextInputType.text,
            ),
            MyTextForm(
              // controller: state.textNumber,
              hint: "العنوان بالتفصيل".tr,
              textInputType: TextInputType.text,
            ),
            MyTextForm(
              // controller: state.textNumber,
              hint: "تفاصيل العنوان (أختياري)".tr,
              textInputType: TextInputType.text,
              lines: 5,
            ),
            Row(
              children: [
                Switch(
                  value: isActive,
                  activeColor: colorWhite,
                  activeTrackColor: colorPrimary,
                  inactiveTrackColor: colorGrey,
                  inactiveThumbColor: colorWhite,
                  onChanged: (value) {
                    setState(() => isActive = value);
                  },
                ),
                const SizedBox(width: 8),
                const Text(
                  'تعيين كموقع أفتراضي',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: Colors.white,
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
      fab: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
        color: colorBlack,
        child: MyLoadingButton(
          title: "add".tr,
          onClick: (p0) {
            p0.success();
            Future.delayed(const Duration(seconds: 1), () {
              Get.back();
            });
          },
        ),
      ),
    );
  }
}
