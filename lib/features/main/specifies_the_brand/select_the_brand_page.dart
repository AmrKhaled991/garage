import 'package:flutter/material.dart';
import 'package:garage/core/networking/models/brand/brand.dart';
import 'package:garage/core/ui/LoadingWidget.dart';
import 'package:garage/core/ui/MyButton.dart';
import 'package:garage/core/ui/my_scaffold.dart';
import 'package:garage/features/main/specifies_the_brand/selet_the_brand_binding_details.dart/custom_brand_card.dart';
import 'package:garage/routes/app_pages.dart';
import 'package:garage/routes/arguments.dart';
import 'package:garage/theme/styles.dart';
import 'package:garage/utils/utlis.dart';
import 'package:get/get.dart';

import 'select_the_brand_controller.dart';

class SelectTheBrandPage extends StatelessWidget {
  const SelectTheBrandPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SelectTheBrandController logic = Get.find<SelectTheBrandController>();
    return MyScaffold(
      title: "select_car_model_brand".tr,
      body: Obx(() {
        var selectedBrandId = logic.state.selectedBrandId.value;
        var brands = logic.state.brands.value.data;
        return LoadingWidget(
          loadingState: logic.state.brands.value,
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
                (context, index) => GestureDetector(
                  onTap: () {
                    logic.selectBrand(brands?[index].id, brands?[index].name);
                  },
                  child: CustomBrandCard(
                    isSelected: selectedBrandId == brands?[index].id,
                    brand: brands?[index],
                  ),
                ),
            itemCount: brands?.length ?? 0,
          ),
        );
      }),
      fab: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
        color: colorBlack,
        child: MyButton(
          title: "add_car".tr,
          onClick: () {
            if (logic.state.selectedBrandId.value == null) {
              Utils.showSnackBar("please_select_a_brand".tr);
              return;
            }
            Get.toNamed(
              Routes.ADDCARPAGEKEY,
              arguments: {
                MyArguments.BRAND_ID: logic.state.selectedBrandId.value,
                MyArguments.BRAND_NAME: logic.state.selectedBrandName.value,
              },
            );
          },
        ),
      ),
    );
  }
}
