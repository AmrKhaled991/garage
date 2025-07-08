import 'package:garage/core/networking/models/user_prices_request/user_prices_request.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class PriceRequestState {
  final PagingController<int, UserPricesRequest> pagingController =
      PagingController(firstPageKey: 1);
  PriceRequestState() {
    ///Initialize variables
  }
}
