part of 'city_bloc.dart';

class CityState extends Equatable {
  final WeatherEntity? weatherEntityForCity;
  final RequestState cityRequestState;
  final String cityMessage;
  const CityState({this.cityRequestState = RequestState.loading, this.cityMessage = '', this.weatherEntityForCity});
  CityState copyWith({WeatherEntity? weatherEntityForCity, RequestState? cityRequestState, String? cityMessage}) {
    return CityState(
        cityMessage: cityMessage ?? this.cityMessage, cityRequestState: cityRequestState ?? this.cityRequestState, weatherEntityForCity: weatherEntityForCity ?? this.weatherEntityForCity);
  }

  @override
  List<Object?> get props => [weatherEntityForCity, cityRequestState, cityMessage];
}
