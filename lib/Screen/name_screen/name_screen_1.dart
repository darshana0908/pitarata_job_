import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:lottie/lottie.dart';
import 'package:pitarata_job/Screen/name_screen/name_screen_2.dart';
import 'package:pitarata_job/color/colors.dart';
import 'package:pitarata_job/widget/custom_text.dart';
import 'package:pitarata_job/widget/custom_text_field.dart';
import 'package:pitarata_job/widget/radius_button.dart';
import 'package:sizer/sizer.dart';

import 'name_screen.dart';

class NameScreenOne extends StatefulWidget {
  const NameScreenOne({super.key});

  @override
  State<NameScreenOne> createState() => _NameScreenOneState();
}

class _NameScreenOneState extends State<NameScreenOne> {
  TextEditingController name = TextEditingController();
  TextEditingController mobile = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  bool checkBox = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Container(
                    alignment: Alignment.center,
                    child: CustomText(
                        fontWeight: FontWeight.normal,
                        color: white,
                        text: " Let's create your\n brand new account",
                        fontSize: 25,
                        fontFamily: 'Viga'),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: MediaQuery.of(context).size.height / 200,
                      horizontal: MediaQuery.of(context).size.width / 10),
                  child: Lottie.asset('assets/create_new_account.json'),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: CustomTextField(
                    icon: Icons.person,
                    keyInput: TextInputType.text,
                    controller: name,
                    hintText: 'enter your name',
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: CustomTextField(
                    icon: Icons.phone,
                    keyInput: TextInputType.number,
                    controller: mobile,
                    hintText: 'enter your mobile number',
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Form(
                    autovalidateMode: AutovalidateMode.always,
                    child: CustomTextField(
                      icon: Icons.email,
                      keyInput: TextInputType.emailAddress,
                      controller: email,
                      hintText: 'enter your email address',
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: CustomTextField(
                    icon: Icons.key,
                    keyInput: TextInputType.visiblePassword,
                    controller: password,
                    hintText: 'password',
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: CustomTextField(
                    icon: Icons.key,
                    keyInput: TextInputType.visiblePassword,
                    controller: confirmPassword,
                    hintText: 'confirm password',
                  ),
                ),
                Container(
                  height: 50,
                  child: Row(
                    children: [
                      Checkbox(
                        hoverColor: black,
                        focusColor: font_green,
                        checkColor: background_green,
                        activeColor: black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(1.0),
                        ),
                        side: MaterialStateBorderSide.resolveWith(
                          (states) => BorderSide(width: 2.0, color: font_green),
                        ),
                        value: checkBox,
                        onChanged: (value) {
                          setState(() {
                            checkBox = value!;
                            log(checkBox.toString());
                          });
                        },
                      ),
                      Row(
                        children: [
                          Text(
                            "I agree ",
                            style: TextStyle(
                                fontSize: 13,
                                color: font_green,
                                fontFamily: 'Comfortaa-VariableFont_wght'),
                          ),
                          Text(
                            "Terms & Condition ",
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                fontSize: 13,
                                color: font_green,
                                fontFamily: 'Comfortaa-VariableFont_wght'),
                          ),
                          Text(
                            "and ",
                            style: TextStyle(
                                fontSize: 13,
                                color: font_green,
                                fontFamily: 'Comfortaa-VariableFont_wght'),
                          ),
                          Text(
                            "Privacy Policy",
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                fontSize: 13,
                                color: font_green,
                                fontFamily: 'Comfortaa-VariableFont_wght'),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: InkWell(
                    onTap: () {
                      if (name.text.isNotEmpty &&
                          mobile.text.isNotEmpty &&
                          email.text.isNotEmpty &&
                          password.text.isNotEmpty) {
                        if (email.text.contains("@") &&
                            email.text.contains(".")) {
                          if (password.text == confirmPassword.text) {
                            if (checkBox == true) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => NameScreenTwo()));
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text("check Box  ")));
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text("password incorrect ")));
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("enter valid email ")),
                          );
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("required fill all ")),
                        );
                      }
                    },
                    child: RadiusButton(
                      color: font_green,
                      colortext: white,
                      text: 'CREATE MY ACCOUNT',
                      width: 230,
                      height: 60,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
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
                                ),
                              ],
                            ))),
                  ),
                ),
                SizedBox(
                  height: 25,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}