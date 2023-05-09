import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../color/colors.dart';
import 'custom_text.dart';

class AdArea extends StatelessWidget {
  const AdArea({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      color: white,
      height: 150,
      width: double.infinity,
      child: CustomText(
        color: red,
        fontFamily: 'Comfortaa-VariableFont_wght',
        fontSize: 27,
        fontWeight: FontWeight.bold,
        text: 'AD AREA',
      ),
    );
  }
}
