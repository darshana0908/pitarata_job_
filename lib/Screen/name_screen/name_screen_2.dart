import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:pitarata_job/Screen/start/start.dart';
import 'package:pitarata_job/color/colors.dart';
import 'package:pitarata_job/widget/custom_text.dart';
import 'package:pitarata_job/widget/custom_text_field.dart';
import 'package:pitarata_job/widget/radius_button.dart';

import 'name_screen.dart';

class NameScreenTwo extends StatefulWidget {
  const NameScreenTwo({super.key});

  @override
  State<NameScreenTwo> createState() => _NameScreenTwoState();
}

class _NameScreenTwoState extends State<NameScreenTwo> {
  TextEditingController code = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Stack(children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 50),
                    child: Container(
                      alignment: Alignment.center,
                      child: CustomText(
                          fontWeight: FontWeight.normal,
                          color: white,
                          text: " You are almost there",
                          fontSize: 25,
                          fontFamily: 'Viga'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 60),
                    child: Lottie.asset('assets/enter_otp.json'),
                  ),
                  CustomText(
                      fontWeight: FontWeight.normal,
                      color: white,
                      text: " We just sent an OTP to \n info@navatechzone.com.",
                      fontSize: 20,
                      fontFamily: 'Viga'),
                  SizedBox(
                    height: 10,
                  ),
                  CustomText(
                      fontWeight: FontWeight.w200,
                      color: Colors.white54,
                      text:
                          " Check your emails get the verification \ncode of your account",
                      fontSize: 18,
                      fontFamily: 'Comfortaa-VariableFont_wght'),
                ],
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Column(
                  children: [
                    CustomTextField(
                      icon: Icons.verified_user_rounded,
                      keyInput: TextInputType.number,
                      controller: code,
                      hintText: 'enter the verfication code',
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Start()),
                        );
                      },
                      child: RadiusButton(
                        color: font_green,
                        colortext: white,
                        text: 'VERIFY MY ACCOUNT',
                        width: 230,
                        height: 60,
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 14,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Container(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                              alignment: Alignment.center,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "I already have an account.",
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: font_green,
                                        fontFamily:
                                            'Comfortaa-VariableFont_wght'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => NameScreen()),
                                      );
                                    },
                                    child: Text(
                                      "Login to my account",
                                      style: TextStyle(
                                          fontSize: 13,
                                          color: font_green,
                                          fontFamily:
                                              'Comfortaa-VariableFont_wght',
                                          decoration: TextDecoration.underline),
                                    ),
                                  )
                                ],
                              ))),
                    ),
                    SizedBox(
                      height: 20,
                    )
                  ],
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
