import 'package:flutter/material.dart';
import 'package:garage/core/ui/my_image.dart';
import 'package:garage/core/ui/sliver_app_bar_delegate.dart';
import 'package:garage/features/main/category/category_page_details/company_item_card.dart';
import 'package:garage/features/main/category/category_page_details/sub_category_item.dart';
import 'package:garage/routes/app_pages.dart';
import 'package:garage/theme/styles.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class CategoryPage extends StatelessWidget {
  CategoryPage({Key? key}) : super(key: key);
  String? title;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorBlack,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              actionsPadding: const EdgeInsets.symmetric(horizontal: 8.0),
              backgroundColor: colorBlack,
              leading: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                ),
              ),
              actions: [
                GestureDetector(
                  onTap: () => Get.toNamed(Routes.SEARCH),
                  child: const MyImage(image: "assets/images/ic_search.svg"),
                ),
              ],
              title: const Text(
                'طاقة والوقود',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFFF7F8F9),
                  fontSize: 20,
                  fontFamily: 'Zain',
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            SliverPersistentHeader(
              pinned: true,
              delegate: SliverAppBarDelegate(
                Container(
                  height: 48,
                  color: colorBlack,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 8,
                  ),
                  child: ListView(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    children: [
                      SubCategoryItem(
                        // categoryData: OffersCategory(id: 0, name: "all".tr),
                        isSelected: true,
                        // state.selectedSubcategories.value == null,
                        onClick: () {
                          // if (state.selectedSubcategories.value == null)
                          //   return;
                          // state.selectedSubcategories.value = null;
                          // controller.fetchOffers(forceRefresh: true);
                        },
                      ),
                      const SizedBox(width: 8),
                      ListView.separated(
                        separatorBuilder:
                            (context, index) => const SizedBox(width: 8),
                        itemBuilder: (context, index) {
                          // var item = state.categories.value.data?.elementAt(
                          //   index,
                          // );
                          return SubCategoryItem(
                            isSelected: false,
                            // state.selectedSubcategories.value ==
                            // item?.id,
                            // categoryData: item,
                            onClick: () {
                              // if (state.selectedSubcategories.value ==
                              //     item?.id)
                              //   return;
                              // state.selectedSubcategories.value = item?.id;
                              // controller.fetchOffers(forceRefresh: true);
                            },
                          );
                        },
                        itemCount: 8,
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: ListView.separated(
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                padding: const EdgeInsets.symmetric(
                  horizontal: 8.0,
                  vertical: 16.0,
                ),
                separatorBuilder: (context, index) => const SizedBox(height: 8),
                itemBuilder: (context, index) => const CompanyItemCard(),
                itemCount: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
