import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../color/colors.dart';

class RadiusButton extends StatelessWidget {
  const RadiusButton({
    super.key,
    required this.text,
    required this.width,
    required this.height,
    required this.color,
    required this.colortext,
  });
  final String text;
  final double width;
  final double height;
  final Color color;
  final Color colortext;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: height,
      width: width,
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(20), color: color),
      child: Text(text,
          textAlign: TextAlign.center,
          style: TextStyle(
              color: colortext,
              fontFamily: 'Comfortaa-VariableFont_wght',
              fontSize: 17)),
    );
  }
}
