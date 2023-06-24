import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:pitarata_job/Screen/intro/intro_2.dart';
import 'package:pitarata_job/color/colors.dart';
import 'package:sizer/sizer.dart';

import '../../widget/arrow_button.dart';

class IntroOnePage extends StatefulWidget {
  const IntroOnePage({super.key});

  @override
  State<IntroOnePage> createState() => _IntroOnePageState();
}

class _IntroOnePageState extends State<IntroOnePage> {
  var asset;

  var image;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black,
      body: Column(children: [
        SizedBox(height: MediaQuery.of(context).size.height / 6),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 100),
          child: Lottie.asset('assets/intro_1.json'),
        ),
        SizedBox(height: 6.h),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
              ' Welcome to the Pita Rata Jobs.\n The app that helps you find job opportunities abroad!',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white, fontFamily: 'Viga', fontSize: 20.sp)),
        ),
        Expanded(
          child: Container(
            alignment: Alignment.bottomRight,
            child: ArrowButton(onTap: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => IntroTwoPage()),
              );
            },
              icons: Icons.arrow_forward_ios_rounded,
            ),
          ),
        )
      ]),
    );
  }
}
