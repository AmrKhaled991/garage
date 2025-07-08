import 'package:garage/core/networking/loading_state.dart';
import '../networking/base/api_response.dart';
import '../networking/base/dynamic_model.dart';
import 'base_repository.dart';

class ContactUsRepository extends BaseRepository {
  /*************  ✨ Windsurf Command ⭐  *************/
  /// Send a contact us request with given data
  ///
  /// [data] must contain the following fields:
  /// - [name]
  /// - [email]
  /// - [phone]
  /// - [message]
  ///
  /// Returns a [LoadingState] that is either [LoadingState.success]
  /// (if the request was successful) or [LoadingState.error] (if the
  /// request failed).
  /*******  df376e72-89de-4e6f-b158-78ea45a5306e  *******/
  Future<LoadingState> contactUs(Map<String, String> data) async {
    return networkHandler.postRequest(
      endpoint: "contact-us",
      create: () => APIDynamicResponse(create: () => DynamicModel()),
      body: data,
    );
  }
}
