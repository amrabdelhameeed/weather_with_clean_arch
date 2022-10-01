import 'package:flutter/material.dart';
import '../../core/utils/app_methods.dart';
import '../../core/utils/size_config.dart';
import '../../domain/entites/weather_entity.dart';
import 'animated_title.dart';
import 'current_weather_main_panel.dart';

class WeatherSliverAppBar extends StatelessWidget {
  const WeatherSliverAppBar({
    Key? key,
    required this.weatherEntity,
    required this.scrollPosition,
  }) : super(key: key);
  final WeatherEntity weatherEntity;
  final double scrollPosition;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      elevation: 0.0,
      backgroundColor: AppMethods.isScrollPositionBiggerThanMaxScroll(scrollPosition) ? Colors.black : Colors.transparent,
      pinned: true,
      expandedHeight: SizeConfig.defaultSize! * 30,
      flexibleSpace: FlexibleSpaceBar(
        background: !AppMethods.isScrollPositionBiggerThanMaxScroll(scrollPosition)
            ? CurrentWeatherMainPanel(
                city: weatherEntity.location.name,
                dateTime: DateTime.parse(weatherEntity.current.lastUpdated),
                feelsLikeC: weatherEntity.current.feelslikeC,
                maxTemp: weatherEntity.current.tempC,
              )
            : const SizedBox.shrink(),
      ),
      title: AnimatedTitle(text: weatherEntity.location.name, scrollPosition: scrollPosition),
    );
  }
}
