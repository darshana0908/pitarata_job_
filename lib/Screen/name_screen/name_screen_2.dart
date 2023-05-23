import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:pitarata_job/Screen/start/start.dart';
import 'package:pitarata_job/color/colors.dart';
import 'package:pitarata_job/widget/custom_text.dart';
import 'package:pitarata_job/widget/custom_text_field.dart';
import 'package:pitarata_job/widget/radius_button.dart';
import 'package:http/http.dart' as http;
import 'name_screen.dart';

class NameScreenTwo extends StatefulWidget {
  const NameScreenTwo(
      {super.key,
      required this.email,
      required this.phone,
      required this.loading});
  final String email;
  final String phone;
  final Function loading;

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
    });

    if (resp == '1') {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Start(
                    text:
                        " Your account created\n successfully! \n Now you can login to your\n account! .",
                  )));
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
    }
    if (resp == '4') {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
    }
    if (resp == '6') {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
    }
    if (resp == '7') {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.pop(context);
        return widget.loading();
      },
      child: Scaffold(
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
                        text: " We just sent an OTP to \n ${widget.email}.",
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
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CustomTextField(
                        icon: Icons.verified_user_rounded,
                        keyInput: TextInputType.number,
                        controller: code,
                        hintText: 'enter the verfication code',
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {
                            resendOtp();
                          },
                          child: CustomText(
                              text: 'Resend OTP',
                              fontSize: 17,
                              fontFamily: 'Viga',
                              color: Colors.white60,
                              fontWeight: FontWeight.normal),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      InkWell(
                        onTap: () {
                          if (code.text.isNotEmpty) {
                            enterOtp();
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(
                                    ' You must enter OTP to create a new account ')));
                          }

                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(builder: (context) => Start()),
                          // );
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
      ),
    );
  }
}
