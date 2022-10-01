import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import '../../core/utils/app_constants.dart';
import '../../core/utils/app_images.dart';
import '../../core/utils/app_methods.dart';
import '../../core/utils/app_styles.dart';
import '../../core/utils/size_config.dart';
import '../../core/widgets/space.dart';
import '../../domain/entites/weather_entity.dart';

class WeatherDataBody extends StatelessWidget {
  const WeatherDataBody({Key? key, required this.weatherEntity}) : super(key: key);
  final WeatherEntity weatherEntity;
  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
      hasScrollBody: true,
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Container(
          padding: AppConstants.pageHorizontalPadding,
          child: Column(
            children: [
              Container(
                  decoration: AppStyles.whiteBoxDecoration,
                  child: SingleChildScrollView(
                    controller: ScrollController(initialScrollOffset: SizeConfig.screenWidth! * 0.7),
                    scrollDirection: Axis.horizontal,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: SizeConfig.defaultSize! * 2, vertical: SizeConfig.defaultSize! / 1),
                      width: SizeConfig.screenWidth! * 4,
                      height: SizeConfig.defaultSize! * 16,
                      child: LineChart(
                        LineChartData(
                          lineBarsData: [
                            LineChartBarData(
                                show: true,
                                spots: weatherEntity.forecast.forecastday.first.hour.map((point) => FlSpot(DateTime.parse(point.time).hour.toDouble(), point.tempC!.toDouble())).toList(),
                                isCurved: false,
                                color: Colors.white,
                                belowBarData: BarAreaData(show: false)),
                          ],
                          borderData: FlBorderData(border: const Border()),
                          gridData: FlGridData(show: false),
                          titlesData: FlTitlesData(
                            bottomTitles: AxisTitles(axisNameSize: 250, sideTitles: _bottomTitles(weatherEntity)),
                            leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                            topTitles: AxisTitles(axisNameSize: 250, sideTitles: _topTitles(weatherEntity)),
                            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                          ),
                        ),
                      ),
                    ),
                  )),
              const VerticalSpace(value: 2),
              if (weatherEntity.forecast.forecastday.length != 1)
                Container(
                  padding: EdgeInsets.all(SizeConfig.defaultSize! * 1.3),
                  decoration: AppStyles.whiteBoxDecoration,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const Expanded(
                            flex: 4,
                            child: Text(
                              'Today',
                              style: AppStyles.smallLightWhiteStyle,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              Runes('${weatherEntity.forecast.forecastday.first.day.maxtempC}\u00b0 ${weatherEntity.forecast.forecastday.first.day.mintempC}\u00b0').string,
                              style: AppStyles.smallLightWhiteStyle,
                            ),
                          )
                        ],
                      ),
                      const VerticalSpace(value: 3),
                      Column(
                        children: [
                          for (int i = 1; i < weatherEntity.forecast.forecastday.length; i++)
                            DayDataWidget(
                                humdity: weatherEntity.forecast.forecastday[i].day.avghumidity,
                                date: DateTime.parse(weatherEntity.forecast.forecastday[i].date),
                                maxTemp: weatherEntity.forecast.forecastday[i].day.maxtempC,
                                minTemp: weatherEntity.forecast.forecastday[i].day.mintempC)
                        ],
                      )
                    ],
                  ),
                ),
              const VerticalSpace(value: 2),
              AstroWidget(
                sunset: weatherEntity.forecast.forecastday.first.astro.sunset,
                sunrise: weatherEntity.forecast.forecastday.first.astro.sunrise,
              ),
              const VerticalSpace(value: 2),
              WimdHumidityUVWidget(
                wind: (weatherEntity.forecast.forecastday.first.hour.map((e) => e.windKph).reduce((value, element) => value! + element!)! ~/ 24).toInt(),
                humidity: weatherEntity.forecast.forecastday.first.day.avghumidity,
                uv: weatherEntity.forecast.forecastday.first.day.uv,
              )
            ],
          ),
        ),
      ),
    );
  }

  SideTitles _bottomTitles(WeatherEntity weatherEntity) {
    final list = List<Widget>.generate(
        24,
        (index) => Text(
              DateFormat('h a').format(DateTime.parse(weatherEntity.forecast.forecastday.first.hour[index].time)),
              style: AppStyles.tooSmallWhiteStyle,
            ));
    // print(list);
    return SideTitles(
      interval: 1.0,
      showTitles: true,
      getTitlesWidget: (value, meta) {
        return list[value.toInt()];
      },
    );
  }

  SideTitles _topTitles(WeatherEntity weatherEntity) {
    final list = List<Widget>.generate(
        24,
        (index) => Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    Runes('${weatherEntity.forecast.forecastday.first.hour.elementAt(index).tempC}\u00b0').string,
                    style: AppStyles.smallLightWhiteStyle,
                  ),
                  Image.asset(AppMethods.isDay(weatherEntity, index) ? AppImages.sun : AppImages.moon,
                      color: AppMethods.isDay(weatherEntity, index) ? Colors.amber : Colors.white, width: SizeConfig.defaultSize! * 3.5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(Icons.water_drop_rounded, color: Colors.white.withOpacity(0.7), size: SizeConfig.defaultSize! * 1.3),
                      Text(
                        '${weatherEntity.forecast.forecastday.first.hour.elementAt(index).humidity}%',
                        style: AppStyles.tooSmallWhiteStyle,
                      )
                    ],
                  )
                ],
              ),
            ));
    // print(list);
    return SideTitles(
      interval: 1.0,
      showTitles: true,
      reservedSize: SizeConfig.defaultSize! * 8,
      getTitlesWidget: (value, meta) {
        return list[value.toInt()];
      },
    );
  }
}

class WimdHumidityUVWidget extends StatelessWidget {
  const WimdHumidityUVWidget({Key? key, required this.humidity, required this.uv, required this.wind}) : super(key: key);
  final int wind;
  final int humidity;
  final double uv;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(SizeConfig.defaultSize! * 1.3),
      decoration: AppStyles.whiteBoxDecoration,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              children: [
                Lottie.asset('assets/images/lottie/uv.json', width: SizeConfig.defaultSize! * 8),
                const Text('UV Index', style: AppStyles.smallLightWhiteStyle),
                Text(uvLevel(uv: uv), style: AppStyles.smallLightWhiteStyle),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Lottie.asset('assets/images/lottie/wind.json', width: SizeConfig.defaultSize! * 8),
                const Text('Wind', style: AppStyles.smallLightWhiteStyle),
                Text('$wind km/h', style: AppStyles.smallLightWhiteStyle),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Lottie.asset('assets/images/lottie/water_drop.json', width: SizeConfig.defaultSize! * 15),
                const Text('Humidity', style: AppStyles.smallLightWhiteStyle),
                Text('$humidity%', style: AppStyles.smallLightWhiteStyle),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class AstroWidget extends StatelessWidget {
  const AstroWidget({Key? key, required this.sunrise, required this.sunset}) : super(key: key);
  final String sunrise;
  final String sunset;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(SizeConfig.defaultSize! * 1.3),
      decoration: AppStyles.whiteBoxDecoration,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              children: [
                const Text('Sunrise', style: AppStyles.smallLightWhiteStyle),
                Text(sunrise, style: AppStyles.smallLightWhiteStyle),
                Image.asset(AppImages.sun),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                const Text('Sunset', style: AppStyles.smallLightWhiteStyle),
                Text(sunset, style: AppStyles.smallLightWhiteStyle),
                Image.asset(AppImages.moon, color: Colors.white),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class DayDataWidget extends StatelessWidget {
  final int humdity;
  final DateTime date;
  final int maxTemp;
  final int minTemp;
  const DayDataWidget({Key? key, required this.humdity, required this.date, required this.maxTemp, required this.minTemp}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 2,
          child: Text(
            DateFormat('EEEEE').format(date),
            style: AppStyles.smallLightWhiteStyle,
          ),
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(Icons.water_drop_rounded, color: Colors.white.withOpacity(0.7), size: SizeConfig.defaultSize! * 1.3),
              Text(
                '$humdity%',
                style: AppStyles.tooSmallWhiteStyle,
              )
            ],
          ),
        ),
        Expanded(
          child: Row(
            children: [
              Image.asset(AppImages.sun, width: SizeConfig.defaultSize! * 3),
              Image.asset(AppImages.moon, color: Colors.white, width: SizeConfig.defaultSize! * 3),
            ],
          ),
        ),
        Expanded(
          child: Text(
            Runes('$maxTemp\u00b0 $minTemp\u00b0').string,
            style: AppStyles.smallLightWhiteStyle,
          ),
        )
      ],
    );
  }
}

String uvLevel({required double uv}) {
  // print(uv);
  if (uv <= 2) {
    return 'Low';
  } else if (uv >= 3 && uv <= 5) {
    return 'Moderate';
  } else if (uv >= 6 && uv <= 7) {
    return 'High';
  } else {
    return 'Very High';
  }
}
