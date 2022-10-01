import 'package:flutter/material.dart';
import 'core/utils/app_routes.dart';
import 'presentation/screens/home.dart';
import 'presentation/screens/weather_city_screen.dart';

class AppRouter {
  // AppRouter() {}
  Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.home:
        return MaterialPageRoute(
          builder: (context) {
            return const Home();
          },
        );
      case AppRoutes.weatherCityScreen:
        return MaterialPageRoute(
          builder: (context) {
            final city = settings.arguments as String;
            return WeatherCityScreen(
              city: city,
            );
          },
        );
    }
    return _routeError();
  }

  MaterialPageRoute<dynamic> _routeError() {
    return MaterialPageRoute(
      builder: (_) {
        return const Scaffold(
          body: Center(
            child: Text('Route Error'),
          ),
        );
      },
    );
  }
}
