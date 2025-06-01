import 'package:garage/core/networking/loading_state.dart';
import 'package:garage/core/networking/models/advertise.dart';
import 'package:garage/core/networking/models/category.dart';
import 'package:garage/core/networking/models/currency.dart';
import 'package:garage/core/networking/models/slider.dart';
import 'package:garage/core/networking/models/vendor.dart';
import '../networking/base/api_response.dart';
import '../networking/models/offer.dart';
import 'base_repository.dart';

class HomeRepository extends BaseRepository {
  Future<LoadingState<List<Vendor>?>> getVendors({
    int? stateId,
    bool? isNewVendors = false,
    List<int>? filterCategories,
  }) async {
    var query = {
      if (stateId != null) "state_id": stateId.toString(),
      "with_vendor_categories": "yes",
      "show_at_home": isNewVendors == true ? "yes" : "no",
    };
    if (filterCategories != null) {
      for (var element in filterCategories) {
        query["vendor_categories[$element]"] = element.toString();
      }
    }
    return networkHandler.getRequest(
      endpoint: "vendors/list",
      create: () => APIListResponse<Vendor>(create: () => Vendor()),
      query: query,
    );
  }

  Future<LoadingState<List<SliderData>?>> getSlider({
    String? type,
    int? categoryId,
  }) async {
    return networkHandler.getRequest(
      endpoint: "home-sliders",
      create: () => APIListResponse<SliderData>(create: () => SliderData()),
      query: {
        if (type != null) "position": type,
        if (categoryId != null) " category_id": categoryId.toString(),
      },
    );
  }

  Future<LoadingState<List<Currency>?>> getCurrencies() async {
    return networkHandler.getRequest(
      endpoint: "currencies",
      create: () => APIListResponse<Currency>(create: () => Currency()),
    );
  }

  Future<List<Advertise>?> getRandomAd() async {
    var result = await networkHandler.getRequest(
      endpoint: "advertisements",
      create: () => APIListResponse(create: () => Advertise()),
    );
    if (result.success) {
      return result.data;
    } else {
      return null;
    }
  }

  Future<LoadingState<List<Category>?>> getCategories({
    String typeId = "id",
  }) async {
    return networkHandler.getRequest(
      endpoint: "categories/:id",
      create: () => APIListResponse<Category>(create: () => Category()),
    );
  }
}
