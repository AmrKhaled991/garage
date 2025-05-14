import 'package:flutter/material.dart';
import 'package:garage/core/ui/select_drop_list%20.dart';
import 'package:garage/features/auth/company_profile_edit/company_profile_edit_Settings/company_profile_edit_view1.dart';
import 'package:garage/theme/styles.dart';

class WorkCategoriesDropDown extends StatefulWidget {
  const WorkCategoriesDropDown({super.key});

  @override
  State<WorkCategoriesDropDown> createState() => _WorkCategoriesDropDownState();
}

class _WorkCategoriesDropDownState extends State<WorkCategoriesDropDown> {
  @override
  Widget build(BuildContext context) {
    return SelectDropList(
      selectedItem: OptionItem(id: "1", title: "amr"),
      dropListModel: DropListModel([
        OptionItem(id: "1", title: "amr"),
        OptionItem(id: "2", title: "3223"),
        OptionItem(id: "3", title: "a32323mr"),
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
