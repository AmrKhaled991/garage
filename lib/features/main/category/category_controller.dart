import 'package:garage/core/networking/loading_state.dart';
import 'package:garage/core/repositories/categories_repository.dart';
import 'package:get/get.dart';

import 'category_state.dart';

class CategoryController extends GetxController {
  final CategoryState state = CategoryState();
  CategoriesRepository categoriesRepository = Get.find<CategoriesRepository>();
  @override
  void onInit() {
    fetchProviders(
      categoryId: state.selectedCategoryId.value,
      forceRefresh: true,
    );
  }

  selectCategory(int? index, int? vendorId) {
    state.selectedIndex.value = index;
    state.selectedCategoryId.value = vendorId;
    print("id111111: ${state.selectedCategoryId.value}");
    fetchProviders(
      categoryId: state.selectedCategoryId.value,
      forceRefresh: true,
    );
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
}
