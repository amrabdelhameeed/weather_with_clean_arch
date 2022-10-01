import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'data/data_source/weather_remote_data_source.dart';
import 'data/repository/weather_repository_impl.dart';
import 'domain/repository/base_weather_repository.dart';
import 'domain/use_cases/get_weather_data_by_city_name.dart';
import 'domain/use_cases/get_weather_data_by_longtiude_and_latitude.dart';
import 'presentation/controllers/city_bloc/city_bloc.dart';
import 'presentation/controllers/my_location_weather_bloc/my_location_weather_bloc.dart';

final sl = GetIt.instance;

class ServiceLocator {
  void init() {
    // data source
    sl.registerLazySingleton<BaseWeatherRemoteDataSource>(() => WeatherRemoteDataSource());
    // repo
    sl.registerLazySingleton<BaseWeatherRepository>(() => WeatherRepositoryImpl(sl()));
    //use cases
    sl.registerLazySingleton(() => GetWeatherDataByLongtiudeAndLatitude(weatherRepository: sl()));
    sl.registerLazySingleton<GetWeatherDataByCityName>(() => GetWeatherDataByCityName(weatherRepository: sl()));
    //blocs
    sl.registerLazySingleton<MyLocationWeatherBloc>(() => MyLocationWeatherBloc(
          getWeatherDataByLongtiudeAndLatitude: sl(),
        ));
    sl.registerFactory<CityBloc>(() => CityBloc(getWeatherDataByCityName: sl()));
    // dio
    sl.registerLazySingleton<Dio>(() => Dio());
  }
}
