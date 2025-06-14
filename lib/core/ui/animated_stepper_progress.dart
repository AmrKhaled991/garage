import 'package:flutter/material.dart';

class AnimatedStepperProgress extends StatefulWidget {
  final int currentStep;
  final int totalSteps;
  final int stepper;

  const AnimatedStepperProgress({
    Key? key,
    required this.currentStep,
    required this.totalSteps,
    required this.stepper,
  }) : super(key: key);

  @override
  State<AnimatedStepperProgress> createState() =>
      _AnimatedStepperProgressState();
}

class _AnimatedStepperProgressState extends State<AnimatedStepperProgress> {
  @override
  Widget build(BuildContext context) {
    double progress = widget.currentStep / widget.totalSteps;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 5),
        TweenAnimationBuilder<double>(
          tween: Tween<double>(
            begin: 0.0,
            end: widget.stepper == 4 ? 1.0 : progress,
          ),
          duration: const Duration(milliseconds: 500),
          builder: (context, value, child) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(3),
              child: LinearProgressIndicator(
                value: value,
                backgroundColor: Colors.grey[300],
                valueColor: const AlwaysStoppedAnimation<Color>(Colors.black),
                minHeight: 6,
              ),
            );
          },
        ),
        const SizedBox(height: 5),
      ],
    );
  }
}
