import 'package:garage/core/networking/loading_state.dart';
import 'package:garage/core/ui/my_error_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'my_loading_widget.dart';

class LoadingWidget extends StatefulWidget {
  final LoadingState? loadingState;
  final VoidCallback? onRetryCall;
  final Widget? loadingWidget;
  final Widget? child;
  final Widget? emptyWidget;
  bool isEmpty;
  bool hideIfEmpty;
  bool loadingOnly;
  bool withPullToRefresh;
  bool withLogin;
  bool withErrorWidget;
  bool withPadding;

  LoadingWidget({
    this.loadingState,
    this.loadingWidget,
    this.child,
    this.emptyWidget,
    this.onRetryCall,
    this.isEmpty = false,
    this.hideIfEmpty = false,
    this.loadingOnly = false,
    this.withPadding = false,
    this.withPullToRefresh = false,
    this.withLogin = false,
    this.withErrorWidget = true,
  });

  @override
  _LoadingWidgetState createState() => _LoadingWidgetState();
}

class _LoadingWidgetState extends State<LoadingWidget> {
  final RefreshController _refreshController = RefreshController(
    initialRefresh: false,
  );

  @override
  Widget build(BuildContext context) {
    Widget _child() {
      if (widget.loadingState?.loading == true) {
        if (widget.loadingWidget == null) {
          return Center(
            child: MyLoadingWidget(withPadding: widget.withPadding),
          );
        } else {
          return widget.loadingWidget ??
              MyLoadingWidget(withPadding: widget.withPadding);
        }
      } else if (widget.loadingState?.success == true &&
          widget.isEmpty &&
          !widget.loadingOnly &&
          widget.withErrorWidget) {
        return Visibility(
          visible: !widget.hideIfEmpty,
          child:
              widget.emptyWidget ??
              Center(
                child: MyErrorWidget(
                  onRetryCall: widget.onRetryCall,
                  withLogin: widget.withLogin,
                  errorMsg: "no_data_found".tr,
                  errorType: ErrorType.EMPTY,
                  withPadding: widget.withPadding,
                ),
              ),
        );
      } else if ((widget.loadingState?.retry == true ||
              widget.loadingState?.error == true) &&
          !widget.loadingOnly &&
          widget.withErrorWidget) {
        return Center(
          child: MyErrorWidget(
            onRetryCall: widget.onRetryCall,
            withLogin: widget.withLogin,
            errorMsg: widget.loadingState?.message,
            errorType:
                widget.loadingState?.message.isEmpty == true
                    ? ErrorType.NETWORK
                    : ErrorType.API,
            withPadding: widget.withPadding,
          ),
        );
      } else if (widget.loadingState?.success == true) {
        return widget.child ?? Container();
      } else {
        return Container();
      }
    }

    if (!widget.withPullToRefresh) {
      return _child();
    } else {
      return SmartRefresher(
        controller: _refreshController,
        physics: const BouncingScrollPhysics(),
        header: const WaterDropHeader(),
        // enablePullUp: true,
        onRefresh: () {
          widget.onRetryCall?.call();
          _refreshController.refreshCompleted();
        },
        // onLoading: () async{
        //   var state = await widget.onLoadingMore;
        //   if(state == PagingState.MORE_FAILED)
        //     _refreshController.loadFailed();
        //   else if(state == PagingState.NO_MORE)
        //     _refreshController.loadNoData();
        //   else
        //     _refreshController.loadComplete();
        // },
        child: _child(),
      );
    }
  }
}
