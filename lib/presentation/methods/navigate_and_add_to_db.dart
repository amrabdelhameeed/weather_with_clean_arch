import 'package:flutter/material.dart';
import '../../core/utils/app_routes.dart';
import '../../core/utils/hive_helper.dart';
import '../../core/widgets/custom_snackbar.dart';

void navigateAndAddToDatabase(BuildContext context, TextEditingController controller) {
  if (controller.text.isNotEmpty) {
    Navigator.popAndPushNamed(context, AppRoutes.weatherCityScreen, arguments: controller.text).then((value) {
      _addToDatabase(cityName: controller.text).then((value) {
        controller.clear();
      });
    });
  } else {
    Navigator.pop(context);
    CustomSnackBar.show(context: context, text: 'Value is empty');
  }
}

Future<void> _addToDatabase({required String cityName}) async {
  await LocationDatabase.addLocation(cityName);
}
