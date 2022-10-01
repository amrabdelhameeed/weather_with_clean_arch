// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_with_clean_arch/core/enums/request_state.dart';
import 'package:weather_with_clean_arch/core/utils/location_helper.dart';
import 'package:weather_with_clean_arch/domain/entites/weather_entity.dart';
import 'package:weather_with_clean_arch/domain/use_cases/get_weather_data_by_longtiude_and_latitude.dart';

part 'my_location_weather_event.dart';
part 'my_location_weather_state.dart';

class MyLocationWeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final GetWeatherDataByLongtiudeAndLatitude getWeatherDataByLongtiudeAndLatitude;
  MyLocationWeatherBloc({
    required this.getWeatherDataByLongtiudeAndLatitude,
  }) : super(const WeatherState()) {
    on<GetWeatherDataByLongtiudeAndLatitudeEvent>((event, emit) async {
      late Position position;
      final pos = await LocationHelper.getMyLocationPosition();
      emit(const WeatherState(myLocationRequestState: RequestState.loading));
      pos.fold((l) {
        emit(state.copyWith(
          myLocationMessage: l.errorMessage,
          myLocationRequestState: RequestState.error,
        ));
      }, (r) {
        position = r;
      });
      final resault = await getWeatherDataByLongtiudeAndLatitude.call(position);
      resault.fold((l) {
        emit(state.copyWith(
          myLocationMessage: l.errorMessage,
          myLocationRequestState: RequestState.error,
        ));
      }, (r) {
        emit(WeatherState(myLocationMessage: 'success', myLocationRequestState: RequestState.loaded, weatherEntity: r));
      });
    });
  }
}
