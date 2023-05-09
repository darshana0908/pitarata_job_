import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:pitarata_job/color/colors.dart';
import 'package:pitarata_job/widget/custom_text.dart';

class ColorContainer extends StatelessWidget {
  const ColorContainer(
      {super.key,
      required this.color,
      required this.color1,
      required this.icon,
      required this.text,
      required this.text1,
      required this.iconColor,
      required this.textColor});
  final Color color;
  final Color color1;
  final IconData icon;
  final String text;
  final String text1;
  final Color textColor;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
          child: Column(children: [
            Row(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Icon(
                    icon,
                    size: 40,
                    color: iconColor,
                  ),
                ),
                CustomText(
                    text: text,
                    fontSize: 19,
                    fontFamily: 'Comfortaa-VariableFont_wght',
                    color: textColor,
                    fontWeight: FontWeight.normal)
              ],
            ),
            CustomText(
                text: text1,
                fontSize: 25,
                fontFamily: 'Comfortaa-VariableFont_wght',
                color: white,
                fontWeight: FontWeight.normal)
          ]),
          height: 100,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: new LinearGradient(
              colors: [
                color,
                color1,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: [0.1, 5.80],
            ),
          )),
    );
  }
}
