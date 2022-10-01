part of 'my_location_weather_bloc.dart';

abstract class WeatherEvent extends Equatable {
  const WeatherEvent();
  @override
  List<Object> get props => [];
}

class GetWeatherDataByLongtiudeAndLatitudeEvent extends WeatherEvent {
  const GetWeatherDataByLongtiudeAndLatitudeEvent();
  @override
  List<Object> get props => [];
}
