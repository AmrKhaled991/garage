import 'dart:async';

import 'package:flutter/material.dart';
import 'package:garage/core/ui/MyLoadingButton.dart';
import 'package:garage/core/ui/my_scaffold.dart';
import 'package:garage/core/ui/select_drop_list%20.dart';
import 'package:garage/core/ui/widgets/my_text_form.dart';
import 'package:garage/features/main/add_car/add_car_controller.dart';
import 'package:garage/routes/app_pages.dart';
import 'package:garage/routes/arguments.dart';
import 'package:garage/theme/styles.dart';
import 'package:get/get.dart';
import 'package:rounded_loading_button_plus/rounded_loading_button.dart';

class AddCarPage extends StatelessWidget {
  final AddCarLogic addCarController = Get.find<AddCarLogic>();
  final int? brandId = Get.arguments[MyArguments.BRAND_ID];
  final String? brandName = Get.arguments[MyArguments.BRAND_NAME];

  AddCarPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    addCarController.state.brandId.value = brandId;
    addCarController.state.brandId.value = brandId;
    return MyScaffold(
      title: "add_car".tr,
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          spacing: 16,
          children: [
            Container(
              width: Get.width,
              padding: const EdgeInsets.all(16),
              decoration: MyshapesStyle.darkGrayDecoration,
              child: Center(
                child: Text(
                  brandName ?? "",
                  style: const TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),

            // const BrandDropDown(),,
            MyTextForm(
              controller: addCarController.state.model,
              hint: "model".tr,
              textInputType: TextInputType.text,
            ),
            MyTextForm(
              controller: addCarController.state.year,
              hint: "model_year".tr,
              textInputType: TextInputType.text,
            ),
            MyTextForm(
              controller: addCarController.state.carOwnerName,
              hint: "car_owner_name".tr,
              textInputType: TextInputType.text,
            ),
            const Spacer(),
            MyLoadingButton(
              title: "add_car".tr,
              onClick: (RoundedLoadingButtonController _controller) {
                addCarController.storCar((success) async {
                  if (success) {
                    _controller.success();
                  } else {
                    _controller.error();
                  }
                  Timer(const Duration(seconds: 1), () {
                    _controller.reset();
                  });
                });
              },
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

// class BrandDropDown extends StatefulWidget {
//   const BrandDropDown({super.key});

//   @override
//   State<BrandDropDown> createState() => _WorkCategoriesDropDownState();
// }

// class _WorkCategoriesDropDownState extends State<BrandDropDown> {
//   @override
//   Widget build(BuildContext context) {
//     return SelectDropList(
//       selectedItem: OptionItem(id: "3", title: "select_brand".tr),
//       dropListModel: DropListModel([
//         OptionItem(id: "1", title: "toyota"),
//         OptionItem(id: "2", title: "mercedes"),
//         OptionItem(id: "3", title: "bmw"),
//       ]),
//       onOptionSelected: (item) {
//         setState(() {});
//       },
//       selectedTextStyle: const TextStyle(color: colorWhite, fontSize: 18),
//       dropDownDecoration: const BoxDecoration(color: colorContainer),
//       itemTextStyle: const TextStyle(color: colorWhite),
//       iconColor: colorWhite,
//       boxDecoration: BoxDecoration(
//         color: colorContainer,
//         borderRadius: BorderRadius.circular(16),
//       ),
//     );
//   }
// }
