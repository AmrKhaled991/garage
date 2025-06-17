import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:garage/core/helpers/time_formater.dart';
import 'package:garage/core/networking/models/provider_details_response/time.dart';
import 'package:garage/theme/styles.dart';

class WorkTimeSheet extends StatelessWidget {
  final List<Time>? times;
  const WorkTimeSheet({super.key, this.times});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: colorBlack,
      child: Expanded(
        child: ListView.separated(
          padding: const EdgeInsets.all(8),
          itemBuilder:
              (context, index) => Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 10,
                ),
                clipBehavior: Clip.antiAlias,
                decoration: MyshapesStyle.PrimaryDecoration,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      times![index].day ?? '',
                      textAlign: TextAlign.right,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontFamily: 'Zain',
                        fontWeight: FontWeight.w400,
                        height: 1.20,
                      ),
                    ),
                    Text(
                      formateTime(times![index]),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontFamily: 'Zain',
                        fontWeight: FontWeight.w400,
                        height: 1.20,
                      ),
                    ),
                  ],
                ),
              ),
          separatorBuilder: (context, index) => const SizedBox(height: 8),
          itemCount: times?.length ?? 0,
        ),
      ),
    );
  }

  String formateTime(Time time) {
    var start = DateTimeFormatter.formatTo12Hour(time.start!);
    var end = DateTimeFormatter.formatTo12Hour(time.end!);

    return "$start $end";
  }
}
