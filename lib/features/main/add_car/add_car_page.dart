import 'dart:async';

import 'package:flutter/material.dart';
import 'package:garage/core/ui/MyLoadingButton.dart';
import 'package:garage/core/ui/my_scaffold.dart';
import 'package:garage/core/ui/select_drop_list%20.dart';
import 'package:garage/core/ui/widgets/my_text_form.dart';
import 'package:garage/routes/app_pages.dart';
import 'package:garage/theme/styles.dart';
import 'package:get/get.dart';
import 'package:rounded_loading_button_plus/rounded_loading_button.dart';

class AddCarPage extends StatelessWidget {
  const AddCarPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      title: "add_car".tr,
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          spacing: 16,
          children: [
            const BrandDropDown(),

            MyTextForm(hint: "model".tr, textInputType: TextInputType.text),
            MyTextForm(
              hint: "model_year".tr,
              textInputType: TextInputType.text,
            ),
            MyTextForm(
              hint: "owner_name".tr,
              textInputType: TextInputType.text,
            ),
            const Spacer(),
            MyLoadingButton(
              title: "add_car".tr,
              onClick: (RoundedLoadingButtonController _controller) {
                _controller.success();

                Timer(const Duration(seconds: 1), () {
                  _controller.reset();
                  Get.offAllNamed(Routes.MAIN);
                });
                // if (!controller.validations()) {
                // _controller.error();
                // Timer(const Duration(seconds: 1), () {
                //   _controller.reset();
                // });
                // return;
                // }
                // userController.loginUser(
                //   withPhone: true,
                //   phoneCode: "965",
                //   emailOrPhone: state.phoneOrEmail.text,
                //   password: state.password.text,
                //   onFinish: (success) async {
                //     if (success) {
                //       _controller.success();
                //     } else {
                //       _controller.error();
                //     }
                //     Timer(const Duration(seconds: 1), () {
                //       _controller.reset();
                //     });
                //   },
                // );
              },
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

class BrandDropDown extends StatefulWidget {
  const BrandDropDown({super.key});

  @override
  State<BrandDropDown> createState() => _WorkCategoriesDropDownState();
}

class _WorkCategoriesDropDownState extends State<BrandDropDown> {
  @override
  Widget build(BuildContext context) {
    return SelectDropList(
      selectedItem: OptionItem(id: "3", title: "select_brand".tr),
      dropListModel: DropListModel([
        OptionItem(id: "1", title: "toyota"),
        OptionItem(id: "2", title: "mercedes"),
        OptionItem(id: "3", title: "bmw"),
      ]),
      onOptionSelected: (item) {
        setState(() {});
      },
      selectedTextStyle: const TextStyle(color: colorWhite, fontSize: 18),
      dropDownDecoration: const BoxDecoration(color: colorContainer),
      itemTextStyle: const TextStyle(color: colorWhite),
      iconColor: colorWhite,
      boxDecoration: BoxDecoration(
        color: colorContainer,
        borderRadius: BorderRadius.circular(16),
      ),
    );
  }
}
