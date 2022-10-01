part of 'my_location_weather_bloc.dart';

class WeatherState extends Equatable {
  final WeatherEntity? weatherEntity;
  final RequestState myLocationRequestState;
  final String myLocationMessage;
  const WeatherState({
    this.weatherEntity,
    this.myLocationRequestState = RequestState.loading,
    this.myLocationMessage = '',
  });

  WeatherState copyWith({WeatherEntity? weatherEntity, RequestState? myLocationRequestState, String? myLocationMessage}) {
    return WeatherState(
        myLocationMessage: myLocationMessage ?? this.myLocationMessage,
        myLocationRequestState: myLocationRequestState ?? this.myLocationRequestState,
        weatherEntity: weatherEntity ?? this.weatherEntity);
  }

  @override
  List<Object?> get props => [
        weatherEntity,
        myLocationRequestState,
        myLocationMessage,
      ];
}
