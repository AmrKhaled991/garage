import 'package:get/get.dart';

import 'maintenance_appointment_reminder_controller.dart';

class MaintenanceAppointmentReminderBinding extends Bindings {
  
  @override
  void dependencies() {
    Get.put(MaintenanceAppointmentReminderController());
  }
}
