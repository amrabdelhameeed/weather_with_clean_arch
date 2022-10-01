import 'package:flutter/material.dart';
import '../../core/utils/size_config.dart';
import '../methods/navigate_and_add_to_db.dart';

class SearchButton extends StatelessWidget {
  const SearchButton({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: SizeConfig.defaultSize! * 5,
      width: double.infinity,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(primary: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
          onPressed: () {
            navigateAndAddToDatabase(context, controller);
          },
          child: const Text(
            'Search',
            style: TextStyle(color: Colors.black),
          )),
    );
  }
}
