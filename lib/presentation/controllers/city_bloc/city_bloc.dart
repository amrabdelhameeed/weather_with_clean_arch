// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:weather_with_clean_arch/core/enums/request_state.dart';
import 'package:weather_with_clean_arch/domain/entites/weather_entity.dart';
import 'package:weather_with_clean_arch/domain/use_cases/get_weather_data_by_city_name.dart';

part 'city_event.dart';
part 'city_state.dart';

class CityBloc extends Bloc<CityEvent, CityState> {
  final GetWeatherDataByCityName getWeatherDataByCityName;
  CityBloc({
    required this.getWeatherDataByCityName,
  }) : super(const CityState()) {
    on<GetWeatherDataByCityNameEvent>((event, emit) async {
      emit(state.copyWith(cityRequestState: RequestState.loading));
      await getWeatherDataByCityName.call(event.cityName).then((value) {
        value.fold((l) {
          emit(state.copyWith(
            cityMessage: l.errorMessage,
            cityRequestState: RequestState.error,
          ));
        }, (r) {
          emit(state.copyWith(cityMessage: 'success', cityRequestState: RequestState.loaded, weatherEntityForCity: r));
        });
      });
    });
  }
}
