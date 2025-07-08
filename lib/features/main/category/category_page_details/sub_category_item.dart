import 'package:flutter/material.dart';
import 'package:garage/core/networking/models/category.dart';
import 'package:garage/theme/styles.dart';

class SubCategoryItem extends StatelessWidget {
  final Category? categoryData;
  final bool isSelected;
  VoidCallback? onClick;
  SubCategoryItem({
    Key? key,
    this.categoryData,
    required this.isSelected,
    this.onClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (onClick != null) onClick!();
      },
      child: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: ShapeDecoration(
            color: isSelected ? colorPrimary : backgroundCustomChipColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          child: Text(
            categoryData?.name ?? "",
            textAlign: TextAlign.right,
            style: TextStyle(
              color: isSelected ? colorBlack : backgroundCustomChipTextColor,
              fontSize: 14,
              fontFamily: 'Zain',
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}
