import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:garage/core/ui/my_image.dart';

class SearchCompanyItem extends StatelessWidget {
  final String? image;
  final String? title;
  final String? subTitle;
  final int? id;
  const SearchCompanyItem({
    super.key,
    this.image,
    this.title,
    this.subTitle,
    this.id,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          MyImage(
            image: image ?? "assets/images/bar_bg.png",
            width: 64,
            height: 64,
            fit: BoxFit.cover,
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title ?? 'خدمة غسيل سيارة',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontFamily: 'Zain',
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subTitle ?? 'شركة المجد للصيانة',
                style: const TextStyle(
                  color: Color(0xFFCCCAC7),
                  fontSize: 12,
                  fontFamily: 'Zain',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
