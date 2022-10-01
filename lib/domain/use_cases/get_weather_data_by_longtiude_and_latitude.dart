import 'package:dartz/dartz.dart';
import 'package:geolocator/geolocator.dart';
import '../entites/weather_entity.dart';
import '../repository/base_weather_repository.dart';
import 'base_use_case.dart';
import '../../errors/failure.dart';

class GetWeatherDataByLongtiudeAndLatitude extends BaseUseCase<WeatherEntity, Position> {
  final BaseWeatherRepository weatherRepository;
  GetWeatherDataByLongtiudeAndLatitude({required this.weatherRepository});
  @override
  Future<Either<Failure, WeatherEntity>> call(Position parameters) async {
    return await weatherRepository.getWeatherDataByLongtiudeAndLatitude(position: parameters);
  }
}
