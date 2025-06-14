import 'package:flutter/material.dart';
import 'package:garage/core/ui/LoadingWidget.dart';
import 'package:garage/core/ui/select_drop_list%20.dart';
import 'package:garage/features/auth/company_profile_edit/company_profile_edit_controller.dart';
import 'package:garage/features/auth/company_profile_edit/company_profile_edit_state.dart';
import 'package:garage/theme/styles.dart';
import 'package:get/get.dart';

class WorkCategoriesDropDown extends StatefulWidget {
  final CompanyProfileEditController controller;
  final CompanyProfileEditState state;
  const WorkCategoriesDropDown({
    super.key,
    required this.controller,
    required this.state,
  });

  @override
  State<WorkCategoriesDropDown> createState() => _WorkCategoriesDropDownState();
}

class _WorkCategoriesDropDownState extends State<WorkCategoriesDropDown> {
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return LoadingWidget(
        loadingState: widget.state.categoriesList.value,
        child: SelectDropList(
          selectedItem: OptionItem(id: null, title: null),
          dropListModel: DropListModel(
            widget.state.categoriesList.value.data != null
                ? widget.state.categoriesList.value.data!
                    .map((e) => OptionItem(id: e.id.toString(), title: e.name))
                    .toList()
                : [],
          ),
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
        ),
      );
    });
  }
}
