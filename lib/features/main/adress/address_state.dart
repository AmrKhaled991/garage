import 'package:garage/core/networking/loading_state.dart';
import 'package:garage/core/networking/models/adress/user_address.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class AddressState {
  final PagingController<int, UserAddress> pagingController = PagingController(
    firstPageKey: 1,
  );
  var isLoadingChangeStatus = LoadingState().obs;
  var isLoadingDelete = LoadingState().obs;
  AddressState() {
    ///Initialize
  }
}
