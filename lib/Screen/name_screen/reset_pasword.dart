import 'dart:convert';
import 'dart:developer';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:lottie/lottie.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:pitarata_job/Screen/home/home.dart';
import 'package:pitarata_job/color/colors.dart';
import 'package:pitarata_job/widget/custom_text.dart';
import 'package:pitarata_job/widget/custom_text_field.dart';
import 'package:pitarata_job/widget/radius_button.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;
import '../../api/api_deatails.dart';
import 'name_screen_1.dart';
import 'new_password.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final TextEditingController email = TextEditingController();
  bool isLoading = false;
  var resp;
  var msg;

  loading() {
    log('fffffffffffffffffffffffffff');
    setState(() {
      isLoading = false;
    });
  }

  resetPassword() async {
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
                      )));
            },
          )
        : null;
    var headers = {'Content-Type': 'application/json'};

    // request.headers.addAll(headers);
    var response = await http.post(
        Uri.parse(
            '$apiUrl/customerRequestPasswordReset'),
        headers: headers,
        body: json.encode({
          "app_id": "nzone_4457Was555@qsd_job",
          "username": email.text.toString()
        }));

    var res = jsonDecode(response.body.toString());
    log(res.toString());

    log(res['msg']);
    var resp = res['status'];
    var msg = res['msg'];
    log(resp);

    setState(() {
      isLoading = false;
    });

    if (resp == '1') {
      log(res['data']['cid'].toString());
      String cid = res['data']['cid'].toString();
      Navigator.pop(context);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => NewPassword(
                    email: email.text,
                    cId: cid,
                    loading: loading,
                  )));
    } else {
      Navigator.pop(context);
      MotionToast.error(description: Text(msg)).show(context);
    }
  }

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
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 100.h,
              child: Column(
                children: [
                  SizedBox(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 1.h),
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
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4, bottom: 30),
                    child: CustomText(
                        fontWeight: FontWeight.normal,
                        color: white,
                        text: 'Reset Your Password',
                        fontSize: 20.sp,
                        fontFamily: 'Viga'),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: 20,
                        horizontal: MediaQuery.of(context).size.width / 5.w),
                    child: Container(
                        width: 30.h,
                        child: Image.asset(
                          'assets/reset.png',
                          fit: BoxFit.fill,
                        )),
                  ),
                  SizedBox(
                    height: 100,
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
                  Expanded(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: RadiusButton(onTap: () {
                        log(email.text.toString());

                        if (email.text.isNotEmpty) {
                          if (email.text.contains("@") &&
                              email.text.contains(".")) {
                            resetPassword();
                          } else {
                            MotionToast.error(
                                    description: Text(
                                        "Please enter valid email address"))
                                .show(context);
                          }
                        } else {
                          MotionToast.error(
                                  description:
                                      Text("Please enter your email address"))
                              .show(context);
                        }
                      }, 
                          color: font_green,
                          colortext: white,
                          text: 'Send OTP',
                          width: 200,
                          height: 60,
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
                                        // Navigator.push(
                                        //   context,
                                        //   MaterialPageRoute(
                                        //       builder: (context) =>
                                        //           ),
                                        // );
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
