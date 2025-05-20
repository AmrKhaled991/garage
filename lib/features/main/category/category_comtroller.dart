import 'package:get/get.dart';

import 'category_state.dart';

class CategoryController extends GetxController {
  final CategoryState state = CategoryState();

  selectCategory(int index) {
    state.selectedIndex.value = index;
    update();
  }
}
