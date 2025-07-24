import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

circleIndeactorCustom(BuildContext context,[ Color? color= Colors.green]) {
  return Center(
    child: SizedBox(
      width: 150,
      height: 150,
      child: LoadingIndicator(
        indicatorType: Indicator.ballClipRotateMultiple,
        colors:  [color!],
        strokeWidth: 2,

      ),
    ),
  );
}
