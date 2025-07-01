// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:garage/features/main/adress/address_controller.dart';
import 'package:garage/routes/app_pages.dart';
import 'package:get/get.dart';

import 'package:garage/core/networking/models/adress/user_address.dart';
import 'package:garage/core/ui/my_image.dart';
import 'package:garage/theme/styles.dart';

class AddressItem extends StatefulWidget {
  UserAddress? item;
  AddressItem({Key? key, this.item}) : super(key: key);

  @override
  State<AddressItem> createState() => _AddressItemState();
}

class _AddressItemState extends State<AddressItem> {
  final controller = Get.find<UserAddressController>();
  bool isActive = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isActive = widget.item?.isActive ?? false;
  }

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
              Text(
                widget.item?.title ?? 'المنزل 1',
                style: const TextStyle(
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
                  value:  isActive,
                  activeColor: colorWhite,
                  activeTrackColor: colorPrimary,
                  inactiveTrackColor: colorGrey,
                  inactiveThumbColor: colorWhite,
                  onChanged: (value)async {
                    setState(() => isActive = value);
                    await Future.delayed(const Duration(milliseconds: 300));
                    controller.changeActivation(widget.item?.id ?? 0, (
                      success,
                    ) {
                      if (!success) {
                        setState(() => isActive = !isActive);
                      }
                    });
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const MyImage(image: 'assets/images/location.svg', height: 20),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  widget.item?.description ?? '44 طريق شارع الفهيدي',
                  style: const TextStyle(
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
                onPressed: () {
                  
                  final id = widget.item?.id;
                  if (id != null) {
                    controller.deleteAddress(id, (success) {
                      if (success) {
                        controller.state.pagingController
                            .refresh(); // Reload list after delete
                      }
                    });
                  }
                },
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
                onPressed: () {
                  Get.toNamed(Routes.AddNewAddressPage, arguments: widget.item);
                },
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
