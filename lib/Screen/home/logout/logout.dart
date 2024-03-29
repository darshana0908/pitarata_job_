import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:pitarata_job/Screen/name_screen/name_screen.dart';
import 'package:pitarata_job/color/colors.dart';
import 'package:pitarata_job/widget/arrow_button.dart';
import 'package:pitarata_job/widget/custom_text.dart';
import 'package:pitarata_job/widget/radius_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

class Logout extends StatefulWidget {
  const Logout({super.key});

  @override
  State<Logout> createState() => _LogoutState();
}

class _LogoutState extends State<Logout> {
  @override
  void initState() {
    logoutDialog();
    // TODO: implement initState
    super.initState();
  }

  logoutDialog() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      return await showDialog(
          context: context,
          builder: (context) {
            var h = MediaQuery.of(context).size.height;
            return AlertDialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15.0))),
              contentPadding: EdgeInsets.only(top: 10.0),
              backgroundColor: black,
              content: Container(
                height: 300,
                width: double.infinity,
                decoration: BoxDecoration(color: black, borderRadius: BorderRadius.circular(15)),
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.topRight,
                      child: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            Icons.close,
                            color: Colors.white70,
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomText(
                          text: 'Are you sure you want to Logout?',
                          fontSize: 17.sp,
                          fontFamily: 'Comfortaa-VariableFont_wght',
                          color: white,
                          fontWeight: FontWeight.normal),
                    ),
                    SizedBox(
                      height: 35,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        RadiusButton(
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.pop(context);
                          },
                          colortext: black,
                          color: Colors.white60,
                          height: h / 15,
                          width: 30.w,
                          text: 'NO',
                        ),
                        RadiusButton(
                          onTap: () async {
                            SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                            var z = await sharedPreferences.setString('verification', '0');
                            print(z);
                            Navigator.pushAndRemoveUntil(
                                context, MaterialPageRoute(builder: (_) => const NameScreen()), (Route<dynamic> route) => false);
                          },
                          colortext: black,
                          color: font_green,
                          height: h / 15,
                          width: 30.w,
                          text: 'YES',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey,
        body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          ArrowButton(
              onTap: () {
                Navigator.pop(context);
              },
              icons: Icons.arrow_back_ios_new),
        ]),
      ),
    );
  }

// --- Button Widget --- //
}
