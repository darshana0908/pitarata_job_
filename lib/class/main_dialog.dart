import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../Screen/name_screen/name_screen.dart';
import '../color/colors.dart';
import '../widget/custom_text.dart';
import '../widget/radius_button.dart';

showCustomDialog(BuildContext context, String text) async {
  return await showDialog(
      context: context,
      builder: (context) {
        var h = MediaQuery.of(context).size.height;
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          contentPadding: EdgeInsets.only(top: 10.0),
          backgroundColor: black,
          content: Container(
            height: 300,
            width: double.infinity,
            decoration: BoxDecoration(
                color: black, borderRadius: BorderRadius.circular(10)),
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
                      fontSize: 20,
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
                      },
                      colortext: black,
                      color: Colors.white60,
                      height: h / 15,
                      width: 32.w,
                      text: 'Cancel',
                    ),
                    RadiusButton(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => NameScreen()),
                        );
                      },
                      colortext: black,
                      color: font_green,
                      height: h / 15,
                      width: 32.w,
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
