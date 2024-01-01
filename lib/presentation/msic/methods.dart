import 'package:flutter/material.dart';

Map<double, SizedBox> _verticalSpace = {};
Map<double, SizedBox> _horizontalSpace = {};

// SizedBox SizedBox(height: double height) {
//   if (!_verticalSpace.containsKey(height)) {
//     _verticalSpace[height] = SizedBox(
//       height: height,
//     );
//   }
//   return _verticalSpace[height]!;
// }

SizedBox horizontalSpace(double width) {
  if (!_horizontalSpace.containsKey(width)) {
    _verticalSpace[width] = SizedBox(
      width: width,
    );
  }
  return _verticalSpace[width]!;
}
