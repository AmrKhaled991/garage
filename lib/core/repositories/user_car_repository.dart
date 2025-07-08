import 'package:garage/core/networking/base/api_response.dart';
import 'package:garage/core/networking/base/dynamic_model.dart';
import 'package:garage/core/networking/loading_state.dart';
import 'package:garage/core/networking/models/brand/brand.dart';
import 'package:garage/core/networking/models/reminder/reminder.dart';
import 'package:garage/core/networking/models/user_car/user_car.dart';
import 'package:garage/core/networking/models/user_notification/notifications.dart';
import 'package:garage/core/repositories/base_repository.dart';

class UserCarRepository extends BaseRepository {
  Future<LoadingState<dynamic>> postUserCar(Map<String, dynamic> body) async {
    return networkHandler.postRequest(
      endpoint: "car/create",
      body: body,
      create: () => APIDynamicResponse(create: () => DynamicModel()),
    );
  }

  Future<LoadingState<List<Brand>>> getBrands() async {
    return networkHandler.getRequest(
      endpoint: "brands",
      create: () => APIListResponse<Brand>(create: () => Brand()),
    );
  }

  Future<LoadingState<List<UserCar>>> getUserCars() async {
    return networkHandler.getRequest(
      endpoint: "cars",
      create: () => APIListResponse<UserCar>(create: () => UserCar()),
    );
  }

  Future<LoadingState<List<Reminder>>> getUserReminders({page = 1}) async {
    return networkHandler.getRequest(
      endpoint: "my-reminders?page=$page",
      create: () => APIListResponse<Reminder>(create: () => Reminder()),
    );
  }

  Future<LoadingState> storeReminder({
    required Map<String, dynamic> body,
  }) async {
    return networkHandler.postRequest(
      endpoint: "store-reminder",
      body: body,
      create:
          () => APIDynamicResponse<DynamicModel>(create: () => DynamicModel()),
    );
  }
}
