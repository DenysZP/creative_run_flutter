import 'dart:math';

import 'package:flutter/material.dart';

class ColorChip extends StatelessWidget {
  static const whiteColorBoundRatio = 7;
  final Color _color;

  ColorChip(this._color);

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(
        _hexString,
        style: TextStyle(color: _contrastColor),
      ),
      backgroundColor: _color,
    );
  }

  String get _hexString {
    final hexString = _color.value.toRadixString(16).padLeft(8, '0');
    return hexString.replaceRange(0, 2, "#");
  }

  Color get _contrastColor {
    final double luminance1 = _calculateLuminance(_color) + 0.05;
    final double luminance2 = _calculateLuminance(Colors.black) + 0.05;
    final ratio = max(luminance1, luminance2) / min(luminance1, luminance2);
    print(ratio);
    return ratio > whiteColorBoundRatio ? Colors.black : Colors.white;
  }

  double _calculateLuminance(Color color) {
    double sr = color.red / 255.0;
    sr = sr < 0.04045 ? sr / 12.92 : pow((sr + 0.055) / 1.055, 2.4);
    double sg = color.green / 255.0;
    sg = sg < 0.04045 ? sg / 12.92 : pow((sg + 0.055) / 1.055, 2.4);
    double sb = color.blue / 255.0;
    sb = sb < 0.04045 ? sb / 12.92 : pow((sb + 0.055) / 1.055, 2.4);
    return sr * 0.2126 + sg * 0.7152 + sb * 0.0722;
  }
}
