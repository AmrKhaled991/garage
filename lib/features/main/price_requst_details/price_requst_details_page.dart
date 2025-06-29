import 'package:flutter/material.dart';
import 'package:garage/core/helpers/time_formater.dart';
import 'package:garage/core/networking/models/user_prices_request/user_prices_request.dart';
import 'package:garage/core/ui/my_image.dart';
import 'package:garage/core/ui/my_scaffold.dart';
import 'package:garage/theme/styles.dart';
import 'package:get/get.dart';

class PriceRequestDetailsPage extends StatelessWidget {
  final UserPricesRequest item = Get.arguments;

  PriceRequestDetailsPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      title: "price_requst_details".tr,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          spacing: 8,
          children: [
            const SizedBox(height: 30),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: MyshapesStyle.transparentDecoration,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: ShapeDecoration(
                          color: const Color(0xFF604106),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          'مكتمله',

                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontFamily: 'Zain',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      const Text(
                        'طقم سماعات سيارة',

                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontFamily: 'Zain',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const Text(
                        'شركة المجد للاكسسوارت',

                        style: TextStyle(
                          color: Color(0xFFCCCAC7),
                          fontSize: 16,
                          fontFamily: 'Zain',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    clipBehavior: Clip.antiAlias,
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(
                          width: 2,
                          color: Color(0xFF10B981),
                        ),
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),

                    child: const MyImage(
                      image: "assets/images/ic_call.svg",
                      height: 30,
                      width: 30,
                    ),
                  ),
                ],
              ),
            ),
            Row(
              spacing: 8,
              children: [
                Expanded(
                  child: PriceRequestDetailsSection(
                    header: "الكمية".tr,
                    text: item.quantity.toString(),
                  ),
                ),
                Expanded(
                  child: PriceRequestDetailsSection(
                    header: "نوع الخدمة".tr,
                    text: "أكسسوارت".tr,
                  ),
                ),
              ],
            ),
            PriceRequestDetailsSection(
              header: "الوقت والتاريخ".tr,
              text: item.createdAt.toString().substring(0, 10),
              subtext: DateTimeFormatter.convert24to12(
                item.createdAt.toString().substring(11, 16),
              ),
            ),
            PriceRequestDetailsSection(
              header: "عنوان مركز الصيانه ".tr,
              text: "لا 44 طريق شارع الفهيدي, العاصمة, الكويت".tr,
            ),
          ],
        ),
      ),
    );
  }
}

class PriceRequestDetailsSection extends StatelessWidget {
  final String header;
  final String text;
  final String? subtext;
  const PriceRequestDetailsSection({
    super.key,
    required this.header,
    required this.text,
    this.subtext,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: MyshapesStyle.transparentDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            header.tr,

            style: const TextStyle(
              color: Color(0xFFCCCAC7),
              fontSize: 14,
              fontFamily: 'Zain',
              fontWeight: FontWeight.w400,
              height: 1.50,
            ),
          ),
          Text(
            text.tr,

            style: const TextStyle(
              color: colorWhite,
              fontSize: 18,
              fontFamily: 'Zain',
              fontWeight: FontWeight.w400,
              height: 1.20,
            ),
          ),
          if (subtext != null) ...[
            Text(
              subtext?.tr ?? "",

              style: const TextStyle(
                color: Color(0xFF9E9B94),
                fontSize: 18,
                fontFamily: 'Zain',
                fontWeight: FontWeight.w400,
                height: 1.20,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
