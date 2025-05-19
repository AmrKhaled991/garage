import 'package:flutter/material.dart';
import 'package:garage/core/ui/my_scaffold.dart';
import 'package:garage/features/main/adress/widgets/address_item.dart';
import 'package:garage/routes/app_pages.dart';
import 'package:garage/theme/styles.dart';
import 'package:get/get.dart';

class AddressPage extends StatelessWidget {
  const AddressPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final AddressController controller = Get.put(AddressController());

    return MyScaffold(
      title: "address".tr,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          spacing: 16,
          children: [
            TextButton(
              style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  side: const BorderSide(color: colorWhite, strokeAlign: 1),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
              ),
              onPressed: () => Get.toNamed(Routes.AddNewAddressPage),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 8,
                children: [
                  Icon(Icons.add, size: 25, color: Colors.white),
                  Text(
                    'إضافة عنوان جديد',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontFamily: 'Zain',
                      fontWeight: FontWeight.w700,
                      height: 1.50,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.separated(
                itemBuilder:
                    (context, index) => InkWell(
                      onTap: () => Get.toNamed(Routes.AddNewAddressPage),
                      child: const AddressItem(),
                    ),
                separatorBuilder: (context, index) => const SizedBox(height: 8),
                itemCount: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
