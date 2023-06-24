import 'package:flutter/material.dart';
import 'package:pitarata_job/Screen/name_screen/name_screen.dart';
import 'package:pitarata_job/color/colors.dart';
import 'package:pitarata_job/widget/radius_button.dart';
import 'package:sizer/sizer.dart';

import '../sign_up/sign_up.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black,
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(children: [
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: 10.h,
                horizontal: 10,
              ),
              child: Text(
                  '"The best preparation \nfor tommorrow is doing your best today"',
                  textAlign: TextAlign.center,
                  softWrap: true,
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Viga',
                      fontSize: 40.sp)),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text('Take a moment each day to improve yourself. ',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white, fontFamily: 'Viga', fontSize: 26)),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: RadiusButton(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignUp()),
                    );
                  },
                  color: font_green,
                  colortext: white,
                  height: 70,
                  text: "Let's do this",
                  width: 150,
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
