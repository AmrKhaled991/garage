import 'package:flutter/cupertino.dart';
import 'package:garage/core/networking/loading_state.dart';
import 'package:garage/core/networking/models/reminder/reminder.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class MaintenanceAppointmentReminderState {
  final PagingController<int, Reminder> pagingController = PagingController(
    firstPageKey: 1,
  );
  final title = TextEditingController();
  final description = TextEditingController();
  final kilometer = TextEditingController();
  RxString date = "".obs;
  RxString hour = "".obs;
  var reminderRequest = LoadingState().obs;
  MaintenanceAppointmentReminderState() {
    ///Initialize variables
  }
}
