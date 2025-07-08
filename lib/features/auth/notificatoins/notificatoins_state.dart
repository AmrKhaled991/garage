import 'package:garage/core/networking/models/user_notification/notifications.dart';
import 'package:garage/core/networking/models/user_notification/user_notification.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class NotificatoinsState {
  final PagingController<int, UserNotification> pagingController =
      PagingController(firstPageKey: 1);
  NotificatoinsState() {
    ///Initialize variables
  }
}
