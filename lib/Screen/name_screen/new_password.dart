import 'dart:convert';
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
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;
import '../start/start.dart';
import 'name_screen_1.dart';

class NewPassword extends StatefulWidget {
  const NewPassword({super.key, required this.loading, required this.cId});
  final Function loading;
  final String cId;

  @override
  State<NewPassword> createState() => _NewPasswordState();
}

class _NewPasswordState extends State<NewPassword> {
  TextEditingController name = TextEditingController();
  TextEditingController otp = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  bool isLoading = false;
  var resp;
  var msg;

  NewPassword() async {
    setState(() {
      isLoading = true;
    });

    var headers = {'Content-Type': 'application/json'};

    // request.headers.addAll(headers);
    var response = await http.post(
        Uri.parse(
            'https://pitaratajobs.novasoft.lk/_app_remove_server/nzone_server_nzone_api/customerResetPassword'),
        headers: headers,
        body: json.encode({
          "app_id": "nzone_4457Was555@qsd_job",
          "username": email.text.toString(),
          "customer_id": widget.cId,
          "word_1": password.text.toString(),
          "word_2": confirmPassword.text,
          "otp": otp.text.toString(),
        }));

    var res = jsonDecode(response.body.toString());
    log(res.toString());

    log(res['msg']);
    var resp = res['status'];
    var msg = res['msg'];
    log(resp);
    isLoading = false;

    if (resp.toString().isNotEmpty) {
      if (resp == '1') {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Start(
                      text:
                          " Your Password change\n successfully! \n Now you can login to your\n account! .",
                    )));
      }
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return widget.loading();
      },
      child: Scaffold(
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
                          text: 'Change Your Password',
                          fontSize: 20.sp,
                          fontFamily: 'Viga'),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: MediaQuery.of(context).size.width / 5.w),
                      child: Container(
                          width: 20.h,
                          child: Image.asset(
                            'assets/reset.png',
                            fit: BoxFit.fill,
                          )),
                    ),
                    SizedBox(
                      height: 70,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Form(
                          autovalidateMode: AutovalidateMode.always,
                          child: CustomTextField(
                            icon: Icons.email,
                            keyInput: TextInputType.emailAddress,
                            hintText: 'email',
                            controller: email,
                          )),
                    ),
                    SizedBox(
                      height: 10,
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
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: CustomTextField(
                        icon: Icons.password,
                        keyInput: TextInputType.visiblePassword,
                        controller: confirmPassword,
                        hintText: 'confirm password',
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: CustomTextField(
                        icon: Icons.verified_user_rounded,
                        keyInput: TextInputType.visiblePassword,
                        controller: otp,
                        hintText: 'OTP',
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: InkWell(
                          onTap: () {
                            if (otp.text.isNotEmpty &&
                                email.text.isNotEmpty &&
                                password.text.isNotEmpty) {
                              if (email.text.contains("@") &&
                                  email.text.contains(".")) {
                                if (password.text == confirmPassword.text) {
                                  NewPassword();
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content:
                                              Text("password incorrect ")));
                                }
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text("enter valid email ")),
                                );
                              }
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text("required fill all ")),
                              );
                            }
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: RadiusButton(
                              color: font_green,
                              colortext: white,
                              text: 'Change Password',
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
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
      ),
    );
  }
}
