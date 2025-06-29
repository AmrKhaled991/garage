import 'package:garage/core/networking/loading_state.dart';
import 'package:garage/core/networking/models/offer.dart';
import 'package:garage/core/networking/models/product.dart';
import '../networking/base/api_response.dart';
import 'base_repository.dart';

class ProductRepository extends BaseRepository {
  Future<LoadingState<Product?>> getProductDetails(String id) async {
    return networkHandler.getRequest(
      endpoint: "catalog/product/$id/details?with_related_products=yes",
      create: () => APIResponse<Product>(create: () => Product()),
    );
  }

  Future<LoadingState<List<Offer>?>> getOffer({int page = 1}) async {
    return networkHandler.getRequest(
      endpoint: "offers",
      query: {"page": page.toString()},
      create: () => APIListResponse<Offer>(create: () => Offer()),
    );
  }
}
