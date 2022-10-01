import 'package:dartz/dartz.dart';
import '../entites/weather_entity.dart';
import '../repository/base_weather_repository.dart';
import 'base_use_case.dart';
import '../../errors/failure.dart';

class GetWeatherDataByCityName extends BaseUseCase<WeatherEntity, String> {
  final BaseWeatherRepository weatherRepository;
  GetWeatherDataByCityName({required this.weatherRepository});
  @override
  Future<Either<Failure, WeatherEntity>> call(String parameters) async {
    return await weatherRepository.getWeatherDataByCityName(cityName: parameters);
  }
}
