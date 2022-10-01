import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';

import '../../di.dart';
import '../../domain/entites/weather_entity.dart';
import '../../errors/exception.dart';
import '../models/weather_model.dart';

abstract class BaseWeatherRemoteDataSource {
  Future<WeatherEntity> getWeatherDataByLongtiudeAndLatitude({
    required Position position,
  });
  Future<WeatherEntity> getWeatherDataByCityName({required String cityName});
}

class WeatherRemoteDataSource extends BaseWeatherRemoteDataSource {
  final apiKey = '51183dd86e324dd0bdc225251222609';
  @override
  Future<WeatherEntity> getWeatherDataByLongtiudeAndLatitude({required Position position}) async {
    final response = await sl<Dio>().get('http://api.weatherapi.com/v1/forecast.json?key=$apiKey&q=${position.latitude},${position.longitude}&days=6&aqi=no&alerts=no');
    if (response.statusCode == 200) {
      return WeatherModel.fromJson(response.data);
    } else {
      throw ServerExcption(response.statusMessage.toString());
    }
  }

  @override
  Future<WeatherEntity> getWeatherDataByCityName({required String cityName}) async {
    try {
      final response = await sl<Dio>().get('http://api.weatherapi.com/v1/forecast.json?key=$apiKey&q=$cityName&days=1&aqi=no&alerts=no');
      if (response.statusCode == 200) {
        return WeatherModel.fromJson(response.data);
      } else {
        throw ServerExcption(response.statusMessage.toString());
      }
    } on DioError catch (e) {
      throw ServerExcption(e.message.toString());
    }
  }
}
