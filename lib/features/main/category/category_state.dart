import 'package:garage/core/networking/loading_state.dart';
import 'package:garage/core/networking/models/provider_response/provider_response.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class CategoryState {
  final PagingController<int, ProviderResponse> pagingController =
      PagingController(firstPageKey: 1);
  RxnInt selectedCategoryId = RxnInt();
  RxnInt selectedIndex = RxnInt();
  final providersList = LoadingState<List<ProviderResponse>?>().obs;
  CategoryState() {
    ///Initialize variables
  }
}
