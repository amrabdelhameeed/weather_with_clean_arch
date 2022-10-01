part of 'city_bloc.dart';

abstract class CityEvent extends Equatable {
  const CityEvent();
  @override
  List<Object> get props => [];
}

class GetWeatherDataByCityNameEvent extends CityEvent {
  final String cityName;

  const GetWeatherDataByCityNameEvent(this.cityName);
  @override
  List<Object> get props => [cityName];
}
