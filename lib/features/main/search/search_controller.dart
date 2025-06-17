import 'package:garage/core/networking/loading_state.dart';
import 'package:garage/core/repositories/categories_repository.dart';
import 'package:get/get.dart';

import 'search_state.dart';

class SearchController extends GetxController {
  CategoriesRepository categoriesRepository = Get.find<CategoriesRepository>();

  final SearchState state = SearchState();
  @override
  void onInit() {
    state.pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
  }

  void searchChange(String? search) {
    state.nameCategory.value = search ?? '';
    state.pagingController.refresh();
  }

  Future searchProviders({String? searchName, int? page}) async {
    state.providersSearchedList.value = LoadingState.loading();

    var response = await categoriesRepository.getProviders(
      search: searchName,
      page: page,
    );
    state.providersSearchedList.value = response;
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
        search: state.nameCategory.value,
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
