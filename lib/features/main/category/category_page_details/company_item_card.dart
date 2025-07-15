import 'package:flutter/material.dart';
import 'package:garage/core/controllers/user_controller.dart';
import 'package:garage/core/networking/models/provider_response/provider_response.dart';
import 'package:garage/core/ui/my_image.dart';
import 'package:garage/core/ui/my_loading_widget.dart';
import 'package:garage/features/main/company/company_controller.dart';
import 'package:garage/routes/app_pages.dart';
import 'package:garage/theme/styles.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';
import 'package:lottie/lottie.dart';

class CompanyItemCard extends StatelessWidget {
  final String? address;
  final String? image;
  final String? title;
  final String? subTitle;
  final int? id;
  final bool showChat;

  const CompanyItemCard({
    Key? key,
    this.address,
    this.image,
    this.title,
    this.subTitle,
    this.id,
    this.showChat = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (address != null) Get.toNamed(Routes.COMPANYkEY, arguments: id);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        padding: const EdgeInsets.all(16),
        decoration: MyshapesStyle.PrimaryDecoration,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.zero,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: MyImage(
                      image: image ?? "assets/images/bar_bg.png",
                      width: 64,
                      height: 64,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title ?? 'شركة جراج أونلاين للصيانه',
                          textAlign: TextAlign.right,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontFamily: 'Zain',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          subTitle ?? 'مركز تغيير زيوت و صيانه سيارات',
                          textAlign: TextAlign.right,
                          style: const TextStyle(
                            color: Color(0xFFCCCAC7),
                            fontSize: 12,
                            fontFamily: 'Zain',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (showChat)
                    Obx(() {
                      final controller = Get.find<CompanyController>();
                      final userController = Get.find<UserController>();
                      return Visibility(
                        visible: userController.isLogged.value,
                        child: InkWell(
                          onTap: () {
                            print("element:111  $id");

                            controller.createRoom((success, roomId) {
                              if (success == true) {
                                Get.toNamed(Routes.CHAT, arguments: roomId);
                              }
                            });
                          },
                          child:
                              controller.createRoomLoading.value == true
                                  ? Lottie.asset('assets/lottie/loading.json')
                                  : const Center(
                                    child: Icon(
                                      Icons.chat,
                                      color: Colors.white,
                                      size: 24,
                                    ),
                                  ),
                        ),
                      );
                    }),
                ],
              ),
            ),
            if (address != null) ...[
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: MyshapesStyle.lightGrayDecoration,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  spacing: 5,
                  children: [
                    const Icon(
                      Icons.location_on,
                      color: Colors.white,
                      size: 16,
                    ),
                    Expanded(
                      child: Text(
                        address ?? '44 طريق شارع الفهيدي, العاصمة, الكويت',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontFamily: 'Zain',
                          fontWeight: FontWeight.w400,
                          height: 1.50,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
