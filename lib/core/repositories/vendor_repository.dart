
import 'package:garage/core/networking/base/api_response.dart';
import 'package:garage/core/networking/loading_state.dart';
import 'package:garage/core/networking/models/clinic.dart';
import 'package:garage/core/networking/models/doctor.dart';
import 'package:garage/core/networking/models/restaurant.dart';
import 'package:garage/core/networking/models/vendor.dart';
import 'package:garage/core/networking/models/vendor_working_times.dart';
import 'base_repository.dart';

class VendorRepository extends BaseRepository{


  Future<LoadingState<List<Clinic>?>> getClinics({String? stateId, String? categoryId, String? search, int? page = 1}) async{
    var query = {
      if(stateId!=null) "cities": stateId.toString(),
      if(search!=null) "search": search.toString(),
      if(categoryId!=null) "category_id": categoryId.toString(),
      "page": page.toString()
    };
    return networkHandler.getRequest(
        endpoint: "places",
        create: ()=> APIListResponse<Clinic>(create: ()=> Clinic()),
        query: query
    );
  }

  Future<LoadingState<Clinic?>> getClinicDetails(String id) async{
    return networkHandler.getRequest(
      endpoint: "view/place/$id",
      create: ()=> APIResponse<Clinic>(create: ()=> Clinic()),
    );
  }

  Future<LoadingState<List<Doctor>?>> getDoctors({String? clinicId, String? categoryId}) async{
    return networkHandler.getRequest(
      endpoint: "view-doctors",
      query: {
        if(clinicId != null)
        "place_id" : clinicId,
        if(categoryId != null)
        "subcategory_id" : categoryId,
      },
      create: ()=> APIListResponse<Doctor>(create: ()=> Doctor()),
    );
  }

  Future<LoadingState<Doctor?>> getDoctorDetails(String doctorId) async{
    return networkHandler.getRequest(
      endpoint: "view/doctor/$doctorId",
      create: ()=> APIResponse<Doctor>(create: ()=> Doctor()),
    );
  }

  Future<LoadingState<List<Vendor>?>> getVendors({String? stateId, String? categoryId, String? search}) async{
    var query = {
      if(stateId!=null) "state_id": stateId.toString(),
      if(search!=null) "search": search.toString(),
      if(categoryId!=null) "vendor_categories[0]": categoryId.toString(),
    };
    return networkHandler.getRequest(
        endpoint: "vendors/list",
        create: ()=> APIListResponse<Vendor>(create: ()=> Vendor()),
        query: query
    );
  }

  Future<LoadingState<Restaurant?>> getVendorDetails(String vendorId) async{
    return networkHandler.getRequest(
        endpoint: "vendors/$vendorId",
      query: {
          "with_vendor_categories":"yes"
      },
      create: ()=> APIResponse<Restaurant>(create: ()=> Restaurant()),
    );
  }

  Future<LoadingState<List<VendorWorkingTimes>?>> getVendorWorkingTime(String vendorId) async{
    return networkHandler.getRequest(
        endpoint: "view/place/$vendorId",
      create: ()=> APIListResponse<VendorWorkingTimes>(create: ()=> VendorWorkingTimes()),
    );
  }

}