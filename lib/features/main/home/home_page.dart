// ignore_for_file: public_member_api_docs, sort_constructors_first
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
                  child: MyTextForm(
                    hasIconConstraints: false,
                    hint: "what_you_looking_for".tr,
                    icon: const Icon(Icons.search_rounded, color: Colors.white),
                    onSubmitted: (v) {
                      // Get.toNamed(Routes.SEARCH, arguments: {MyArguments.SEARCH: v});
                    },
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
            const SizedBox(height: 12),
            SliderView(
              items: const [
                MyImage(image: "assets/images/bar_bg.png"),
                MyImage(image: "assets/images/bar_bg.png"),
                MyImage(image: "assets/images/bar_bg.png"),
                MyImage(image: "assets/images/bar_bg.png"),
              ],
            ),
            TextHeaderWidget(
              title: "recently_viewed".tr,
              child: const AddContainer(title: 'أضف سيارة'),
            ),
            const SizedBox(height: 24),
            TextHeaderWidget(
              title: "الأقسام".tr,
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
