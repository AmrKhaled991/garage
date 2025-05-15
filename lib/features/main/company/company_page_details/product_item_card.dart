import 'package:flutter/material.dart';
import 'package:garage/core/ui/my_image.dart';
import 'package:garage/theme/styles.dart';

class ProductItemCard extends StatelessWidget {
  final Function? onTap;
  const ProductItemCard({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap?.call();
      },
      child: Column(
        spacing: 9,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Stack(
              children: [
                Container(
                  decoration: MyshapesStyle.SecondaryDecoration,
                  child: const Center(
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: MyImage(
                        image: "assets/images/logo1.svg",
                        fit: BoxFit.scaleDown,
                        width: 110,
                        height: 110,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  right: 8,
                  bottom: 8,
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.add_circle_rounded,
                      color: colorPrimary,
                      size: 30,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Text(
            'بطارية فور جو 100 أمبير',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontFamily: 'Zain',
              fontWeight: FontWeight.w700,
            ),
          ),
          const Text(
            'بلد المنشأ: الصين',
            style: TextStyle(
              color: Color(0xFFCCCAC7),
              fontSize: 12,
              fontFamily: 'Zain',
              fontWeight: FontWeight.w400,
            ),
          ),
          const Text(
            '50 دينار كويتي',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontFamily: 'Zain',
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
