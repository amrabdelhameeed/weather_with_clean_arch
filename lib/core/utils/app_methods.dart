import 'app_constants.dart';

class AppMethods {
  static bool isScrollPositionBiggerThanMaxScroll(scrollPosition) => scrollPosition > AppConstants.maxScroll;

  static bool isDay(weatherEntity, index) => weatherEntity.forecast.forecastday.first.hour.elementAt(index).isDay;
}
