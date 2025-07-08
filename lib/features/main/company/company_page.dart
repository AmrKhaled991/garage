import 'package:flutter/material.dart';
import 'package:garage/core/ui/LoadingWidget.dart';
import 'package:garage/core/ui/my_image.dart';
import 'package:garage/core/ui/sliver_app_bar_delegate.dart';
import 'package:garage/features/main/category/category_page_details/company_item_card.dart';
import 'package:garage/features/main/company/company_page_details/company_time_and_location_section.dart';
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
  final CompanyController controller = Get.find<CompanyController>();
  final state = Get.find<CompanyController>().state;

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
        child: Obx(() {
          var providerDetails = state.providerDetails.value.data;
          return LoadingWidget(
            loadingState: state.providerDetails.value,
            child: NestedScrollView(
              headerSliverBuilder:
                  (context, innerBoxIsScrolled) => [
                    SliverToBoxAdapter(
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          const MyImage(
                            image:
                                "assets/images/provider_deatils_bar_header.png",
                            height: 150,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                          Positioned(
                            bottom: -50,
                            left: 8,
                            right: 8,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8.0,
                              ),
                              child: CompanyItemCard(
                                showChat: true,
                                title: providerDetails?.name,
                                subTitle: providerDetails?.data?.category?.name,
                                id: providerDetails?.id,
                                image: providerDetails?.image,
                              ),
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
                                    onPressed:
                                        () => Navigator.of(context).pop(),
                                  )
                                  : const SizedBox.shrink(),
                        );
                      },
                    ),
                    SliverToBoxAdapter(
                      child: CompanyTimeAndLocationSection(
                        lat: providerDetails?.data?.lat.toString(),
                        lng: providerDetails?.data?.lng.toString(),
                        address: providerDetails?.data?.mapDesc,
                        times: providerDetails?.times,
                      ),
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
                          child: SizedBox(
                            width: double.infinity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              spacing: 8,
                              children: [
                                SizedBox(
                                  child: Text(
                                    "about_company".tr,
                                    textAlign: TextAlign.right,
                                    style: const TextStyle(
                                      color: Color(0xFFCCCAC7),
                                      fontSize: 14,
                                      fontFamily: 'Zain',
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  child: Text(
                                    providerDetails?.data?.description ?? '',
                                    style: const TextStyle(
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
                    itemCount: providerDetails?.products?.length ?? 0,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                          childAspectRatio: (167 / 253),
                        ),
                    itemBuilder: (BuildContext context, int index) {
                      return ProductItemCard(
                        productModel: providerDetails?.products?[index],
                        onTap: () {
                          Get.toNamed(
                            Routes.PRODUCT_DETAILSKEY,
                            arguments: providerDetails?.products?[index],
                          );
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
                    itemCount: providerDetails?.data?.files?.length ?? 0,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                          childAspectRatio: 1.2,
                        ),
                    itemBuilder: (BuildContext context, int index) {
                      return MyImage(
                        image: providerDetails?.data?.files?[index].url ?? '',
                        fit: BoxFit.cover,
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        }),
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
