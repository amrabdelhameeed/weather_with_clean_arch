// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_with_clean_arch/core/enums/request_state.dart';
import 'package:weather_with_clean_arch/core/utils/app_constants.dart';
import 'package:weather_with_clean_arch/core/utils/app_images.dart';
import 'package:weather_with_clean_arch/core/utils/size_config.dart';
import 'package:weather_with_clean_arch/core/widgets/full_screen_positioned_widget.dart';
import 'package:weather_with_clean_arch/di.dart';
import 'package:weather_with_clean_arch/presentation/controllers/my_location_weather_bloc/my_location_weather_bloc.dart';
import 'package:weather_with_clean_arch/presentation/widgets/animated_background.dart';
import 'package:weather_with_clean_arch/presentation/widgets/weather_black_panel.dart';
import 'package:weather_with_clean_arch/presentation/widgets/weather_data_body_widget.dart';
import 'package:weather_with_clean_arch/presentation/widgets/weather_drawer.dart';
import 'package:weather_with_clean_arch/presentation/widgets/weather_sliver_app_bar.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  final ScrollController _scrollController = ScrollController();
  final controller = TextEditingController();
  double _scrollPosition = 0;
  _scrollListener() {
    setState(() {
      _scrollPosition = _scrollController.position.pixels;
    });
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return BlocProvider<MyLocationWeatherBloc>(
      create: (context) => sl<MyLocationWeatherBloc>()..add(const GetWeatherDataByLongtiudeAndLatitudeEvent()),
      child: BlocBuilder<MyLocationWeatherBloc, WeatherState>(
        builder: (context, state) {
          if (state.myLocationRequestState == RequestState.loaded) {
            return Scaffold(
              backgroundColor: Colors.black,
              drawer: SafeArea(
                child: WeatherDrawer(controller: controller),
              ),
              body: Stack(
                children: [
                  // background
                  FullScreenPositionedWidget(
                      widget: AnimatedBackground(
                    isDay: state.weatherEntity!.current.isDay,
                    scrollPosition: _scrollPosition,
                    maxScroll: AppConstants.maxScroll,
                    duration: AppConstants.animationDuration,
                  )),
                  // screen
                  FullScreenPositionedWidget(
                      widget: CustomScrollView(
                    controller: _scrollController,
                    slivers: [
                      WeatherSliverAppBar(weatherEntity: state.weatherEntity!, scrollPosition: _scrollPosition),
                      WeatherDataBody(
                        weatherEntity: state.weatherEntity!,
                      )
                    ],
                  )),
                  // black panel with current weather data
                  WeatherBlackPanel(
                    scrollPosition: _scrollPosition,
                    city: state.weatherEntity!.location.name,
                    dateTime: DateTime.parse(state.weatherEntity!.current.lastUpdated),
                    feelsLikeC: state.weatherEntity!.current.feelslikeC,
                    maxTemp: state.weatherEntity!.current.tempC,
                  ),
                ],
              ),
            );
          } else {
            return Lottie.asset(
              AppImages.dayNightLottie,
              fit: BoxFit.cover,
              width: SizeConfig.screenWidth!,
              height: SizeConfig.screenHeight!,
            );
          }
        },
      ),
    );
  }
}
