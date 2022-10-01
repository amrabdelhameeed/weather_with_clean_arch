import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../../core/utils/app_constants.dart';
import '../../core/utils/app_styles.dart';
import '../../core/utils/hive_helper.dart';
import '../../core/utils/size_config.dart';
import '../../core/widgets/custom_snackbar.dart';
import '../../core/widgets/default_text_form_field.dart';
import '../../core/widgets/space.dart';
import '../methods/navigate_and_add_to_db.dart';
import 'search_button_drawer.dart';

class WeatherDrawer extends StatelessWidget {
  const WeatherDrawer({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: SizeConfig.screenWidth! * (3 / 5),
      backgroundColor: const Color.fromARGB(255, 31, 34, 39),
      elevation: 0.0,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topRight: Radius.circular(20), bottomRight: Radius.circular(20))),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: SizeConfig.defaultSize!, vertical: SizeConfig.defaultSize!),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DefaultTextFormField(hint: 'Enter City Name', controller: controller),
            const VerticalSpace(value: 2),
            SearchButton(controller: controller),
            const VerticalSpace(value: 2),
            Row(
              children: const [
                Text(
                  'Other Cites',
                  textAlign: TextAlign.left,
                  style: TextStyle(color: Colors.grey, fontSize: 16, fontWeight: FontWeight.bold),
                ),
                AppConstants.locationIcon
              ],
            ),
            const VerticalSpace(value: 2),
            Expanded(
              child: ValueListenableBuilder<Box<String>>(
                valueListenable: LocationDatabase.listenable(),
                builder: (context, value, child) {
                  final locations = value.values.toList();
                  return ListView.separated(
                    separatorBuilder: (context, index) {
                      return const VerticalSpace(value: 2);
                    },
                    itemCount: locations.length,
                    itemBuilder: (context, index) {
                      final item = locations[index];
                      return ListTile(
                        onTap: () {
                          navigateAndAddToDatabase(context, controller..text = item);
                        },
                        title: Container(
                          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
                          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 5),
                          child: Text(
                            item,
                            textAlign: TextAlign.center,
                            style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
                          ),
                        ),
                        trailing: IconButton(
                            onPressed: () {
                              LocationDatabase.deleteLocation(item);
                              CustomSnackBar.show(context: context, text: '$item deleted', margin: const EdgeInsets.symmetric(vertical: 30, horizontal: 30));
                            },
                            icon: const Icon(
                              Icons.close,
                              color: Colors.red,
                            )),
                      );
                    },
                  );
                },
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 10), primary: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                  onPressed: () {
                    _clearAll();
                  },
                  child: const Text(
                    'Clear All',
                    style: TextStyle(color: Colors.red, fontWeight: FontWeight.w600),
                  )),
            ),
            const VerticalSpace(value: 1),
            const Divider(
              height: 1,
              color: Colors.white70,
            ),
            const VerticalSpace(value: 1),
            Row(
              children: const [
                Icon(Icons.report_gmailerrorred, color: Colors.white38),
                Text('Report wrong location', style: AppStyles.smallLightWhiteStyle),
              ],
            ),
            const VerticalSpace(value: 1),
            Row(
              children: const [
                Icon(Icons.call_rounded, color: Colors.white38),
                Text('Contact Me', style: AppStyles.smallLightWhiteStyle),
              ],
            ),
            const VerticalSpace(value: 1),
          ],
        ),
      ),
    );
  }
}

void _clearAll() {
  LocationDatabase.clearAll();
}
