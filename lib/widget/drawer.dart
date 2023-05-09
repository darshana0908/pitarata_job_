import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:pitarata_job/Screen/favorite/favorite.dart';
import 'package:pitarata_job/Screen/home/get_support/get_support.dart';
import 'package:pitarata_job/Screen/home/logout/logout.dart';
import 'package:pitarata_job/Screen/home/profile/profile.dart';
import 'package:pitarata_job/color/colors.dart';
import 'package:pitarata_job/widget/arrow_button.dart';
import 'package:pitarata_job/widget/custom_text.dart';

import 'drawer_row.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
          backgroundColor: black,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: ArrowButton(icons: Icons.arrow_back_ios)),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset('assets/Menu.jpg')),
                      SizedBox(
                        height: 20,
                      ),
                      CustomText(
                          text: 'SETTINGS',
                          fontSize: 12,
                          fontFamily: 'Comfortaa-VariableFont_wght',
                          color: white,
                          fontWeight: FontWeight.normal),
                      SizedBox(
                        height: 15,
                      ),
                      DrawerRow(text: 'My CV', on: () {}),
                      Divider(color: Colors.white38),
                      DrawerRow(
                          text: 'Get Support',
                          on: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => GetSupport()));
                          }),
                      Divider(color: Colors.white38),
                      SizedBox(
                        height: 15,
                      ),
                      CustomText(
                          text: 'SUPPORT US',
                          fontSize: 12,
                          fontFamily: 'Comfortaa-VariableFont_wght',
                          color: white,
                          fontWeight: FontWeight.normal),
                      SizedBox(
                        height: 15,
                      ),
                      DrawerRow(text: 'Share this app', on: () {}),
                      Divider(color: Colors.white38),
                      DrawerRow(text: 'More by our team', on: () {}),
                      Divider(color: Colors.white38),
                      DrawerRow(text: 'Donate us', on: () {}),
                      Divider(color: Colors.white38),
                      DrawerRow(text: 'Leave us a Review', on: () {}),
                      Divider(color: Colors.white38),
                      SizedBox(
                        height: 15,
                      ),
                      CustomText(
                          text: 'OTHER',
                          fontSize: 12,
                          fontFamily: 'Comfortaa-VariableFont_wght',
                          color: white,
                          fontWeight: FontWeight.normal),
                      SizedBox(
                        height: 15,
                      ),
                      DrawerRow(text: 'Privacy Policy', on: () {}),
                      Divider(color: Colors.white38),
                      DrawerRow(text: 'Term and Conditions', on: () {}),
                      Divider(color: Colors.white38),
                      DrawerRow(text: 'Help', on: () {}),
                      Divider(color: Colors.white38),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Logout()));
                  },
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      alignment: Alignment.center,
                      height: 30,
                      width: 150,
                      decoration: BoxDecoration(
                          color: red, borderRadius: BorderRadius.circular(10)),
                      child: CustomText(
                          text: 'Logout',
                          fontSize: 12,
                          fontFamily: 'Comfortaa-VariableFont_wght',
                          color: white,
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
