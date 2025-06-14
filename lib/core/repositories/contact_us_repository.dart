import 'package:garage/core/networking/loading_state.dart';
import '../networking/base/api_response.dart';
import '../networking/base/dynamic_model.dart';
import 'base_repository.dart';

class ContactUsRepository extends BaseRepository {
  Future<LoadingState> contactUs(Map<String, String> data) async {
    return networkHandler.postRequest(
      endpoint: "contact-us",
      create: () => APIDynamicResponse(create: () => DynamicModel()),
      body: data,
    );
  }
}
