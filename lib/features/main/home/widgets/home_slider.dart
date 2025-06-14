// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:garage/core/ui/LoadingWidget.dart';
import 'package:garage/core/ui/my_image.dart';
import 'package:garage/features/main/home/home_logic.dart';
import 'package:garage/features/main/home/home_state.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class HomeSlider extends StatefulWidget {
  final HomeController controller;
  final HomePageState state;
  const HomeSlider({super.key, required this.controller, required this.state});

  @override
  State<HomeSlider> createState() => _HomeSliderState();
}

class _HomeSliderState extends State<HomeSlider> {
  @override
  Widget build(BuildContext context) {
    var homeSlider = widget.state.homeData.value.data?.first.records;
    return Obx(() {
      return LoadingWidget(
        loadingState: widget.state.homeData.value,
        child: CarouselSlider.builder(
          itemCount: homeSlider?.length ?? 0,
          itemBuilder: (context, index, realIndex) {
            return InkWell(
              onTap: () {},
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: MyImage(
                  image: homeSlider?[index].image!,
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
          options: CarouselOptions(
            autoPlay: true,
            autoPlayAnimationDuration: const Duration(seconds: 1),
            height: 164,
            enlargeCenterPage: true,
            viewportFraction: 0.83,
            onPageChanged: (index, reason) {},
          ),
        ),
      );
    });
  }
}
