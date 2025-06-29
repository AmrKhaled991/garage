import 'package:flutter/material.dart';
import 'package:garage/core/networking/models/category.dart';
import 'package:garage/core/networking/models/provider_response/provider_response.dart';
import 'package:garage/core/repositories/categories_repository.dart';
import 'package:garage/core/ui/LoadingWidget.dart';
import 'package:garage/core/ui/my_error_widget.dart';
import 'package:garage/core/ui/my_image.dart';
import 'package:garage/core/ui/my_loading_widget.dart';
import 'package:garage/core/ui/sliver_app_bar_delegate.dart';
import 'package:garage/features/main/category/category_controller.dart';
import 'package:garage/features/main/category/category_page_details/company_item_card.dart';
import 'package:garage/features/main/category/category_page_details/sub_category_item.dart';
import 'package:garage/features/main/category/category_state.dart';
import 'package:garage/routes/app_pages.dart';
import 'package:garage/theme/styles.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CategoryPage extends StatelessWidget {
  CategoryPage({Key? key}) : super(key: key);
  List<Category>? categories = Get.arguments;
  CategoryController controller = Get.find<CategoryController>();
 

  @override
  Widget build(BuildContext context) {
    final state = Get.find<CategoryController>().state;
    return Scaffold(
      backgroundColor: colorBlack,
      body: SafeArea(
        child: Obx(() {
          var categorySelectedId = state.selectedCategoryId.value;
          return CustomScrollView(
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
                title: Text(
                  "categories".tr,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
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
                    child: Obx(() {
                      final selectedIndex =
                          state.selectedIndex.value; // 👈 use directly

                      return ListView(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        children: [
                          SubCategoryItem(
                            categoryData: Category(id: 0, name: "all".tr),
                            isSelected: state.selectedIndex.value == null,
                            onClick: () {
                              if (state.selectedIndex.value == null) return;
                              controller.categoryChange(null, null);
                            },
                          ),
                          const SizedBox(width: 8),
                          ListView.separated(
                            separatorBuilder:
                                (context, index) => const SizedBox(width: 8),
                            itemBuilder: (context, index) {
                              var item = categories?.elementAt(index);
                              return SubCategoryItem(
                                isSelected: selectedIndex == index,

                                categoryData: categories?[index],
                                onClick: () {
                                  if (state.selectedIndex.value == index)
                                    return;
                                  controller.categoryChange(
                                    index,
                                    item?.id?.toInt(),
                                  );
                                },
                              );
                            },
                            itemCount: categories?.length ?? 0,
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                          ),
                        ],
                      );
                    }),
                  ),
                ),
              ),
              SliverToBoxAdapter(child: ProviderItems(categorystate: state)),
            ],
          );
        }),
      ),
    );
  }
}

class ProviderItems extends StatefulWidget {
  final CategoryState? categorystate;
  final String? selectedArea;
  const ProviderItems({
    super.key,
    required this.categorystate,
    this.selectedArea,
  });

  @override
  State<ProviderItems> createState() => _ProviderItemsState();
}

class _ProviderItemsState extends State<ProviderItems> {
  final CategoriesRepository categoryRepository =
      Get.find<CategoriesRepository>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return LoadingWidget(
        loadingState: widget.categorystate?.providersList.value,
        child: PagedListView<int, ProviderResponse>(
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          pagingController: widget.categorystate!.pagingController,
          padding: const EdgeInsets.all(8),
          builderDelegate: PagedChildBuilderDelegate<ProviderResponse>(
            itemBuilder:
                (context, item, index) =>
                    item.data == null
                        ? const SizedBox.shrink()
                        : CompanyItemCard(
                          address: item.data?.mapDesc,
                          title: item.name,
                          subTitle: item.data?.description,
                          id: item.id,
                          image: item.image,
                        ),
            firstPageProgressIndicatorBuilder: (_) => const MyLoadingWidget(),
            newPageProgressIndicatorBuilder: (_) => const MyLoadingWidget(),
            noItemsFoundIndicatorBuilder:
                (_) => MyErrorWidget(
                  onRetryCall: () {
                    widget.categorystate!.pagingController.refresh();
                  },
                  errorMsg: "no_data_found".tr,
                  errorType: ErrorType.EMPTY,
                ),
            firstPageErrorIndicatorBuilder:
                (_) => MyErrorWidget(
                  onRetryCall: () {
                    widget.categorystate!.pagingController.refresh();
                  },
                  errorMsg: widget.categorystate!.pagingController.error
                      .toString()
                      .substring(
                        widget.categorystate!.pagingController.error
                                .toString()
                                .lastIndexOf("(") +
                            2,
                        widget.categorystate!.pagingController.error
                                .toString()
                                .length -
                            2,
                      ),
                  withLogin: true,
                ),
          ),
        ),
      );
    });
  }
}
