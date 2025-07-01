import 'package:garage/core/networking/loading_state.dart';
import 'package:garage/core/repositories/user_car_repository.dart';
import 'package:garage/utils/utlis.dart';
import 'package:get/get.dart';

import 'maintenance_appointment_reminder_state.dart';

class MaintenanceAppointmentReminderController extends GetxController {
  final MaintenanceAppointmentReminderState state =
      MaintenanceAppointmentReminderState();
  final UserCarRepository ordersRepository = Get.find<UserCarRepository>();
  @override
  void onInit() {
    super.onInit();
    state.pagingController.addPageRequestListener((pageKey) {
      getUserReminders(pageKey);
    });
  }

  Future<void> getUserReminders(int pageKey) async {
    try {
      final response = await ordersRepository.getUserReminders(page: pageKey);

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

  storeReminder(Function(bool) success) async {
    var body = {
      "title": state.title.value.text,
      "description": state.description.value.text,
      "kilometer": state.kilometer.value.text,
      "date": state.date.value,
      "time": state.hour.value,
    };
    state.reminderRequest.value = LoadingState.loading();
    final response = await ordersRepository.storeReminder(body: body);
    state.reminderRequest.value = response;
    if (state.reminderRequest.value.success == true) {
      success(true);
    } else {
      Utils.showSnackBar(state.reminderRequest.value.message);
    }
  }

  bool validations() {
    if (state.title.value.text.isBlank == true) {
      Utils.showSnackBar("title_error".tr);
      return false;
    } else if (state.description.value.text.isBlank == true) {
      Utils.showSnackBar("note_error".tr);
      return false;
    } else if (state.kilometer.value.text.isBlank == true) {
      Utils.showSnackBar("kilometer_error".tr);
      return false;
    } else if (state.date.value.isBlank == true) {
      Utils.showSnackBar("date_error".tr);
      return false;
    } else if (state.hour.value.isBlank == true) {
      Utils.showSnackBar("hour_error".tr);
      return false;
    } else {
      return true;
    }
  }
    void resetForm() {
    state.title.clear();
    state.description.clear();
    state.kilometer.clear();
    state.date.value = "";
    state.hour.value = "";
    // Optional: Reset loading or request status if needed
    // state.reminderRequest.value = LoadingState(); 
  }

}
