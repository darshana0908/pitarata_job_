import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:pitarata_job/Screen/start/start.dart';
import 'package:pitarata_job/color/colors.dart';
import 'package:pitarata_job/widget/custom_text.dart';
import 'package:pitarata_job/widget/custom_text_field.dart';
import 'package:pitarata_job/widget/radius_button.dart';
import 'package:http/http.dart' as http;
import 'package:sizer/sizer.dart';
import 'name_screen.dart';

class NameScreenTwo extends StatefulWidget {
  const NameScreenTwo({
    super.key,
    required this.email,
  });
  final String email;
  // final String phone;
  // final Function loading;

  @override
  State<NameScreenTwo> createState() => _NameScreenTwoState();
}

class _NameScreenTwoState extends State<NameScreenTwo> {
  TextEditingController code = TextEditingController();
  bool isLoading = false;

  var resp;
  var msg;

  resendOtp() async {
    setState(() {
      isLoading = true;
    });

    var headers = {'Content-Type': 'application/json'};

    // request.headers.addAll(headers);
    var response = await http.post(
        Uri.parse(
            'https://pitaratajobs.novasoft.lk/_app_remove_server/nzone_server_nzone_api/getCustomerOtpAgain'),
        headers: headers,
        body: json.encode({
          "app_id": "nzone_4457Was555@qsd_job",
          "username": widget.email,
        }));
    log('hhhhhhhaaaahhhhhhhhhhhh');
    setState(() {
      var res = jsonDecode(response.body.toString());
      log(res.toString());

      log(res['status']);
      resp = res['status'];
      msg = res['msg'];

      isLoading = false;
    });

    if (resp == '1') {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
    }
    if (resp == '3') {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
    }
    if (resp == '4') {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
    }
    if (resp == '5') {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
    }
  }

  enterOtp() async {
    setState(() {
      isLoading = true;
    });
    isLoading
        ? showDialog(
            context: context,
            builder: (context) {
              return Center(
                child: SizedBox(
                    height: 100,
                    width: 100,
                    child: CircularProgressIndicator(
                      color: red,
                    )),
              );
            },
          )
        : null;

    var headers = {'Content-Type': 'application/json'};

    // request.headers.addAll(headers);
    var response = await http.post(
        Uri.parse(
            'https://pitaratajobs.novasoft.lk/_app_remove_server/nzone_server_nzone_api/verifyMyMobileCustomer'),
        headers: headers,
        body: json.encode({
          "app_id": "nzone_4457Was555@qsd_job",
          "username": widget.email,
          "otp": code.text
        }));
    log('hhhhhhhaaaahhhhhhhhhhhh');
    setState(() {
      var res = jsonDecode(response.body.toString());
      log(res.toString());

      log(res['status']);
      resp = res['status'];
      msg = res['msg'];

      isLoading = false;
      Navigator.pop(context);
    });

    if (resp == '1') {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Start(
                    text:
                        " Your account created\n successfully! \n Now you can login to your\n account! .",
                  )));
      MotionToast.info(description: Text(msg)).show(context);
    } else {
      MotionToast.error(description: Text(msg)).show(context);
    }
  }

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
                          fontSize: 20.sp,
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
                      text: " We just sent an OTP to \n ${widget.email}.",
                      fontSize: 17.sp,
                      fontFamily: 'Viga'),
                  SizedBox(
                    height: 10,
                  ),
                  CustomText(
                      fontWeight: FontWeight.w200,
                      color: Colors.white54,
                      text:
                          " Check your emails get the verification \ncode of your account",
                      fontSize: 14.sp,
                      fontFamily: 'Comfortaa-VariableFont_wght'),
                  SizedBox(
                    child: CustomTextField(
                      icon: Icons.verified_user_rounded,
                      keyInput: TextInputType.number,
                      controller: code,
                      hintText: 'enter the verfication code',
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        resendOtp();
                      },
                      child: CustomText(
                          text: 'Resend OTP',
                          fontSize: 13.sp,
                          fontFamily: 'Viga',
                          color: Colors.white60,
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextButton(
                    style: ButtonStyle(
                        animationDuration: Duration(milliseconds: 1000)),
                    onPressed: () {
                      if (code.text.isNotEmpty) {
                        enterOtp();
                      } else {
                        MotionToast.error(
                                description: Text(
                                    ' You must enter OTP to create a new account '))
                            .show(context);
                      }
                    },
                    child: RadiusButton(
                      color: font_green,
                      colortext: white,
                      text: 'VERIFY MY ACCOUNT',
                      width: 230,
                      height: 8.h,
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                ],
              ),
              Positioned(
                bottom: 2,
                left: 0,
                right: 0,
                child: Padding(
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
                                    fontSize: 10.sp,
                                    color: font_green,
                                    fontFamily: 'Comfortaa-VariableFont_wght'),
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
                                      fontSize: 10.sp,
                                      color: font_green,
                                      fontFamily: 'Comfortaa-VariableFont_wght',
                                      decoration: TextDecoration.underline),
                                ),
                              )
                            ],
                          ))),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
