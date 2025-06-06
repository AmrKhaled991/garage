// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:garage/features/main/home/custom_category_card.dart';
import 'package:garage/routes/app_pages.dart';
import 'package:get/get.dart';

import 'package:garage/core/ui/my_image.dart';
import 'package:garage/core/ui/my_scaffold.dart';
import 'package:garage/core/ui/widgets/my_text_form.dart';
import 'package:garage/core/ui/widgets/slider_view.dart';
import 'package:garage/features/main/common/add_container.dart';
import 'package:garage/features/main/common/text_header_widget.dart';
import 'package:garage/theme/styles.dart';

import 'home_logic.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomeController logic = Get.put(HomeController());

    return MyScaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              spacing: 8,
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => Get.toNamed(Routes.SEARCH),
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: MyshapesStyle.PrimaryDecoration,
                      child: const Row(
                        spacing: 8,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          MyImage(image: "assets/images/ic_search.svg"),
                          Text(
                            'البحث عن مركز خدمة',
                            style: TextStyle(
                              color: Color(0xFF9E9B94),
                              fontSize: 16,
                              fontFamily: 'Zain',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(width: 1, color: colorContainer),
                  ),
                  padding: const EdgeInsets.all(12),
                  child: const MyImage(
                    image: "assets/images/ic_notifications.svg",
                    width: 30,
                    height: 30,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),

            const HomeSlider(),
            const SizedBox(height: 12),

            TextHeaderWidget(
              title: "recently_viewed".tr,
              child: AddContainer(
                title: 'أضف سيارة',
                onTap: () {
                  Get.toNamed(Routes.SelectTheBrandPageKey);
                },
              ),
            ),
            const SizedBox(height: 24),
            TextHeaderWidget(
              title: "categories".tr,
              child: SizedBox(
                width: Get.width,
                child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  itemBuilder:
                      (context, index) => CustomCategoryCard(
                        image: "assets/images/ic_home.svg",
                        text: "الاثائة",
                        onTab: () {
                          Get.toNamed(
                            Routes.CATEGRYPAGEKEY,
                            parameters: {'title': "الاثائة"},
                          );
                        },
                      ),
                  itemCount: 10,
                ),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

class HomeSlider extends StatefulWidget {
  const HomeSlider({super.key});

  @override
  State<HomeSlider> createState() => _HomeSliderState();
}

class _HomeSliderState extends State<HomeSlider> {
  final List<String> imageList = [
    "assets/images/test_image.png",
    "assets/images/test_image.png",
    "assets/images/test_image.png",
  ];
  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: imageList.length,
      itemBuilder: (context, index, realIndex) {
        return InkWell(
          onTap: () {},
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              image: DecorationImage(
                image: AssetImage(imageList[index]),
                fit: BoxFit.cover,
              ),
            ),
          ),
        );
      },
      options: CarouselOptions(
        autoPlay: true,
        autoPlayAnimationDuration: const Duration(seconds: 1),
        height: 164,
        enlargeCenterPage: true,
        viewportFraction: 0.83,
        onPageChanged: (index, reason) {},
      ),
    );
  }
}
