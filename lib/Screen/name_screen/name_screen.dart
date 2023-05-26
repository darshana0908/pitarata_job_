import 'dart:convert';
import 'dart:developer';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:pitarata_job/Screen/home/home.dart';
import 'package:pitarata_job/Screen/name_screen/reset_pasword.dart';
import 'package:pitarata_job/color/colors.dart';
import 'package:pitarata_job/widget/custom_text.dart';
import 'package:pitarata_job/widget/custom_text_field.dart';
import 'package:pitarata_job/widget/radius_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;
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

  resetPassword() async {
    setState(() {
      isLoading = true;
    });

    var headers = {'Content-Type': 'application/json'};

    // request.headers.addAll(headers);
    var response = await http.post(
        Uri.parse(
            'https://pitaratajobs.novasoft.lk/_app_remove_server/nzone_server_nzone_api/customerRequestPasswordReset'),
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
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
    }
  }

  login() async {
    setState(() {
      isLoading = true;
    });
    isload();
    var headers = {'Content-Type': 'application/json'};

    // request.headers.addAll(headers);
    var response = await http.post(
        Uri.parse(
            'https://pitaratajobs.novasoft.lk/_app_remove_server/nzone_server_nzone_api/loginCustomer'),
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
    log(res['status']);
    // log(res['data']['customer_id'].toString());
    // log(res['data']['verification'].toString());
    isLoading = false;
    Navigator.pop(context);

    if (resp.toString().isNotEmpty) {
      if (resp == '1') {
        var y = res['data']['customer_id'].toString();
        verification = res['data']['verification'].toString();
        userLoginCheq(true);
        userDetails(y, verification);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomeScreen()));
      }

      MotionToast.info(title: Text("Info"), description: Text(msg))
          .show(context);
    }
  }

  isload() {
    showDialog(
        // barrierDismissible: false,
        context: context,
        builder: (context) => Center(
            child: isLoading ? CircularProgressIndicator() : Container()));
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
                            onPressed: () async {
                              userLoginCheq(false);
                              SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                              await prefs.setString('verification', '0');
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
                    padding: const EdgeInsets.only(top: 4),
                    child: CustomText(
                        fontWeight: FontWeight.normal,
                        color: white,
                        text: 'Login to your account',
                        fontSize: 20.sp,
                        fontFamily: 'Viga'),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: 0.20.h,
                        horizontal: MediaQuery.of(context).size.width / 5.w),
                    child: Container(
                        width: 50.h,
                        child: Lottie.asset(
                          'assets/login_screen.json',
                          fit: BoxFit.fill,
                        )),
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
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ResetPassword()),
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
                  Expanded(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: InkWell(
                        onTap: () {
                          log(email.text.toString());

                          if (email.text.isNotEmpty) {
                            if (email.text.contains("@") &&
                                email.text.contains(".")) {
                              if (password.text.isNotEmpty) {
                                login();
                              } else {
                                MotionToast.error(
                                        title: Text("Error"),
                                        description: Text("Password required"))
                                    .show(context);
                              }
                            } else {
                              MotionToast.error(
                                      title: Text("Error"),
                                      description: Text("Enter valid email"))
                                  .show(context);
                            }
                          } else {
                            MotionToast.error(
                                    title: Text("Error"),
                                    description: Text("email  required"))
                                .show(context);
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
