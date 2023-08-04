import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../color/colors.dart';
import 'custom_text.dart';

class CustomContainer extends StatelessWidget {
  const CustomContainer(
      {super.key,
      required this.text1,
      required this.text2,
      required this.colorText,
      required this.icon});
  final String text1;
  final String text2;
  final Color colorText;
  final String icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: double.infinity,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: light_dark, borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Stack(
          children: [
            Positioned(
              left: 0,
              right: 0,
              top: 0,
              bottom: 0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomText(
                    color: colorText,
                    fontFamily: 'Comfortaa-VariableFont_wght',
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    text: text1,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  CustomText(
                    color: Colors.white70,
                    fontFamily: 'Comfortaa-VariableFont_wght',
                    fontSize: 13,
                    fontWeight: FontWeight.normal,
                    text: text2,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  alignment: Alignment.bottomRight,
                  child: SvgPicture.asset(
                    height: 40,
                    icon,
                    alignment: Alignment.centerRight,
                    color: Colors.white24,
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
