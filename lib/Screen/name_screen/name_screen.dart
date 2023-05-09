import 'dart:developer';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:lottie/lottie.dart';
import 'package:pitarata_job/Screen/home/home.dart';
import 'package:pitarata_job/color/colors.dart';
import 'package:pitarata_job/widget/custom_text.dart';
import 'package:pitarata_job/widget/custom_text_field.dart';
import 'package:pitarata_job/widget/radius_button.dart';

import 'name_screen_1.dart';

class NameScreen extends StatefulWidget {
  const NameScreen({super.key});

  @override
  State<NameScreen> createState() => _NameScreenState();
}

class _NameScreenState extends State<NameScreen> {
  final email = TextEditingController();
  final TextEditingController password = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Container(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomeScreen()),
                            );
                          },
                          child: Text(
                            'skip',
                            style: TextStyle(
                                color: Colors.white70,
                                fontSize: 15,
                                decoration: TextDecoration.underline),
                          )),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: CustomText(
                        fontWeight: FontWeight.normal,
                        color: white,
                        text: 'Login to your account',
                        fontSize: 27,
                        fontFamily: 'Viga'),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: MediaQuery.of(context).size.height / 100,
                        horizontal: MediaQuery.of(context).size.width / 40),
                    child: Container(
                        width: MediaQuery.of(context).size.width,
                        child: Lottie.asset('assets/login_screen.json',
                            fit: BoxFit.fill)),
                  ),
                  Form(
                      autovalidateMode: AutovalidateMode.always,
                      child: CustomTextField(
                        icon: Icons.email,
                        keyInput: TextInputType.emailAddress,
                        hintText: 'email',
                        controller: email,
                      )),
                  SizedBox(
                    height: 5,
                  ),
                  CustomTextField(
                    icon: Icons.key,
                    keyInput: TextInputType.text,
                    controller: password,
                    hintText: 'password',
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Align(
                      alignment: Alignment.centerRight,
                      child: CustomText(
                        color: Colors.white54,
                        fontWeight: FontWeight.normal,
                        fontFamily: 'Comfortaa-VariableFont_wght',
                        fontSize: 13,
                        text: 'Reset my password',
                      )),
                  Expanded(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: InkWell(
                        onTap: () {
                          log(email.text.toString());

                          if (email.text.isNotEmpty &&
                              password.text.isNotEmpty) {
                            if (email.text.contains("@") &&
                                email.text.contains(".")) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomeScreen()),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("Enter valid email")),
                              );
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content:
                                      Text(" Incorrect email or password")),
                            );
                          }
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: RadiusButton(
                            color: font_green,
                            colortext: white,
                            text: 'LOGIN',
                            width: 200,
                            height: 60,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                              alignment: Alignment.center,
                              child: SizedBox(
                                width: 400,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "I don't have an account.",
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
                                              builder: (context) =>
                                                  NameScreenOne()),
                                        );
                                      },
                                      child: Text(
                                        "Create a new account",
                                        style: TextStyle(
                                            fontSize: 13,
                                            color: font_green,
                                            fontFamily:
                                                'Comfortaa-VariableFont_wght',
                                            decoration:
                                                TextDecoration.underline),
                                      ),
                                    )
                                  ],
                                ),
                              ))),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
