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
import '../start/start.dart';
import 'name_screen_1.dart';

class NewPassword extends StatefulWidget {
  const NewPassword(
      {super.key,
      required this.loading,
      required this.cId,
      required this.email});
  final Function loading;
  final String cId;
  final String email;

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
  bool _pasword = true;
  bool _pasword2 = true;

  NewPassword() async {
    setState(() {
      isLoading = true;
    });

    var headers = {'Content-Type': 'application/json'};

    // request.headers.addAll(headers);
    var response = await http.post(
        Uri.parse(
            '$apiUrl/customerResetPassword'),
        headers: headers,
        body: json.encode({
          "app_id": "nzone_4457Was555@qsd_job",
          "username": widget.email,
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
                          " Your Password changed\n successfully! \n Now you can login to your\n account! .",
                    )));
      } else {
        MotionToast.error(
                description: Text(
                    'Entered verification code is wrong. Please check your emails to get the verification code'))
            .show(context);
      }
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
                      height: MediaQuery.of(context).size.height / 20,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: 4,
                          bottom: MediaQuery.of(context).size.height / 20),
                      child: CustomText(
                          fontWeight: FontWeight.normal,
                          color: white,
                          text: 'Change Your Password',
                          fontSize: 20.sp,
                          fontFamily: 'Viga'),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: MediaQuery.of(context).size.height / 20,
                          horizontal: MediaQuery.of(context).size.width / 5.w),
                      child: Container(
                          height: 25.h,
                          child: Image.asset(
                            'assets/reset.png',
                            fit: BoxFit.fill,
                          )),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    CustomText(
                        fontWeight: FontWeight.normal,
                        color: Colors.white70,
                        text: ' Enter your new password and verification code',
                        fontSize: 20.sp,
                        fontFamily: 'Viga-Regular'),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: TextFormField(
                        obscureText: _pasword,
                        style: TextStyle(color: white, fontSize: 13.sp),
                        controller: password,
                        keyboardType: TextInputType.visiblePassword,
                        decoration: InputDecoration(
                            counterStyle: TextStyle(color: Colors.white),
                            prefixIcon: Icon(
                              Icons.key,
                              color: background_green,
                            ),
                            suffixIcon: Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 4, 0),
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _pasword = !_pasword;
                                  });
                                },
                                child: Icon(
                                  _pasword
                                      ? Icons.visibility_rounded
                                      : Icons.visibility_off_rounded,
                                  size: 24,
                                ),
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            contentPadding: EdgeInsets.all(2),
                            filled: true,
                            hintStyle: TextStyle(color: Colors.grey[600]),
                            hintText: 'new password',
                            fillColor: light_dark),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: TextFormField(
                        obscureText: _pasword2,
                        style: TextStyle(color: white, fontSize: 13.sp),
                        controller: confirmPassword,
                        keyboardType: TextInputType.visiblePassword,
                        decoration: InputDecoration(
                            counterStyle: TextStyle(color: Colors.white),
                            prefixIcon: Icon(
                              Icons.password,
                              color: background_green,
                            ),
                            suffixIcon: Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 4, 0),
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _pasword2 = !_pasword2;
                                  });
                                },
                                child: Icon(
                                  _pasword2
                                      ? Icons.visibility_rounded
                                      : Icons.visibility_off_rounded,
                                  size: 24,
                                ),
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            contentPadding: EdgeInsets.all(2),
                            filled: true,
                            hintStyle: TextStyle(color: Colors.grey[600]),
                            hintText: 'confirm password',
                            fillColor: light_dark),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: CustomTextField(
                        icon: Icons.verified_user_rounded,
                        keyInput: TextInputType.number,
                        controller: otp,
                        hintText: 'verification code',
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: RadiusButton(onTap: () {
                        if (password.text.isNotEmpty) {
                          if (confirmPassword.text.isNotEmpty) {
                            if (password.text == confirmPassword.text) {
                              if (otp.text.isNotEmpty) {
                                NewPassword();
                              } else {
                                MotionToast.error(
                                        description: Text(
                                            'Please enter your verification code!'))
                                    .show(context);
                              }
                            } else {
                              confirmPassword.clear();
                              MotionToast.error(
                                      description: Text(
                                          ' Your passwords are not matching. Please enter the password again!'))
                                  .show(context);
                            }
                          } else {
                            MotionToast.error(
                                    description:
                                        Text('Please confirm your password!'))
                                .show(context);
                          }
                        } else {
                          MotionToast.error(
                                  description:
                                      Text('Please enter your new password!'))
                              .show(context);
                        }
                      },
                          color: font_green,
                          colortext: white,
                          text: 'Change Password',
                          width: 200,
                          height: 60,
                        ),
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
