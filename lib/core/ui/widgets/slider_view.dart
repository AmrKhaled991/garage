import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:garage/theme/styles.dart';
import 'package:get/get.dart';
import 'package:octo_image/octo_image.dart';
import 'package:garage/core/networking/loading_state.dart';
import 'package:garage/core/networking/models/slider.dart';
import 'package:garage/core/ui/LoadingWidget.dart';
import 'package:garage/utils/utlis.dart';

class SliderView extends StatefulWidget {
  final Rx<LoadingState<List<SliderData>?>>? loadingState;
  final VoidCallback? onRetryCall;

  List<String>? urls;
  List<Widget>? items;
  double aspectRatio;
  double? sliderHeight;
  double rounded;
  double margin;
  double viewportFraction;
  bool hideIfEmpty;
  bool autoPlay;
  Color? indicatorColor;
  BoxFit? boxFit;
  CarouselSliderController? controller;
  Function(int)? onPageChanged;
  Function(SliderData?)? onClick;

  SliderView({
    Key? key,
    this.loadingState,
    this.onRetryCall,
    this.aspectRatio = 16 / 9,
    this.urls,
    this.items,
    this.controller,
    this.autoPlay = true,
    this.rounded = 16,
    this.indicatorColor,
    this.onPageChanged,
    this.margin = 8,
    this.hideIfEmpty = false,
    this.sliderHeight,
    this.onClick,
    this.viewportFraction = 1,
    this.boxFit = BoxFit.cover,
  }) : super(key: key);

  @override
  State<SliderView> createState() => _SliderViewState();
}

class _SliderViewState extends State<SliderView> {
  final _controller = CarouselSliderController();
  final _current = RxInt(0);

  @override
  Widget build(BuildContext context) {
    var carouselOptions = CarouselOptions(
      viewportFraction: widget.viewportFraction,
      aspectRatio: widget.aspectRatio,
      height: widget.sliderHeight,
      autoPlay: widget.autoPlay,
      autoPlayInterval: const Duration(seconds: 4),
      autoPlayCurve: Curves.fastOutSlowIn,
      autoPlayAnimationDuration: const Duration(milliseconds: 800),
      onPageChanged: (index, reason) {
        _current.value = index;
        widget.onPageChanged?.call(index);
      },
    );

    if (widget.loadingState != null) {
      return Obx(
        () => LoadingWidget(
          loadingState: widget.loadingState?.value,
          hideIfEmpty: widget.hideIfEmpty,
          child: Visibility(
            visible: widget.loadingState?.value.data?.isNotEmpty == true,
            child: Stack(
              children: [
                CarouselSlider(
                  carouselController: widget.controller ?? _controller,
                  options: carouselOptions,
                  items:
                      (widget.loadingState?.value.data?.isEmpty == true)
                          ? [Container()]
                          : widget.loadingState?.value.data
                              ?.map(
                                (item) => GestureDetector(
                                  onTap: () {
                                    if (widget.onClick != null) {
                                      widget.onClick?.call(item);
                                    } else {
                                      Utils.customLaunch(item.link);
                                    }
                                  },
                                  child: Container(
                                    margin: EdgeInsets.all(widget.margin),
                                    child: ClipRRect(
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(16),
                                      ),
                                      child: OctoImage(
                                        image: CachedNetworkImageProvider(
                                          item.image ?? "",
                                        ),
                                        fit: widget.boxFit,
                                        width: double.infinity,
                                        height: double.infinity,
                                        progressIndicatorBuilder:
                                            Utils.myOctoProgressIndicator(),
                                      ),
                                      // FadeInImage.memoryNetwork(
                                      //   placeholder: kTransparentImage,image:item.url, fit: BoxFit.cover,width: 1000,)
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                ),
                Obx(() {
                  return Positioned(
                    bottom: 8,
                    left: 8,
                    right: 8,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:
                          widget.loadingState?.value.data?.map((entry) {
                            return Container(
                              width: 12.0,
                              height: 12.0,
                              margin: const EdgeInsets.symmetric(
                                vertical: 8.0,
                                horizontal: 4.0,
                              ),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: (widget.indicatorColor ??
                                        (Theme.of(context).brightness ==
                                                Brightness.dark
                                            ? Colors.black
                                            : Colors.white))
                                    .withOpacity(
                                      _current ==
                                              widget.loadingState?.value.data
                                                  ?.indexOf(entry)
                                          ? 0.9
                                          : 0.4,
                                    ),
                              ),
                            );
                          }).toList() ??
                          [],
                    ),
                  );
                }),
              ],
            ),
          ),
          onRetryCall: widget.onRetryCall,
          isEmpty: widget.loadingState?.value.data?.isEmpty == true,
        ),
      );
    } else {
      return Column(
        spacing: 10,
        children: [
          CarouselSlider(
            carouselController: widget.controller ?? _controller,
            options: carouselOptions,
            items:
                (widget.urls == null)
                    ? widget.items ?? [Container()]
                    : widget.urls
                        ?.map(
                          (item) => GestureDetector(
                            onTap: () {
                              if (widget.onClick != null) {
                                widget.onClick?.call(null);
                              } else {
                                Utils.customLaunch(item);
                              }
                            },
                            child: Container(
                              margin: EdgeInsets.all(widget.margin),
                              alignment: Alignment.center,
                              child: ClipRRect(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(widget.rounded),
                                ),
                                child: OctoImage(
                                  image: CachedNetworkImageProvider(item ?? ""),
                                  fit: widget.boxFit,
                                  width: double.infinity,
                                  height: double.infinity,
                                  progressIndicatorBuilder:
                                      Utils.myOctoProgressIndicator(),
                                ),
                                // FadeInImage.memoryNetwork(
                                //   placeholder: kTransparentImage,image:item.url, fit: BoxFit.cover,width: 1000,)
                              ),
                            ),
                          ),
                        )
                        .toList(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children:
                (widget.urls ?? widget.items)?.map((entry) {
                  return Obx(() {
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      width:
                          _current ==
                                  (widget.urls ?? widget.items)?.indexOf(entry)
                              ? 24.0
                              : 8.0,
                      height: 8.0,
                      margin: const EdgeInsets.symmetric(
                        vertical: 8.0,
                        horizontal: 4.0,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color:
                            _current ==
                                    (widget.urls ?? widget.items)?.indexOf(
                                      entry,
                                    )
                                ? colorPrimary
                                : colorGrey,
                      ),
                    );
                  });
                }).toList() ??
                [],
          ),
        ],
      );
    }
  }
}
