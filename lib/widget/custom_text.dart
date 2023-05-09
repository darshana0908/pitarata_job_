import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class CustomText extends StatelessWidget {
  const CustomText(
      {super.key,
      required this.text,
      required this.fontSize,
      required this.fontFamily,
      required this.color,
      required this.fontWeight});
  final String text;
  final double fontSize;
  final String fontFamily;
  final Color color;
  final FontWeight fontWeight;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(text,
          textAlign: TextAlign.center,
          style: TextStyle(
              color: color,
              fontFamily: fontFamily,
              fontSize: fontSize,
              fontWeight: fontWeight)),
    );
  }
}
