import 'package:flutter/material.dart';
import 'package:garage/core/ui/MyLoadingButton.dart';
import 'package:garage/core/ui/my_image.dart';
import 'package:garage/core/ui/my_scaffold.dart';
import 'package:garage/core/ui/widgets/my_text_form.dart';
import 'package:garage/features/main/add_new_address/add_new_address_logic.dart';
import 'package:garage/features/main/adress/address_controller.dart';
import 'package:garage/routes/app_pages.dart';
import 'package:garage/theme/styles.dart';
import 'package:get/get.dart';

class AddNewAddressPage extends StatefulWidget {
  const AddNewAddressPage({Key? key}) : super(key: key);

  @override
  State<AddNewAddressPage> createState() => _AddNewAddressPageState();
}

class _AddNewAddressPageState extends State<AddNewAddressPage> {
  final AddNewAddressController controller =
      Get.find<AddNewAddressController>();
  final state = Get.put(AddNewAddressController()).state;

  bool isActive = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isActive = controller.state.isActive.value ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      title: "add_new_address".tr,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          spacing: 8,
          children: [
            GestureDetector(
              onTap: () => Get.toNamed(Routes.MAP, arguments: "addAddress"),
              child: Container(
                decoration: BoxDecoration(
                  color: colorContainer,
                  borderRadius: BorderRadiusDirectional.circular(8),
                ),
                child: Obx(() {
                  var mapDesc = state.mapDesc.value;
                  return ListTile(
                    trailing: const MyImage(
                      image: "assets/images/ic_location.svg",
                      width: 24,
                    ),
                    title: Text(
                      "address".tr,
                      style: const TextStyle(
                        color: Color(0xFF9E9B94),
                        fontSize: 14,
                        fontFamily: 'Zain',
                        fontWeight: FontWeight.w400,
                        height: 1.50,
                      ),
                    ),
                    subtitle: Text(
                      mapDesc ?? "select_location".tr,
                      style: const TextStyle(
                        color: Color(0xFFF7F8F9),
                        fontSize: 18,
                        fontFamily: 'Zain',
                        fontWeight: FontWeight.w400,
                        height: 1.20,
                      ),
                    ),
                  );
                }),
              ),
            ),
            MyTextForm(
              controller: state.name,
              hint: "name".tr,
              textInputType: TextInputType.text,
            ),
            MyTextForm(
              controller: state.details,
              hint: "address_details".tr,
              textInputType: TextInputType.text,
            ),
            MyTextForm(
              controller: state.extraDetails,
              hint: "address_details_optional".tr,
              textInputType: TextInputType.text,
              lines: 5,
            ),
            Row(
              children: [
                Switch(
                  value: isActive,
                  activeColor: colorWhite,
                  activeTrackColor: colorPrimary,
                  inactiveTrackColor: colorGrey,
                  inactiveThumbColor: colorWhite,
                  onChanged: (value) {
                    setState(() => isActive = value);
                    state.isDefault.value = value;
                  },
                ),
                const SizedBox(width: 8),
                Text(
                  "set_default_location".tr,
                  textAlign: TextAlign.right,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontFamily: 'Zain',
                    fontWeight: FontWeight.w400,
                    height: 1.50,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      fab: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
        color: colorBlack,
        child: MyLoadingButton(
          title: "add".tr,
          onClick: (p0) {
            if (controller.validate()) {
              controller.addNewAddress(
                body: {
                  "title": state.name.text,
                  "description": state.details.text,
                  "extra_description": state.extraDetails.text,
                  "is_default": state.isDefault.value,
                  "is_active": state.isDefault.value,
                  "lat": state.lat.value,
                  "lng": state.lng.value,
                },
                onFinish: (success) {
                  if (success) {
                    p0.success();
                    Future.delayed(const Duration(seconds: 1), () {
                      Get.back();
                      Get.find<UserAddressController>().state.pagingController
                          .refresh();
                    });
                  } else {
                    p0.error();
                  }
                },
              );
            } else {
              p0.error();
            }
            Future.delayed(const Duration(seconds: 1), () {
              p0.reset();
            });
          },
        ),
      ),
    );
  }
}
