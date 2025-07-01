import 'package:garage/core/networking/base/api_response.dart';
import 'package:garage/core/networking/base/dynamic_model.dart';
import 'package:garage/core/networking/loading_state.dart';
import 'package:garage/core/networking/models/IntroSlider.dart';
import 'package:garage/core/networking/models/adress/user_address.dart';
import 'package:garage/core/networking/models/category.dart';
import 'package:garage/core/networking/models/city.dart';
import 'package:garage/core/networking/models/page.dart';
import 'package:garage/core/networking/models/socials/socials.dart';
import 'package:garage/core/networking/models/supportedCountry.dart';
import '../networking/models/settings.dart';
import 'base_repository.dart';
import 'package:get/get_connect/http/src/multipart/form_data.dart';

class MainRepository extends BaseRepository {
  Future<LoadingState<Settings?>> getSettings() async {
    return networkHandler.getRequest(
      endpoint: "setting",
      create: () => APIResponse<Settings>(create: () => Settings()),
    );
  }

  Future<LoadingState<List<GarageSocials>?>> getSocials() async {
    return networkHandler.getRequest(
      endpoint: "socials",
      create:
          () => APIListResponse<GarageSocials>(create: () => GarageSocials()),
    );
  }

  Future<LoadingState<List<PagesData>?>> getPages() async {
    return networkHandler.getRequest(
      endpoint: "pages",
      create: () => APIListResponse<PagesData>(create: () => PagesData()),
    );
  }

  Future<LoadingState<List<City>?>> getAreas() async {
    return networkHandler.getRequest(
      endpoint: "areas/cities/1",
      create: () => APIListResponse<City>(create: () => City()),
      query: {"with_states": "yes"},
    );
  }

  Future<LoadingState<List<SupportedCountry>?>> getSupportedCountries() async {
    return networkHandler.getRequest(
      endpoint: "countries",
      create:
          () => APIListResponse<SupportedCountry>(
            create: () => SupportedCountry(),
          ),
    );
  }

  Future<LoadingState<List<IntroSlider>?>> getIntroSliders() async {
    return networkHandler.getRequest(
      endpoint: "intros",
      create: () => APIListResponse<IntroSlider>(create: () => IntroSlider()),
    );
  }

  Future<LoadingState> getTerms() async {
    return networkHandler.getRequest(
      endpoint: "terms",
      create: () => APIDynamicResponse(create: () => DynamicModel()),
    );
  }

  Future<LoadingState> getAbout() async {
    return networkHandler.getRequest(
      endpoint: "about",
      create: () => APIDynamicResponse(create: () => DynamicModel()),
    );
  }

  Future<LoadingState<List<Category>?>> getCategories({String? typeId}) async {
    return networkHandler.getRequest(
      // endpoint: "categories/:$typeId",
      endpoint: "categories/",
      create: () => APIListResponse<Category>(create: () => Category()),
    );
  }

  Future<LoadingState<dynamic>> storeAddress({
    Map<String, dynamic>? body,
  }) async {
    print("body11: $body");
    return networkHandler.postRequest(
      endpoint: "store-address",
      body: body,
      create:
          () => APIDynamicResponse<DynamicModel>(create: () => DynamicModel()),
    );
  }

  Future<LoadingState<List<UserAddress>>> getUserAddress({int page = 1}) async {
    return networkHandler.getRequest(
      endpoint: "my-addresses?page=$page",
      create: () => APIListResponse<UserAddress>(create: () => UserAddress()),
    );
  }

  Future<LoadingState<dynamic>> updateAddress({
    Map<String, dynamic>? body,
    int? id,
  }) async {
    return networkHandler.postRequest(
      endpoint: "update-address/$id",
      body: body,
      create:
          () => APIDynamicResponse<DynamicModel>(create: () => DynamicModel()),
    );
  }

  Future<LoadingState<dynamic>> toggleAddress({int? id}) async {
    return networkHandler.postRequest(
      endpoint: "toggle-active/$id",
      create:
          () => APIDynamicResponse<DynamicModel>(create: () => DynamicModel()),
    );
  }

  Future<LoadingState<dynamic>> deleteAddress({int? id}) async {
    return networkHandler.deleteRequest(
      endpoint: "delete-address/$id",
      create:
          () => APIDynamicResponse<DynamicModel>(create: () => DynamicModel()),
    );
  }

  Future<LoadingState<dynamic>> storePrice({
    required Map<String, dynamic> body,
  }) async {
    return networkHandler.postRequest(
      endpoint: "store-price-request",
      body: FormData(body),

      create:
          () => APIDynamicResponse<DynamicModel>(create: () => DynamicModel()),
    );
  }

  // UserAddress
}
