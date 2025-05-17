import 'package:flutter/material.dart';
import 'package:garage/core/ui/my_image.dart';
import 'package:garage/core/ui/widgets/my_text_form.dart';
import 'package:garage/routes/app_pages.dart';
import 'package:garage/theme/styles.dart';
import 'package:get/get.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SearchController logic = Get.put(SearchController());

    return Scaffold(
      backgroundColor: colorBlack,
      body: NestedScrollView(
        headerSliverBuilder:
            (context, innerBoxIsScrolled) => [
              SliverAppBar(
                iconTheme: const IconThemeData(color: colorWhite),
                surfaceTintColor: colorBlack,
                pinned: true,
                backgroundColor: colorBlack,
                title: MyTextForm(
                  hasIconConstraints: false,
                  hint: "what_you_looking_for".tr,
                  icon: const MyImage(
                    image: "assets/images/ic_search.svg",
                    height: 10,
                    width: 10,
                    fit: BoxFit.scaleDown,
                  ),
                  onSubmitted: (v) {
                    // Get.toNamed(Routes.SEARCH, arguments: {MyArguments.SEARCH: v});
                  },
                ),
              ),
            ],
        body: ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          itemBuilder:
              (context, index) => InkWell(
                onTap: () {
                  // Get.toNamed(Routes.CATEGORIES_DETAILS),
                },
                child: const SearchCompanyItem(),
              ),
          separatorBuilder: (context, index) => const Divider(),
          itemCount: 10,
        ),
      ),
    );
  }
}

class SearchCompanyItem extends StatelessWidget {
  const SearchCompanyItem({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          MyImage(
            image: "assets/images/bar_bg.png",
            width: 64,
            height: 64,
            fit: BoxFit.cover,
          ),
          SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'خدمة غسيل سيارة',

                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontFamily: 'Zain',
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'شركة المجد للصيانة',
                style: TextStyle(
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
