import 'package:flutter/material.dart';

class FullScreenPositionedWidget extends StatelessWidget {
  const FullScreenPositionedWidget({
    Key? key,
    required this.widget,
  }) : super(key: key);

  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      top: 0,
      bottom: 0,
      child: widget,
    );
  }
}
