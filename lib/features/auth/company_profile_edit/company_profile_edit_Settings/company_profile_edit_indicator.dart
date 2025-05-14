import 'package:flutter/material.dart';
import 'package:garage/features/auth/company_profile_edit/company_profile_edit_page.dart';
import 'package:garage/theme/styles.dart';

class CompanyProfileEditIndicator extends StatefulWidget {
  final int currentPage;
  const CompanyProfileEditIndicator({super.key, required this.currentPage});

  @override
  State<CompanyProfileEditIndicator> createState() => _UserTypeSelectorState();
}

class _UserTypeSelectorState extends State<CompanyProfileEditIndicator> {
  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 8,
      children: [
        Expanded(
          child: Container(
            height: 5,
            decoration: BoxDecoration(
              borderRadius: BorderRadiusDirectional.circular(8),
              color: colorPrimary,
            ),
          ),
        ),
        Expanded(
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            height: 5,
            decoration: BoxDecoration(
              borderRadius: BorderRadiusDirectional.circular(8),
              color: widget.currentPage == 1 ? colorPrimary : colorContainer,
            ),
          ),
        ),
      ],
    );
  }
}
