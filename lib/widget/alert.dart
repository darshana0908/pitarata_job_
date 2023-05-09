import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../color/colors.dart';
import 'custom_text.dart';
import 'radius_button.dart';

class AlertDiloag extends StatelessWidget {
  const AlertDiloag({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
              height: 300,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: black, borderRadius: BorderRadius.circular(15)),
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.topRight,
                    child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.close,
                          color: Colors.white70,
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomText(
                        text:
                            'Are you sure you you need to remove this job from  your favorite list ?',
                        fontSize: 20,
                        fontFamily: 'Comfortaa-VariableFont_wght',
                        color: white,
                        fontWeight: FontWeight.normal),
                  ),
                  SizedBox(
                    height: 35,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: RadiusButton(
                          colortext: black,
                          color: white,
                          height: 70,
                          width: 110,
                          text: 'NO',
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: RadiusButton(
                          colortext: black,
                          color: red,
                          height: 70,
                          width: 110,
                          text: 'YES',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
  }
}