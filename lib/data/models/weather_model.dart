import '../../domain/entites/weather_entity.dart';

class WeatherModel extends WeatherEntity {
  WeatherModel({required super.location, required super.current, required super.forecast});
  factory WeatherModel.fromJson(Map<String, dynamic> json) =>
      WeatherModel(location: Location.fromJson(json['location']), current: Current.fromJson(json['current']), forecast: Forecast.fromJson(json['forecast']));
}
