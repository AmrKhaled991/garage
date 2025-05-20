import 'package:flutter/material.dart';
import 'package:garage/core/ui/sheet/normal_sheet.dart';
import 'package:garage/features/main/company/company_page_details/custom_company_list_tile_button.dart';
import 'package:garage/features/other/sheet/area_sheet.dart';
import 'package:garage/features/other/sheet/work_time_sheet.dart';
import 'package:garage/theme/styles.dart';
import 'package:garage/utils/utlis.dart';
import 'package:get/get.dart';

class CompanyTimeAndLocationSection extends StatelessWidget {
  const CompanyTimeAndLocationSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
        decoration: MyshapesStyle.PrimaryDecoration,
        child: Column(
          children: [
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.location_on, color: Colors.white),
              title: const Text(
                '44 طريق شارع الفهيدي, العاصمة, الكويت',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontFamily: 'Zain',
                  fontWeight: FontWeight.w400,
                ),
              ),
              trailing: CustomCompanyListTileButton(
                title: 'open_map'.tr,
                onPress: () => null,
              ),
            ),
            const Divider(color: Colors.grey, thickness: 0.50),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(
                Icons.access_time_filled_outlined,
                color: Colors.white,
              ),
              title: Text(
                'work_time'.tr,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontFamily: 'Zain',
                  fontWeight: FontWeight.w400,
                ),
              ),
              trailing: CustomCompanyListTileButton(
                title: 'details'.tr,
                onPress: () {
                  Utils.showSheet(
                    context,
                    NormalSheet(
                      title: "select_area".tr,
                      child: const WorkTimeSheet(),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
