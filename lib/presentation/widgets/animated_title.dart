import 'package:flutter/material.dart';
import '../../core/utils/app_constants.dart';
import '../../core/utils/app_methods.dart';
import '../../core/utils/app_styles.dart';

class AnimatedTitle extends StatelessWidget {
  const AnimatedTitle({
    Key? key,
    required this.text,
    required this.scrollPosition,
  }) : super(key: key);

  final double scrollPosition;
  final String text;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      height: AppMethods.isScrollPositionBiggerThanMaxScroll(scrollPosition) ? 40 : 0,
      curve: Curves.easeIn,
      duration: AppConstants.animationDuration,
      child: SizedBox(
        child: Row(
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            Text(
              text,
              style: AppStyles.smallLightWhiteStyle,
            ),
            AppMethods.isScrollPositionBiggerThanMaxScroll(scrollPosition) ? AppConstants.locationIcon : const SizedBox()
          ],
        ),
      ),
    );
  }
}
