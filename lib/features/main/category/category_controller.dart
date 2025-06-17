import 'package:garage/core/networking/loading_state.dart';
import 'package:garage/core/repositories/categories_repository.dart';
import 'package:get/get.dart';

import 'category_state.dart';

class CategoryController extends GetxController {
  final CategoryState state = CategoryState();
  CategoriesRepository categoriesRepository = Get.find<CategoriesRepository>();
  @override
  void onInit() {
    state.pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    fetchProviders();
  }

  void categoryChange(int? index, int? categoryId) {
    state.selectedIndex.value = index;
    state.selectedCategoryId.value = categoryId ?? 0;
    state.pagingController.refresh();
  }

  Future fetchProviders({
    bool forceRefresh = false,
    int? categoryId,
    int? page,
    String? stateId,
  }) async {
    if (state.providersList.value.data != null && !forceRefresh) {
      return;
    }
    state.providersList.value = LoadingState.loading();
    var response = await categoriesRepository.getProviders(
      stateId: stateId,
      categoryId: categoryId,
      page: page,
    );
    state.providersList.value = response;
    return response;
  }

  @override
  void dispose() {
    state.pagingController.dispose();
    super.dispose();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final response = await categoriesRepository.getProviders(
        categoryId: state.selectedCategoryId.value,
        page: pageKey,
      );

      final isLastPage =
          response.pagination?.currentPage == response.pagination?.totalPages;
      if (isLastPage) {
        state.pagingController.appendLastPage(response.data ?? []);
      } else {
        final nextPageKey = pageKey + 1;
        state.pagingController.appendPage(response.data ?? [], nextPageKey);
      }
    } catch (error) {
      state.pagingController.error = error;
    }
  }
}
