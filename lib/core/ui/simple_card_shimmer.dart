import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class SimpleCardShimmer extends StatelessWidget {
  int itemCount;
  double aspectRatio;
  Axis direction;

  SimpleCardShimmer({
    this.itemCount = 5,
    this.aspectRatio = 16 / 9,
    this.direction = Axis.vertical,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[200]!,
      highlightColor: Colors.grey[100]!,
      enabled: true,
      child: SizedBox(
        height: direction == Axis.vertical ? 2000 : 150,
        child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: direction,
          itemBuilder:
              (_, __) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: AspectRatio(
                  aspectRatio: aspectRatio,
                  child: Container(
                    decoration: const ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
          itemCount: itemCount,
        ),
      ),
    );
  }
}
