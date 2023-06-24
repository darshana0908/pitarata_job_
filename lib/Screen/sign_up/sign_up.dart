import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:lottie/lottie.dart';
import 'package:pitarata_job/Screen/home/home.dart';
import 'package:pitarata_job/Screen/name_screen/name_screen.dart';

import 'package:pitarata_job/widget/custom_text.dart';
import 'package:provider/provider.dart';

import 'package:sizer/sizer.dart';

import '../../color/colors.dart';
import '../../helper/google_signin_helper.dart';
import '../../providers/google_sign_provider.dart';

import '../../widget/sign_up_button.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final email = TextEditingController();
  final TextEditingController password = TextEditingController();
  bool isLoading = false;
  var resp;
  var msg;
  String verification = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
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
                            ),
                            Container(
                              height: 45.h,
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal:
                                        MediaQuery.of(context).size.width /
                                            5.w),
                                child: Container(
                                    child: Lottie.asset(
                                  'assets/select_login_type.json',
                                  fit: BoxFit.fill,
                                )),
                              ),
                            ),
                            CustomText(
                              color: white,
                              fontWeight: FontWeight.w300,
                              fontFamily: 'Comfortaa',
                              fontSize: 13.sp,
                              text:
                                  "Use your email or another service to continue with Pita Rata Jobs.",
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("It's FREE !",
                                  style: TextStyle(
                                    letterSpacing: 1,
                                    color: white,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Comfortaa',
                                    fontSize: 13.sp,
                                  )),
                            ),
                          ],
                        ),
                        Positioned(
                          left: 0,
                          bottom: 0,
                          right: 0,
                          child: Column(
                            children: [
                              SizedBox(
                                height: 5,
                              ),
                              SignUpButton(
                                  icon: 'assets/icons8-google-48.png',
                                  text: "Continue with Google",
                                  color: font_green,
                                  colortext: white,
                                  height: 6.h,
                                  onTap: () {
                                    signInWithGoogle(context: context);

                                    final provider =
                                        Provider.of<GoogleSignInProvider>(
                                            context,
                                            listen: false);
                                    provider.googleLogin().whenComplete(() {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const GmailLogin()));
                                      print(FirebaseAuth.instance.currentUser);
                                    });
                                  },
                                  width: w),
                              SignUpButton(
                                  icon: 'assets/icons8-email-48.png',
                                  text: "Continue with Email",
                                  color: font_green,
                                  colortext: white,
                                  height: 6.h,
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => NameScreen()),
                                    );
                                  },
                                  width: w),
                              Container(
                                  alignment: Alignment.center,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "By continuing,you agree",
                                            style: TextStyle(
                                                fontSize: 9.sp,
                                                color: font_green,
                                                fontFamily: 'Comfortaa'),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              // Navigator.push(
                                              //   context,
                                              //   MaterialPageRoute(
                                              //       builder: (context) =>
                                              //           SignUpOne()),
                                              // );
                                            },
                                            child: Text(
                                              "Terms & Conditions",
                                              style: TextStyle(
                                                  fontSize: 9.sp,
                                                  color: font_green,
                                                  fontFamily: 'Comfortaa',
                                                  decoration:
                                                      TextDecoration.underline),
                                            ),
                                          ),
                                          Text(
                                            "and ",
                                            style: TextStyle(
                                                fontSize: 9.sp,
                                                color: font_green,
                                                fontFamily: 'Comfortaa'),
                                          ),
                                          Text(
                                            "Privacy policy",
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                                fontSize: 9.sp,
                                                color: font_green,
                                                fontFamily: 'Comfortaa',
                                                decoration:
                                                    TextDecoration.underline),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )),
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

Future<User?> signInWithGoogle({required BuildContext context}) async {
  FirebaseAuth auth = FirebaseAuth.instance;
  User? user;

  final GoogleSignIn googleSignIn = GoogleSignIn();

  final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();

  if (googleSignInAccount != null) {
    print(user);
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    try {
      final UserCredential userCredential =
          await auth.signInWithCredential(credential);
      log(userCredential.toString());
      user = userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'account-exists-with-different-credential') {
        // handle the error here
      } else if (e.code == 'invalid-credential') {
        // handle the error here
      }
    } catch (e) {
      // handle the error here
    }
  }

  return user;
}
