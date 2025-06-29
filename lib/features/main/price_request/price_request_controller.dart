import 'package:garage/core/repositories/orders_repository.dart';
import 'package:get/get.dart';

import 'price_request_state.dart';

class PriceRequestController extends GetxController {
  final PriceRequestState state = PriceRequestState();
  OrdersRepository ordersRepository = Get.find<OrdersRepository>();
  @override
  void onInit() {
    super.onInit();
    state.pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final response = await ordersRepository.getMyPriceRequests(page: pageKey);

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
