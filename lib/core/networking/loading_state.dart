
import 'package:flutter/cupertino.dart';
import 'package:garage/core/networking/base/pagination.dart';

class LoadingState<T>{

  LoadingState();
  LoadingState.loading({this.loading = true , this.success = false, this.error = false , this.retry = false , this.retryCallback, this.data});
  LoadingState.errorWithRetry({this.data,this.success = false, this.loading = false , this.error = true , this.retry = true , this.message = "Error please try again", this.retryCallback, this.key});
  LoadingState.errorNoRetry({this.data,this.success = false, this.loading = false , this.error = true , this.retry = false , this.message = "Error please try again", this.retryCallback, this.key});
  LoadingState.success(this.data,{this.success = true, this.loading = false , this.error = false , this.retry = false , this.message = "Success", this.pagination, this.key});


  bool loading = false;
  bool error = false;
  bool success = false;
  bool retry = false;
  VoidCallback? retryCallback;
  String message ="";
  String? key ="";
  T? data;
  Pagination? pagination;

}