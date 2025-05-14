import 'package:flutter/material.dart';
import 'package:garage/core/ui/MyButton.dart';
import 'package:garage/core/ui/my_scaffold.dart';
import 'package:garage/features/main/specifies_the_brand/selet_the_brand_binding_details.dart/custom_brand_card.dart';
import 'package:garage/routes/app_pages.dart';
import 'package:garage/theme/styles.dart';
import 'package:get/get.dart';

import 'select_the_brand_controller.dart';

class SelectTheBrandPage extends StatelessWidget {
  const SelectTheBrandPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SelectTheBrandController logic = Get.put(SelectTheBrandController());

    return MyScaffold(
      title: "select_car_model_brand".tr,
      body: Expanded(
        child: GridView.builder(
          padding: const EdgeInsets.only(
            left: 8,
            right: 8,
            bottom: 100,
            top: 16,
          ),
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            childAspectRatio: 1.04,
          ),
          itemBuilder:
              (context, index) => const CustomBrandCard(
                image: "assets/images/ic_home.svg",
                text: "الاثائة",
              ),
          itemCount: 80,
        ),
      ),
      fab: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
        color: colorBlack,
        child: MyButton(
          title: "add_car".tr,
          onClick: () => {Get.toNamed(Routes.ADDCARPAGEKEY)},
        ),
      ),
    );
  }
}
