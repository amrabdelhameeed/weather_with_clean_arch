import 'package:geolocator/geolocator.dart';
import '../data_source/weather_remote_data_source.dart';
import '../../domain/entites/weather_entity.dart';
import 'package:dartz/dartz.dart';
import '../../domain/repository/base_weather_repository.dart';
import '../../errors/exception.dart';
import '../../errors/failure.dart';

class WeatherRepositoryImpl extends BaseWeatherRepository {
  final BaseWeatherRemoteDataSource weatherRemoteDataSource;

  WeatherRepositoryImpl(this.weatherRemoteDataSource);
  @override
  Future<Either<Failure, WeatherEntity>> getWeatherDataByCityName({required String cityName}) async {
    try {
      final resault = await weatherRemoteDataSource.getWeatherDataByCityName(cityName: cityName);
      return Right(resault);
    } on ServerExcption catch (failure) {
      return Left(ServerFailure(errorMessage: failure.errorMessgae));
    }
  }

  @override
  Future<Either<Failure, WeatherEntity>> getWeatherDataByLongtiudeAndLatitude({required Position position}) async {
    final resault = await weatherRemoteDataSource.getWeatherDataByLongtiudeAndLatitude(position: position);
    try {
      return Right(resault);
    } on ServerExcption catch (failure) {
      return Left(ServerFailure(errorMessage: failure.errorMessgae));
    }
  }
}
