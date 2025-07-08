import 'package:garage/core/repositories/main_repository.dart';
import 'package:get/get.dart';

import 'notificatoins_state.dart';

class NotificatoinsLogic extends GetxController {
  final NotificatoinsState state = NotificatoinsState();
  final MainRepository ordersRepository = Get.find<MainRepository>();
  @override
  void onInit() {
    super.onInit();
    state.pagingController.addPageRequestListener((pageKey) {
      getUserReminders(pageKey);
    });
  }

  Future<void> getUserReminders(int pageKey) async {
    try {
      final response = await ordersRepository.getUserNotification(
        page: pageKey,
      );

      final isLastPage =
          response.pagination?.currentPage == response.pagination?.totalPages;
      if (isLastPage) {
        state.pagingController.appendLastPage(
          response.data?.notifications?.data ?? [],
        );
      } else {
        final nextPageKey = pageKey + 1;
        state.pagingController.appendPage(
          response.data?.notifications?.data ?? [],
          nextPageKey,
        );
      }
    } catch (error) {
      state.pagingController.error = error;
    }
  }
}
