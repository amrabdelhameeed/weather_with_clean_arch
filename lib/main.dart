import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'app_router.dart';
import 'core/utils/app_routes.dart';
import 'core/utils/constants.dart';
import 'core/utils/observer.dart';
import 'package:path_provider/path_provider.dart' as path;
import 'di.dart';

String intialRoute = AppRoutes.home;
void main() async {
  Bloc.observer = MyBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  final hivePath = await path.getApplicationDocumentsDirectory();
  Hive.init(hivePath.path);
  await Hive.openBox<String>(AppStrings.locationsKey);
  ServiceLocator().init();
  runApp(MyApp(
    appRouter: AppRouter(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.appRouter}) : super(key: key);
  final AppRouter appRouter;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Weather App',
      initialRoute: intialRoute,
      onGenerateRoute: appRouter.onGenerateRoute,
    );
  }
}
