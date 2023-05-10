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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SizedBox(
              height: 100.h,
              child: Stack(children: [
                Column(
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
                          vertical: MediaQuery.of(context).size.height / 110,
                          horizontal: MediaQuery.of(context).size.width / 10),
                      child: Lottie.asset('assets/create_new_account.json'),
                    ),
                    CustomTextField(
                      icon: Icons.person,
                      keyInput: TextInputType.text,
                      controller: name,
                      hintText: 'enter your name',
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    CustomTextField(
                      icon: Icons.phone,
                      keyInput: TextInputType.number,
                      controller: mobile,
                      hintText: 'enter your mobile number',
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Form(
                      autovalidateMode: AutovalidateMode.always,
                      child: CustomTextField(
                        icon: Icons.email,
                        keyInput: TextInputType.emailAddress,
                        controller: email,
                        hintText: 'enter your email address',
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    CustomTextField(
                      icon: Icons.key,
                      keyInput: TextInputType.visiblePassword,
                      controller: password,
                      hintText: 'password',
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: InkWell(
                          onTap: () {
                            if (name.text.isNotEmpty &&
                                mobile.text.isNotEmpty &&
                                email.text.isNotEmpty &&
                                password.text.isNotEmpty) {
                              if (email.text.contains("@") &&
                                  email.text.contains(".")) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => NameScreenTwo()));
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text("enter valid email ")));
                              }
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text("required fill all ")),
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
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: Container(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                  alignment: Alignment.center,
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
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
                                                builder: (context) =>
                                                    NameScreen()),
                                          );
                                        },
                                        child: Text(
                                          "Login to my account",
                                          style: TextStyle(
                                              fontSize: 13,
                                              color: font_green,
                                              fontFamily:
                                                  'Comfortaa-VariableFont_wght',
                                              decoration:
                                                  TextDecoration.underline),
                                        ),
                                      ),
                                    ],
                                  ))),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    )
                  ],
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
