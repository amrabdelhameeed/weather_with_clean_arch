import 'package:dartz/dartz.dart';
import 'package:geolocator/geolocator.dart';
import '../entites/weather_entity.dart';
import '../../errors/failure.dart';

abstract class BaseWeatherRepository {
  Future<Either<Failure, WeatherEntity>> getWeatherDataByLongtiudeAndLatitude({
    required Position position,
  });
  Future<Either<Failure, WeatherEntity>> getWeatherDataByCityName({required String cityName});
}
