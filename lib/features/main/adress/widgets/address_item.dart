import 'package:flutter/material.dart';
import 'package:garage/core/ui/my_image.dart';
import 'package:garage/features/main/adress/address_page.dart';
import 'package:garage/theme/styles.dart';
import 'package:get/get.dart';

class AddressItem extends StatefulWidget {
  const AddressItem({super.key});

  @override
  State<AddressItem> createState() => _AddressItemState();
}

class _AddressItemState extends State<AddressItem> {
  bool isActive = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: MyshapesStyle.PrimaryDecoration,
      padding: const EdgeInsets.all(12),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text(
                'المنزل 1',
                style: TextStyle(
                  color: Color(0xFFF7F8F9),
                  fontSize: 20,
                  fontFamily: 'Zain',
                  fontWeight: FontWeight.w700,
                ),
              ),
              const Spacer(),
              Text(
                "branch_working".tr,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontFamily: 'Zain',
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(width: 10),
              Transform.scale(
                scale: 0.9,
                child: Switch(
                  value: isActive,
                  activeColor: colorWhite,
                  activeTrackColor: colorPrimary,
                  inactiveTrackColor: colorGrey,
                  inactiveThumbColor: colorWhite,
                  onChanged: (value) {
                    setState(() => isActive = value);
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MyImage(image: 'assets/images/location.svg', height: 20),
              SizedBox(width: 4),
              Expanded(
                child: Text(
                  '44 طريق شارع الفهيدي',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontFamily: 'Zain',
                    fontWeight: FontWeight.w400,
                    height: 1.50,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton.icon(
                onPressed: () {},
                icon: const MyImage(
                  image: 'assets/images/trash.svg',
                  height: 20,
                ),
                label: Text(
                  "delete".tr,
                  style: const TextStyle(color: Color(0xFFF87171)),
                ),
              ),
              TextButton.icon(
                onPressed: () {},
                icon: const MyImage(
                  image: 'assets/images/edit.svg',
                  height: 20,
                ),
                label: Text(
                  'edit'.tr,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
