import 'dart:ffi';

import 'package:flutter/material.dart';

import '../color/colors.dart';
import 'custom_text.dart';

class DrawerRow extends StatelessWidget {
  const DrawerRow({super.key, required this.text, required this.on});
  final String text;
  final VoidCallback on;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: on,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              child: Row(
                children: [
                  Icon(
                    Icons.check_circle_rounded,
                    color: font_green,
                    size: 15,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  CustomText(
                      text: text,
                      fontSize: 12,
                      fontFamily: 'Comfortaa-VariableFont_wght',
                      color: white,
                      fontWeight: FontWeight.normal),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios_sharp,
              color: white,
              size: 15,
            ),
          ],
        ),
      ),
    );
  }
}
