import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pitarata_job/Screen/name_screen/name_screen.dart';
import 'package:pitarata_job/widget/radius_button.dart';
import 'package:sizer/sizer.dart';

import '../color/colors.dart';
import 'custom_text.dart';

loading(BuildContext context, String text) async {
  return await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15.0))),
          contentPadding: EdgeInsets.only(top: 10.0),
          backgroundColor: black,
          content: Container(
            height: 300,
            width: double.infinity,
            decoration: BoxDecoration(
                color: black, borderRadius: BorderRadius.circular(15)),
            child: Column(
              children: [
                Container(
                  alignment: Alignment.topRight,
                  child: IconButton(
                      onPressed: () {
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
                      text: text,
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
                    RadiusButton(onTap: () {
                      Navigator.pop(context);
                    },
                      colortext: black,
                      color: white,
                      height: 70,
                      width: 30.w,
                      text: 'Cancel',
                    ),
                    RadiusButton(onTap:() {
                     Navigator.push(
            context, MaterialPageRoute(builder: (context) => NameScreen()));
                    } ,
                      colortext: black,
                      color: font_green,
                      height: 70,
                      width: 30.w,
                      text: 'Login',
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      });
}
