
import 'package:garage/core/networking/loading_state.dart';
import 'package:garage/core/networking/models/category_with_products.dart';
import '../networking/base/api_response.dart';
import '../networking/models/category.dart';
import 'base_repository.dart';

class CategoriesRepository extends BaseRepository{


  Future<LoadingState<List<Category>?>> getCategories({String? search,
    bool? isMainCategories,
    int? parentId,String? type,String? vendorId,String? withChild = "1",String? onlyMain = "1",}) async{
    return networkHandler.getRequest(
        endpoint: "categories",
        create: ()=> APIListResponse<Category>(create: ()=> Category()),
    );
  }

  Future<LoadingState<List<Category>>> getVendorCategories({int? vendorId}) async{
    return networkHandler.getRequest(
        endpoint: "vendors/categories",
        create: ()=> APIListResponse<Category>(create: ()=> Category()),
        query: {
          "response_type": "all",
          "model_flag": "tree",
            if(vendorId!=null)
          "vendor_id": vendorId.toString(),
        },
    );
  }

  Future<LoadingState<List<CategoriesWithProducts>?>> getCategoriesWithProducts({String? vendorId}) async{
    return networkHandler.getRequest(
        endpoint: "catalog/product-with-category",
        create: ()=> APIListResponse<CategoriesWithProducts>(create: ()=> CategoriesWithProducts()),
        query: {
          if(vendorId!=null)
          "vendor_id": vendorId.toString(),
        }
    );
  }
}