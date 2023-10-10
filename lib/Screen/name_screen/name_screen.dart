import 'dart:convert';
import 'dart:developer';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:lottie/lottie.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:pitarata_job/Screen/home/home.dart';
import 'package:pitarata_job/Screen/name_screen/reset_pasword.dart';
import 'package:pitarata_job/color/colors.dart';
import 'package:pitarata_job/widget/alert.dart';
import 'package:pitarata_job/widget/custom_text.dart';
import 'package:pitarata_job/widget/custom_text_field.dart';
import 'package:pitarata_job/widget/radius_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;
import '../../api/api_deatails.dart';
import '../../widget/otp_alert.dart';
import 'name_screen_1.dart';

class NameScreen extends StatefulWidget {
  const NameScreen({super.key});

  @override
  State<NameScreen> createState() => _NameScreenState();
}

class _NameScreenState extends State<NameScreen> {
  final email = TextEditingController();
  final TextEditingController password = TextEditingController();
  bool isLoading = false;
  var resp;
  var msg;
  String verification = '';
  bool _pasword = true;
  resetPassword() async {
    setState(() {
      isLoading = true;
    });

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
    isLoading = false;

    if (resp.toString().isNotEmpty) {
      if (resp == '1') {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => NameScreen()));
      }
      MotionToast.info(title: Text("Info"), description: Text(msg))
          .show(context);
    }
  }

  login() async {
    setState(() {
      isLoading = true;
    });

    var headers = {'Content-Type': 'application/json'};

    // request.headers.addAll(headers);
    var response = await http.post(
        Uri.parse(
            '$apiUrl/loginCustomer'),
        headers: headers,
        body: json.encode({
          "app_id": "nzone_4457Was555@qsd_job",
          "password": password.text.toString(),
          "notification_key": password.text.toString(),
          "username": email.text.toString()
        }));

    var res = jsonDecode(response.body.toString());
    log(res.toString());
    var resp = res['status'];
    var msg = res['msg'];

    setState(() {
      isLoading = false;
    });

    if (resp.toString().isNotEmpty) {
      if (resp == '1') {
        // MotionToast.info(description: Text(msg)).show(context);
        var y = res['data']['customer_id'].toString();
        verification = res['data']['verification'].toString();
        userLoginCheq(true);
        userDetails(y, verification);
        FocusManager.instance.primaryFocus?.unfocus();
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomeScreen()));
      }
      if (resp == "3") {
        otp(context, msg, email.text);
      } else {
        MotionToast.info(description: Text(msg)).show(context);
      }
    }
  }

  userLoginCheq(bool x) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setBool('userLoging', x);
  }

  userDetails(String y, String z) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('customer_id', y);
    await prefs.setString('verification', z);
  }

  userloginstatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('userLoging', true);
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
      body: AbsorbPointer(
        absorbing: isLoading,
        child: SafeArea(
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    child: Stack(
                      children: [
                        Column(
                          children: [
                            SizedBox(
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 5),
                                child: Container(
                                  alignment: Alignment.centerRight,
                                  child: TextButton(
                                      onPressed: () async {
                                        userLoginCheq(false);
                                        SharedPreferences prefs =
                                            await SharedPreferences
                                                .getInstance();
                                        await prefs.setString(
                                            'verification', '0');
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  HomeScreen()),
                                        );
                                      },
                                      child: Text(
                                        'skip',
                                        style: TextStyle(
                                            color: Colors.white70,
                                            fontSize: 15,
                                            decoration:
                                                TextDecoration.underline),
                                      )),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: CustomText(
                                  fontWeight: FontWeight.normal,
                                  color: white,
                                  text: 'Login to your account',
                                  fontSize: 20.sp,
                                  fontFamily: 'Viga'),
                            )
                          ],
                        ),
                        Positioned(
                          left: 0,
                          bottom: 0,
                          right: 0,
                          child: Column(
                            children: [
                              Container(
                                height: 45.h,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal:
                                          MediaQuery.of(context).size.width /
                                              5.w),
                                  child: Container(
                                      child: Lottie.asset(
                                    'assets/login_screen.json',
                                    fit: BoxFit.fill,
                                  )),
                                ),
                              ),
                              CustomTextField(
                                icon: Icons.email,
                                keyInput: TextInputType.emailAddress,
                                hintText: 'email',
                                controller: email,
                              ),
                              SizedBox(
                                height: 2,
                              ),
                              TextFormField(
                                obscureText: _pasword,
                                style: TextStyle(color: white, fontSize: 13.sp),
                                controller: password,
                                keyboardType: TextInputType.visiblePassword,
                                decoration: InputDecoration(
                                    counterStyle:
                                        TextStyle(color: Colors.white),
                                    prefixIcon: Icon(
                                      Icons.key,
                                      color: background_green,
                                    ),
                                    suffixIcon: Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(0, 0, 4, 0),
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
                                    hintStyle:
                                        TextStyle(color: Colors.grey[600]),
                                    hintText: 'password',
                                    fillColor: light_dark),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Align(
                                  alignment: Alignment.centerRight,
                                  child: TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ResetPassword()),
                                      );
                                    },
                                    child: CustomText(
                                      color: Colors.white54,
                                      fontWeight: FontWeight.normal,
                                      fontFamily: 'Comfortaa-VariableFont_wght',
                                      fontSize: 13,
                                      text: 'Reset my password',
                                    ),
                                  )),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 10),
                                  child: RadiusButton(
                                    onTap: () {
                                      log(email.text.toString());

                                      if (email.text.isNotEmpty) {
                                        if (email.text.contains("@") &&
                                            email.text.contains(".")) {
                                          if (password.text.isNotEmpty) {
                                            login();
                                          } else {
                                            MotionToast.error(
                                                    description: Text(
                                                        "Please enter your password"))
                                                .show(context);
                                          }
                                        } else {
                                          MotionToast.error(
                                                  description:
                                                      Text("Enter valid email"))
                                              .show(context);
                                        }
                                      } else {
                                        MotionToast.error(
                                                description: Text(
                                                    "Please enter your email address"))
                                            .show(context);
                                      }
                                    },
                                    color: font_green,
                                    colortext: white,
                                    text: 'LOGIN',
                                    width: 200,
                                    height: 7.h,
                                  ),
                                ),
                              ),
                              Container(
                                  alignment: Alignment.bottomCenter,
                                  child: Container(
                                      alignment: Alignment.center,
                                      child: SizedBox(
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "I don't have an account.",
                                              style: TextStyle(
                                                  fontSize: 9.sp,
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
                                                    fontSize: 9.sp,
                                                    color: font_green,
                                                    fontFamily:
                                                        'Comfortaa-VariableFont_wght',
                                                    decoration: TextDecoration
                                                        .underline),
                                              ),
                                            )
                                          ],
                                        ),
                                      ))),
                              SizedBox(
                                height: 20,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              isLoading
                  ? Center(
                      child: CircularProgressIndicator(
                      color: red,
                    ))
                  : Container()
            ],
          ),
        ),
      ),
    );
  }
}
