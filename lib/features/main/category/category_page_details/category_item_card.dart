import 'package:flutter/material.dart';
import 'package:garage/core/ui/my_image.dart';
import 'package:garage/routes/app_pages.dart';
import 'package:garage/theme/styles.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';

class CategoryItemCard extends StatelessWidget {
  final bool displayLocation;
  const CategoryItemCard({super.key, this.displayLocation = true});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        displayLocation ? Get.toNamed(Routes.COMPANYkEY) : null;
      },
      child: Container(
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
                    child: const MyImage(
                      image: "assets/images/bar_bg.png",
                      width: 64,
                      height: 64,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'شركة جراج أونلاين للصيانه',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontFamily: 'Zain',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'مركز تغيير زيوت و صيانه سيارات',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            color: Color(0xFFCCCAC7),
                            fontSize: 12,
                            fontFamily: 'Zain',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            if (displayLocation) ...[
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: ShapeDecoration(
                  color: const Color(0xFF3D3D3D),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  spacing: 5,
                  children: [
                    Icon(Icons.location_on, color: Colors.white, size: 16),
                    Text(
                      '44 طريق شارع الفهيدي, العاصمة, الكويت',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontFamily: 'Zain',
                        fontWeight: FontWeight.w400,
                        height: 1.50,
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
