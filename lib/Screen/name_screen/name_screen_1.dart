import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:lottie/lottie.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:pitarata_job/Screen/name_screen/name_screen_2.dart';
import 'package:pitarata_job/color/colors.dart';
import 'package:pitarata_job/widget/custom_text.dart';
import 'package:pitarata_job/widget/custom_text_field.dart';
import 'package:pitarata_job/widget/radius_button.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

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
  bool isLoading = false;
  bool _pasword = true;
  bool _pasword2 = true;
  String resp = '';
  String msg = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  loding() {
    setState(() {
      isLoading = false;
    });
  }

  register() async {
    setState(() {
      isLoading = true;
    });

    var headers = {'Content-Type': 'application/json'};

    // request.headers.addAll(headers);
    var response = await http.post(
        Uri.parse(
            'https://pitaratajobs.novasoft.lk/_app_remove_server/nzone_server_nzone_api/registerCustomer'),
        headers: headers,
        body: json.encode({
          "app_id": "nzone_4457Was555@qsd_job",
          "password": password.text.toString(),
          "notification_key": confirmPassword.text.toString(),
          "name": name.text.toString(),
          "mobile_number": mobile.text.toString(),
          "email": email.text.toString()
        }));

    setState(() {
      var res = jsonDecode(response.body.toString());

      resp = res['resultStatus'];
      msg = res['msg'];

      isLoading = false;
    });
    if (resp == 'SUCCESSFUL') {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => NameScreenTwo(
                    email: email.text,
                  )));

      MotionToast.info(description: Text(msg)).show(context);
    }
    if (resp == 'FAIL') {
      MotionToast.error(description: Text(msg)).show(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black,
      body: InkWell(
        onTap: () {
          log(isLoading.toString());
        },
        child: AbsorbPointer(
          absorbing: isLoading,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: SingleChildScrollView(
                child: Stack(
                  children: [
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
                                fontSize: 20.sp,
                                fontFamily: 'Viga'),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical:
                                  MediaQuery.of(context).size.height / 200,
                              horizontal:
                                  MediaQuery.of(context).size.width / 10),
                          child: Lottie.asset('assets/create_new_account.json'),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: SizedBox(
                            child: Form(
                              child: CustomTextField(
                                icon: Icons.person,
                                keyInput: TextInputType.text,
                                controller: name,
                                hintText: 'enter your name',
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: SizedBox(
                            child: Form(
                              child: CustomTextField(
                                icon: Icons.phone,
                                keyInput: TextInputType.number,
                                controller: mobile,
                                hintText: 'enter your mobile number',
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: SizedBox(
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
                        ),
                        SizedBox(
                          height: 5,
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
                                hintStyle: TextStyle(color: Colors.grey[600]),
                                hintText: 'password',
                                fillColor: light_dark),
                          ),
                        ),
                        SizedBox(
                          height: 5,
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
                                  Icons.key,
                                  color: background_green,
                                ),
                                suffixIcon: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 0, 4, 0),
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
                        Container(
                          height: 8.h,
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
                                  (states) =>
                                      BorderSide(width: 2.0, color: font_green),
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
                                        fontSize: 9.sp,
                                        color: font_green,
                                        fontFamily:
                                            'Comfortaa-VariableFont_wght'),
                                  ),
                                  InkWell(
                                    onTap: () async {
                                      var url = Uri.parse(
                                          "https://pitaratajobs.novasoft.lk/privacy_policy.php");
                                      if (await canLaunchUrl(url)) {
                                        await launchUrl(url);
                                      } else {
                                        throw 'Could not launch $url';
                                      }
                                    },
                                    child: Text(
                                      "Terms & Condition ",
                                      style: TextStyle(
                                          decoration: TextDecoration.underline,
                                          fontSize: 9.sp,
                                          color: font_green,
                                          fontFamily:
                                              'Comfortaa-VariableFont_wght'),
                                    ),
                                  ),
                                  Text(
                                    "and ",
                                    style: TextStyle(
                                        fontSize: 9.sp,
                                        color: font_green,
                                        fontFamily:
                                            'Comfortaa-VariableFont_wght'),
                                  ),
                                  InkWell(
                                    onTap: () async {
                                      var url = Uri.parse(
                                          "https://pitaratajobs.novasoft.lk/privacy_policy.php");
                                      if (await canLaunchUrl(url)) {
                                        await launchUrl(url);
                                      } else {
                                        throw 'Could not launch $url';
                                      }
                                    },
                                    child: Text(
                                      "Privacy Policy",
                                      style: TextStyle(
                                          decoration: TextDecoration.underline,
                                          fontSize: 9.sp,
                                          color: font_green,
                                          fontFamily:
                                              'Comfortaa-VariableFont_wght'),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: RadiusButton(onTap: () {
                            if (name.text.isNotEmpty) {
                              if (email.text.contains("@") &&
                                  email.text.contains(".")) {
                                if (email.text.isNotEmpty) {
                                  if (password.text.isNotEmpty) {
                                    if (confirmPassword.text.isNotEmpty) {
                                      if (password.text ==
                                          confirmPassword.text) {
                                        if (checkBox == true) {
                                          log('ddddd');
                                          register();
                                        } else {
                                          MotionToast.error(
                                                  description: Text(
                                                      "You must read and agree to our Terms & Conditions before creating a new account!"))
                                              .show(context);
                                        }
                                      } else {
                                        confirmPassword.clear();
                                        MotionToast.error(
                                                description: Text(
                                                    "Your passwords are not matching"))
                                            .show(context);
                                      }
                                    } else {
                                      MotionToast.error(
                                              description: Text(
                                                  "Please confirm your password!"))
                                          .show(context);
                                    }
                                  } else {
                                    MotionToast.error(
                                            description: Text(
                                                "Please enter your new password!"))
                                        .show(context);
                                  }
                                } else {
                                  MotionToast.error(
                                          description: Text(
                                              "Please enter your email address!"))
                                      .show(context);
                                }
                              } else {
                                MotionToast.error(
                                        description: Text(
                                            "Please enter the valid email!"))
                                    .show(context);
                              }
                            } else {
                              MotionToast.error(
                                      description:
                                          Text(" Please enter your name!"))
                                  .show(context);
                            }
                          },
                            color: font_green,
                            colortext: white,
                            text: 'CREATE MY ACCOUNT',
                            width: 230,
                            height: 8.h,
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "I already have an account.",
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
                                                      NameScreen()),
                                            );
                                          },
                                          child: Text(
                                            "Login to my account",
                                            style: TextStyle(
                                                fontSize: 9.sp,
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
                        SizedBox(
                          height: 25,
                        )
                      ],
                    ),
                    isLoading
                        ? Positioned(
                            bottom: 0,
                            top: 0,
                            right: 0,
                            left: 0,
                            child: Center(
                                child: CircularProgressIndicator(
                              color: red,
                            )))
                        : Container()
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
