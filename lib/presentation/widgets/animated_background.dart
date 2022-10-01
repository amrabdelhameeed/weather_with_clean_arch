import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class AnimatedBackground extends StatelessWidget {
  const AnimatedBackground({Key? key, required this.maxScroll, required this.scrollPosition, required this.duration, required this.isDay}) : super(key: key);
  final double maxScroll;
  final Duration duration;
  final double scrollPosition;
  final bool isDay;

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: duration,
      opacity: scrollPosition < maxScroll ? 0.65 : 0,
      child: AnimatedContainer(
        duration: duration,
        decoration: const BoxDecoration(
          color: Colors.transparent,
        ),
        child: Lottie.asset('assets/images/lottie/background${isDay ? '' : '2'}.json', fit: BoxFit.fill),
        // child: Image.asset('assets/images/gif/1.gif', fit: BoxFit.cover),
      ),
    );
  }
}
