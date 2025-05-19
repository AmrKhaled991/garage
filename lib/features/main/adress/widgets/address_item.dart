import 'package:flutter/material.dart';
import 'package:garage/features/main/adress/address_page.dart';
import 'package:garage/theme/styles.dart';

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
              const Text(
                'الفرع يعمل',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontFamily: 'Zain',
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(width: 10),
              Switch(
                value: isActive,
                activeColor: colorWhite,
                activeTrackColor: colorPrimary,
                inactiveTrackColor: colorGrey,
                inactiveThumbColor: colorWhite,
                onChanged: (value) {
                  setState(() => isActive = value);
                },
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Row(
            children: [
              Icon(Icons.location_on, color: Colors.white),
              SizedBox(width: 4),
              Expanded(
                child: Text(
                  '44 طريق شارع الفهيدي',
                  textAlign: TextAlign.right,
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
                icon: const Icon(Icons.delete, color: Colors.red),
                label: const Text('حذف', style: TextStyle(color: Colors.red)),
              ),
              TextButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.edit, color: Colors.white),
                label: const Text(
                  'تعديل',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
