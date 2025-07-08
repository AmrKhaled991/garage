import 'package:flutter/cupertino.dart';
import 'package:garage/core/ui/my_loading_widget.dart';
import 'package:garage/features/main/search/search_controller.dart';
import 'package:garage/features/main/search/search_page.dart';
import 'package:garage/features/main/search/search_state.dart';
import 'package:garage/core/networking/models/provider_response/provider_response.dart';
import 'package:garage/core/repositories/categories_repository.dart';
import 'package:garage/core/ui/LoadingWidget.dart';
import 'package:garage/core/ui/my_error_widget.dart';
import 'package:garage/features/main/search/widgets/search_company_item.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class ProviderSearchedItems extends StatefulWidget {
  final SearchState? searchState;
  final String? selectedArea;
  const ProviderSearchedItems({
    super.key,
    required this.searchState,
    this.selectedArea,
  });

  @override
  State<ProviderSearchedItems> createState() => _ProviderSearchedItemsState();
}

class _ProviderSearchedItemsState extends State<ProviderSearchedItems> {
  final CategoriesRepository categoryRepository =
      Get.find<CategoriesRepository>();
  final SearchController searchController = Get.find<SearchController>();
  @override
  Widget build(BuildContext context) {
    return PagedListView<int, ProviderResponse>(
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      pagingController: widget.searchState!.pagingController,
      padding: const EdgeInsets.all(8),
      builderDelegate: PagedChildBuilderDelegate<ProviderResponse>(
        itemBuilder:
            (context, item, index) =>
                item.data == null
                    ? const SizedBox.shrink()
                    : SearchCompanyItem(
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
                widget.searchState!.pagingController.refresh();
              },
              errorMsg: "no_data_found".tr,
              errorType: ErrorType.EMPTY,
            ),
        firstPageErrorIndicatorBuilder:
            (_) => MyErrorWidget(
              onRetryCall: () {
                widget.searchState!.pagingController.refresh();
              },
              errorMsg: widget.searchState!.pagingController.error
                  .toString()
                  .substring(
                    widget.searchState!.pagingController.error
                            .toString()
                            .lastIndexOf("(") +
                        2,
                    widget.searchState!.pagingController.error
                            .toString()
                            .length -
                        2,
                  ),
              withLogin: true,
            ),
      ),
    );
  }
}
