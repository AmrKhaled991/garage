import 'package:garage/core/networking/base/api_response.dart';
import 'package:garage/core/networking/base/dynamic_model.dart';
import 'package:garage/core/networking/loading_state.dart';
import 'package:garage/core/networking/models/IntroSlider.dart';
import 'package:garage/core/networking/models/category.dart';
import 'package:garage/core/networking/models/city.dart';
import 'package:garage/core/networking/models/page.dart';
import 'package:garage/core/networking/models/supportedCountry.dart';
import '../networking/models/settings.dart';
import 'base_repository.dart';

class MainRepository extends BaseRepository {
  Future<LoadingState<Settings?>> getSettings() async {
    return networkHandler.getRequest(
      endpoint: "setting",
      create: () => APIResponse<Settings>(create: () => Settings()),
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
}
