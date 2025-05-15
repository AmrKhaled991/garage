import 'package:flutter/material.dart';
import 'package:garage/core/ui/my_image.dart';
import 'package:garage/core/ui/sliver_app_bar_delegate.dart';
import 'package:garage/features/main/category/category_page_details/company_item_card.dart';
import 'package:garage/features/main/company/company_page_details/company_time_and_location_section.dart';
import 'package:garage/features/main/company/company_page_details/custom_company_list_tile_button.dart';
import 'package:garage/features/main/company/company_page_details/product_item_card.dart';
import 'package:garage/routes/app_pages.dart';
import 'package:garage/theme/styles.dart';
import 'package:get/get.dart';

import 'company_controller.dart';

class CompanyPage extends StatefulWidget {
  const CompanyPage({Key? key}) : super(key: key);

  @override
  State<CompanyPage> createState() => _CompanyPageState();
}

class _CompanyPageState extends State<CompanyPage>
    with TickerProviderStateMixin {
  late TabController tabController;
  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorBlack,
      body: SafeArea(
        child: NestedScrollView(
          headerSliverBuilder:
              (context, innerBoxIsScrolled) => [
                SliverToBoxAdapter(
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      const MyImage(
                        image: "assets/images/bar_header.png",
                        height: 150,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                      const Positioned(
                        bottom: -50,
                        left: 8,
                        right: 8,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          child: CompanyItemCard(displayLocation: false),
                        ),
                      ),
                      Positioned(
                        top: 16,
                        child: IconButton(
                          icon: const Icon(
                            Icons.arrow_back_ios_rounded,
                            color: Colors.white,
                          ),
                          onPressed: () => Get.back(),
                        ),
                      ),
                    ],
                  ),
                ),
                const SliverToBoxAdapter(child: SizedBox(height: 50)),
                SliverLayoutBuilder(
                  builder: (context, constraints) {
                    final bool atTop = constraints.scrollOffset <= 0;
                    return SliverAppBar(
                      surfaceTintColor: Colors.black,
                      pinned: true,
                      backgroundColor: colorBlack,
                      expandedHeight: 56.0,
                      leading:
                          !atTop
                              ? IconButton(
                                icon: const Icon(
                                  Icons.arrow_back_ios_rounded,
                                  color: Colors.white,
                                ),
                                onPressed: () => Navigator.of(context).pop(),
                              )
                              : const SizedBox.shrink(),
                    );
                  },
                ),
                const SliverToBoxAdapter(
                  child: CompanyTimeAndLocationSection(),
                ),
                const SliverToBoxAdapter(child: SizedBox(height: 8)),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 16,
                      ),
                      decoration: ShapeDecoration(
                        color: const Color(0xFF242424),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const SizedBox(
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: 8,
                          children: [
                            SizedBox(
                              child: Text(
                                'عن الشركة',
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                  color: Color(0xFFCCCAC7),
                                  fontSize: 14,
                                  fontFamily: 'Zain',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            SizedBox(
                              child: Text(
                                'وريم ايبسوم هو نموذج افتراضي يوضع في التصاميم لتعرض على العميل ليتصور طريقه وضع النصوص بالتصاميم سواء كانت تصاميم مطبوعه.',
                                style: TextStyle(
                                  color: Color(0xFFF7F8F9),
                                  fontSize: 16,
                                  fontFamily: 'Zain',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SliverToBoxAdapter(child: SizedBox(height: 8)),
                SliverPersistentHeader(
                  delegate: SliverAppBarDelegate(_buildTabBar()),
                  pinned: true,
                ),
              ],
          body: TabBarView(
            controller: tabController,
            children: [
              GridView.builder(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 16,
                ),
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 6,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  childAspectRatio: (167 / 253),
                ),
                itemBuilder: (BuildContext context, int index) {
                  return ProductItemCard(
                    onTap: () {
                      Get.toNamed(Routes.PRODUCT_DETAILSKEY);
                    },
                  );
                },
              ),
              GridView.builder(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 16,
                ),
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 6,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  childAspectRatio: 1.2,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return const MyImage(
                    image: "assets/images/bar_header.png",
                    fit: BoxFit.cover,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      color: colorBlack,
      child: TabBar(
        controller: tabController,
        isScrollable: false,
        padding: const EdgeInsets.symmetric(horizontal: 5.0),
        dividerHeight: .5,
        dividerColor: colorGrey,
        indicatorWeight: 0,
        indicator: const UnderlineTabIndicator(
          borderSide: BorderSide(color: colorPrimary, width: 1),
        ),
        labelColor: colorPrimary,
        labelPadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
        unselectedLabelColor: colorWhite,
        labelStyle: const TextStyle(
          fontSize: 20,
          fontFamily: 'Zain',
          fontWeight: FontWeight.w700,
        ),
        unselectedLabelStyle: const TextStyle(
          fontSize: 20,
          fontFamily: 'Zain',
          fontWeight: FontWeight.w700,
        ),
        tabs: [Tab(text: "products".tr), Tab(text: "bussiness_gallery".tr)],
      ),
    );
  }
}
