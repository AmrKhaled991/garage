
import 'package:garage/core/networking/loading_state.dart';
import 'package:garage/core/networking/models/offer.dart';
import 'package:garage/core/networking/models/product.dart';
import '../networking/base/api_response.dart';
import 'base_repository.dart';

class ProductRepository extends BaseRepository{


  // Future<LoadingState<List<Product>?>> getProducts({FilterData? filterData = null, int page = 1}) async{
  //   var query = {
  //     "page": page.toString(),
  //     if(filterData?.categoryId!=null) "category_id":filterData?.categoryId.toString(),
  //     if(filterData?.vendorId!=null) "vendor_id":filterData?.vendorId.toString(),
  //     if(filterData?.searchKey!=null) "search":filterData?.searchKey,
  //     if(filterData?.lowPrice!=null) "low_price":filterData?.lowPrice,
  //     if(filterData?.highPrice!=null) "high_price":filterData?.highPrice,
  //     if(filterData?.offers!=null) "get_offers":filterData?.offers,
  //     // if(filterData?.isNew == true) "is_new":"yes",
  //     if(filterData?.sorting!=null&&filterData?.sorting?.isNotEmpty == true) "sorting":filterData?.sorting,
  //   };

  //   return networkHandler.getRequest(endpoint:
  //       "catalog/products",
  //       create: ()=> APIListResponse<Product>(create: ()=> Product()),
  //       query: query
  //   );
  // }


  Future<LoadingState<Product?>> getProductDetails(String id) async{
    return networkHandler.getRequest(
      endpoint: "catalog/product/$id/details?with_related_products=yes",
      create: ()=> APIResponse<Product>(create: ()=> Product()),
    );
  }

  Future<LoadingState<List<Offer>?>> getOffer({int page = 1}) async{
    return networkHandler.getRequest(
      endpoint: "offers",
      query: {
        "page": page.toString(),
      },
      create: ()=> APIListResponse<Offer>(create: ()=> Offer()),
    );
  }

}