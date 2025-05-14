// import 'package:q8sale/common/models/paging_state.dart';
// import 'package:flutter/material.dart';
// import 'package:q8sale/common/models/loading_state_paging.dart';
// import 'package:q8sale/common/my_theme.dart';
// import 'package:q8sale/generated/l10n.dart';
// import 'package:q8sale/ui/common/retry_widget.dart';
// import 'package:pull_to_refresh/pull_to_refresh.dart';
//
// class LoadingPagingWidget extends StatefulWidget {
//   final LoadingStatePaging? loadingState;
//   final Axis scrollDirection;
//   final Widget? loadingWidget;
//   final Widget? listWidget;
//   final bool isEmpty;
//   final VoidCallback? retry;
//   final Function? onRefresh;
//   final Function? onLoadingMore;
//
//   LoadingPagingWidget({this.loadingState,this.scrollDirection = Axis.vertical,this.listWidget,this.loadingWidget,this.isEmpty=false,this.retry,this.onRefresh,this.onLoadingMore});
//
//   @override
//   _LoadingPagingWidgetState createState() => _LoadingPagingWidgetState();
// }
//
// class _LoadingPagingWidgetState extends State<LoadingPagingWidget> {
//   RefreshController _refreshController = RefreshController(initialRefresh: false);
//
//   @override
//   Widget build(BuildContext context) {
//
//     Widget _child() {
//       if (widget.loadingState!.initLoading)
//         if(widget.loadingWidget ==null)
//           return Center(child: CircularProgressIndicator());
//         else
//           return widget.loadingWidget!;
//       else if (widget.loadingState!.retryInit) {
//         return Center(child: RetryWidget(() {
//           widget.retry!.call();
//         }, msg: widget.loadingState!.message));
//       } else if (widget.isEmpty) {
//         return Center(
//           child: Text(S
//               .of(context)
//               .no_data_found, style: MyTextStyle.graySubTitle,),
//         );
//       } else {
//         return widget.listWidget!;
//         //   ListView(
//         //   physics: ClampingScrollPhysics(),
//         //   children: [
//         //     Expanded(child: widget.listWidget),
//         //     Visibility(visible: widget.loadingState.pageLoading, child: Padding(
//         //       padding: const EdgeInsets.all(20),
//         //       child: CircularProgressIndicator(),
//         //     )),
//         //     Visibility(visible: widget.loadingState.retryPage, child: Padding(
//         //       padding: const EdgeInsets.all(20),
//         //       child: RetryWidget(() {
//         //         widget.retry.call();
//         //       }),
//         //     )),
//         //   ],
//         // );
//       }
//     }
//
//     return SmartRefresher(
//       controller: _refreshController,
//       physics: BouncingScrollPhysics(),
//       header: WaterDropHeader(),
//       enablePullUp: true,
//       scrollDirection: widget.scrollDirection,
//       onRefresh: () async {
//         if(widget.onRefresh == null){
//           _refreshController.refreshCompleted();
//           return;
//         }
//         var state = await widget.onRefresh!.call();
//         if(state == PagingState.INIT_FAILED)
//           _refreshController.refreshFailed();
//         else
//           _refreshController.refreshCompleted();
//       },
//       onLoading: () async{
//         if(widget.onLoadingMore == null){
//           _refreshController.loadComplete();
//           return;
//         }
//         var state = await widget.onLoadingMore!.call();
//         if(state == PagingState.MORE_FAILED)
//           _refreshController.loadFailed();
//         else if(state == PagingState.NO_MORE)
//           _refreshController.loadNoData();
//         else
//           _refreshController.loadComplete();
//       },
//       child: _child(),
//     );
//
//   }
// }
