import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../core/utils/app_constants.dart';
import '../../core/utils/app_styles.dart';
import '../../core/widgets/space.dart';

class CurrentWeatherMainPanel extends StatelessWidget {
  const CurrentWeatherMainPanel({
    Key? key,
    required this.city,
    required this.dateTime,
    required this.feelsLikeC,
    required this.maxTemp,
  }) : super(key: key);
  final String city;
  final int feelsLikeC;
  final int maxTemp;
  final DateTime dateTime;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      padding: AppConstants.pageHorizontalPadding,
      duration: AppConstants.animationDuration,
      color: Colors.transparent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const VerticalSpace(value: 10),
          Text(
            Runes('$maxTemp\u00b0 ').string,
            style: AppStyles.bigLightWhiteStyle,
          ),
          const VerticalSpace(value: 2),
          Row(
            children: [
              Text(
                city,
                style: AppStyles.midLightWhiteStyle,
              ),
              AppConstants.locationIcon
            ],
          ),
          const VerticalSpace(value: 1),
          Text(
            Runes('$maxTemp\u00b0 Feels like $feelsLikeC\u00b0').string,
            style: AppStyles.smallLightWhiteStyle,
          ),
          Text(
            DateFormat('EEEEE,h:mm a').format(dateTime).toString(),
            style: AppStyles.smallLightWhiteStyle,
          ),
        ],
      ),
    );
  }
}
