import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import '../../core/enums/request_state.dart';
import '../../core/utils/app_constants.dart';
import '../../core/utils/hive_helper.dart';
import '../../core/utils/size_config.dart';
import '../../core/widgets/custom_snackbar.dart';
import '../../core/widgets/full_screen_positioned_widget.dart';
import '../../di.dart';
import '../controllers/city_bloc/city_bloc.dart';
import '../widgets/animated_background.dart';
import '../widgets/weather_black_panel.dart';
import '../widgets/weather_data_body_widget.dart';
import '../widgets/weather_sliver_app_bar.dart';

class WeatherCityScreen extends StatefulWidget {
  const WeatherCityScreen({Key? key, required this.city}) : super(key: key);
  final String city;

  @override
  State<WeatherCityScreen> createState() => _WeatherCityScreenState();
}

class _WeatherCityScreenState extends State<WeatherCityScreen> {
  final ScrollController _scrollController = ScrollController();
  double _scrollPosition = 0;

  _scrollListener() {
    setState(() {
      _scrollPosition = _scrollController.position.pixels;
    });
  }

  @override
  void initState() {
    _scrollController.addListener(_scrollListener);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CityBloc>(
        create: (context) => CityBloc(getWeatherDataByCityName: sl())..add(GetWeatherDataByCityNameEvent(widget.city)),
        child: BlocBuilder<CityBloc, CityState>(
          builder: (context, state) {
            if (state.cityRequestState == RequestState.loaded) {
              return Scaffold(
                backgroundColor: Colors.black,
                body: Stack(
                  children: [
                    // background
                    FullScreenPositionedWidget(
                        widget: AnimatedBackground(
                      isDay: state.weatherEntityForCity!.current.isDay,
                      scrollPosition: _scrollPosition,
                      maxScroll: AppConstants.maxScroll,
                      duration: AppConstants.animationDuration,
                    )),
                    // screen
                    FullScreenPositionedWidget(
                        widget: CustomScrollView(
                      controller: _scrollController,
                      slivers: [
                        WeatherSliverAppBar(weatherEntity: state.weatherEntityForCity!, scrollPosition: _scrollPosition),
                        WeatherDataBody(
                          weatherEntity: state.weatherEntityForCity!,
                        )
                      ],
                    )),
                    // black panel with current weather data
                    WeatherBlackPanel(
                      scrollPosition: _scrollPosition,
                      city: state.weatherEntityForCity!.location.name,
                      dateTime: DateTime.parse(state.weatherEntityForCity!.current.lastUpdated),
                      feelsLikeC: state.weatherEntityForCity!.current.feelslikeC,
                      maxTemp: state.weatherEntityForCity!.current.tempC,
                    ),
                  ],
                ),
              );
            } else {
              _deleteLocation(cityName: widget.city);
              return BlocListener<CityBloc, CityState>(
                listener: (context, state) {
                  if (state.cityRequestState == RequestState.error) {
                    CustomSnackBar.show(context: context, text: '${widget.city} not a valid city');
                    Navigator.pop(context);
                  }
                },
                child: Lottie.asset(
                  'assets/images/lottie/day_and_night.json',
                  fit: BoxFit.cover,
                  width: SizeConfig.screenWidth!,
                  height: SizeConfig.screenHeight!,
                ),
              );
            }
          },
        ));
  }
}

Future<void> _deleteLocation({required String cityName}) async {
  LocationDatabase.deleteLocation(cityName);
}
