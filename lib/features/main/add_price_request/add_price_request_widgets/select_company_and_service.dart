import 'package:flutter/material.dart';
import 'package:garage/core/ui/select_drop_list%20.dart';
import 'package:garage/features/main/add_price_request/add_price_request_page.dart';
import 'package:garage/theme/styles.dart';

class SelectCompanyAndService extends StatefulWidget {
  const SelectCompanyAndService({super.key});

  @override
  State<SelectCompanyAndService> createState() =>
      _SelectCompanyAndServiceState();
}

class _SelectCompanyAndServiceState extends State<SelectCompanyAndService> {
  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 8,
      children: [
        SelectDropList(
          selectedItem: OptionItem(id: "1", title: "company1"),
          dropListModel: DropListModel([
            OptionItem(id: "1", title: "company1"),
            OptionItem(id: "2", title: "company2"),
            OptionItem(id: "3", title: "company3"),
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
        ),
        SelectDropList(
          selectedItem: OptionItem(id: "1", title: "service1"),
          dropListModel: DropListModel([
            OptionItem(id: "1", title: "service1"),
            OptionItem(id: "2", title: "service2"),
            OptionItem(id: "3", title: "service3"),
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
        ),
      ],
    );
  }
}
