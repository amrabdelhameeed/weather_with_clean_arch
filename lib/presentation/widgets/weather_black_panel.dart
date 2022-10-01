import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import '../../core/utils/app_constants.dart';
import '../../core/utils/app_methods.dart';
import '../../core/utils/app_styles.dart';
import '../../core/utils/size_config.dart';

class WeatherBlackPanel extends StatelessWidget {
  const WeatherBlackPanel({Key? key, required this.city, required this.dateTime, required this.feelsLikeC, required this.maxTemp, required this.scrollPosition}) : super(key: key);
  final String city;
  final int feelsLikeC;
  final int maxTemp;
  final DateTime dateTime;
  final double scrollPosition;

  @override
  Widget build(BuildContext context) {
    return Positioned(
        right: 0,
        left: 0,
        top: AppConstants.panelPosition,
        child: AnimatedContainer(
            padding: AppConstants.pageHorizontalPadding,
            duration: AppConstants.animationDuration,
            height: AppMethods.isScrollPositionBiggerThanMaxScroll(scrollPosition) ? SizeConfig.defaultSize! * 10 : 0,
            color: Colors.black,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(
                          Runes('$maxTemp\u00b0').string,
                          style: AppStyles.bigLightWhiteStyle,
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              Runes('$maxTemp\u00b0/$feelsLikeC\u00b0').string,
                              style: AppStyles.smallLightWhiteStyle,
                            ),
                            Text(
                              DateFormat('EEEEE,h:mm a').format(dateTime),
                              style: AppStyles.smallLightWhiteStyle,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                          flex: 2,
                          child: Lottie.asset(
                            'assets/images/lottie/weather.json',
                            fit: BoxFit.cover,
                          ))
                    ],
                  )
                ],
              ),
            )));
  }
}
