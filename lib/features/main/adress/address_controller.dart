import 'package:garage/core/networking/loading_state.dart';
import 'package:garage/core/repositories/main_repository.dart';
import 'package:garage/utils/utlis.dart';
import 'package:get/get.dart';

import 'address_state.dart';

class UserAddressController extends GetxController {
  final AddressState state = AddressState();

  final MainRepository repository = Get.find<MainRepository>();
  @override
  void onInit() {
    super.onInit();
    state.pagingController.addPageRequestListener((pageKey) {
      getUserAddress(pageKey);
    });
    print("element: 111element");
  }

  Future<void> getUserAddress(int pageKey) async {
    try {
      final response = await repository.getUserAddress(page: pageKey);
      print("element: ${response.data?.length}");

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

  changeActivation(int id, Function(bool) callback) async {
    state.isLoadingChangeStatus.value = LoadingState.loading();
    state.isLoadingChangeStatus.value = await repository.toggleAddress(id: id);
    if (state.isLoadingChangeStatus.value.success) {
      callback.call(state.isLoadingChangeStatus.value.success);
    } else {
      Utils.showSnackBar(state.isLoadingChangeStatus.value.message);
      callback.call(state.isLoadingChangeStatus.value.success);
    }
  }

  deleteAddress(int id, Function(bool) callback) async {
    state.isLoadingDelete.value = LoadingState.loading();
    state.isLoadingDelete.value = await repository.deleteAddress(id: id);
    if (state.isLoadingDelete.value.success) {
      callback.call(state.isLoadingDelete.value.success);
    } else {
      Utils.showSnackBar(state.isLoadingDelete.value.message);
      callback.call(state.isLoadingDelete.value.success);
    }
  }
}
