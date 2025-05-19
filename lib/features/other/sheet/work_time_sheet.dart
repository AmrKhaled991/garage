import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:garage/theme/styles.dart';

class WorkTimeSheet extends StatelessWidget {
  const WorkTimeSheet({super.key});

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
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'السبت',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontFamily: 'Zain',
                        fontWeight: FontWeight.w400,
                        height: 1.20,
                      ),
                    ),
                    Text(
                      '10:00 ص - 1000 م',
                      style: TextStyle(
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
          itemCount: 8,
        ),
      ),
    );
  }
}
