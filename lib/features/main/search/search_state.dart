import 'package:garage/core/networking/loading_state.dart';
import 'package:garage/core/networking/models/provider_response/provider_response.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class SearchState {
  final PagingController<int, ProviderResponse> pagingController =
      PagingController(firstPageKey: 1);
  RxnString nameCategory = RxnString();
  final providersSearchedList = LoadingState<List<ProviderResponse>?>().obs;
  SearchState() {
    ///Initialize variables
  }
}
