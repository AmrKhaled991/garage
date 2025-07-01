import 'package:flutter/material.dart';
import 'package:garage/core/networking/models/provider_details_response/time.dart';
import 'package:garage/core/ui/sheet/normal_sheet.dart';
import 'package:garage/features/main/company/company_page_details/custom_company_list_tile_button.dart';
import 'package:garage/features/other/sheet/area_sheet.dart';
import 'package:garage/features/other/sheet/work_time_sheet.dart';
import 'package:garage/theme/styles.dart';
import 'package:garage/utils/links_utils.dart';
import 'package:garage/utils/utlis.dart';
import 'package:get/get.dart';

class CompanyTimeAndLocationSection extends StatelessWidget {
  final List<Time>? times;
  final String? address;
  final String? lng;
  final String? lat;
  const CompanyTimeAndLocationSection({
    super.key,
    this.times,
    this.address,
    this.lng,
    this.lat,
  });

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
              title: Text(
                address ?? '44 طريق شارع الفهيدي, العاصمة, الكويت',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontFamily: 'Zain',
                  fontWeight: FontWeight.w400,
                ),
              ),
              trailing: CustomCompanyListTileButton(
                title: 'open_map'.tr,
                onPress:
                    () => LinkHelper.openLink(
                      'https://www.google.com/maps/search/?api=1&query=$lat,$lng',
                    ),
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
                      title: "work_time".tr,
                      child: WorkTimeSheet(times: times),
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
