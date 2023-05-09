import 'package:flutter/material.dart';
import 'package:pitarata_job/color/colors.dart';
import 'package:pitarata_job/widget/arrow_button.dart';
import 'package:pitarata_job/widget/custom_text.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black,
      body: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            height: MediaQuery.of(context).size.height / 3,
            width: double.infinity,
            child: Stack(
              children: [
                Positioned(
                  child: Container(
                      foregroundDecoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.black,
                            Colors.transparent,
                          ],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          stops: [0, 0.9],
                        ),
                      ),
                      height: MediaQuery.of(context).size.height / 3,
                      width: double.infinity,
                      child: Image.asset(
                        'assets/im.png',
                        fit: BoxFit.fitWidth,
                      )),
                ),
                Positioned(
                  top: 8,
                  left: 0,
                  right: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child:
                                ArrowButton(icons: Icons.arrow_back_ios_new)),
                        CustomText(
                            text: 'My Profile',
                            fontSize: 30,
                            fontFamily: 'Comfortaa-VariableFont_wght',
                            color: white,
                            fontWeight: FontWeight.normal)
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                            text: 'Alexia Thomas',
                            fontSize: 30,
                            fontFamily: 'Comfortaa-VariableFont_wght',
                            color: white,
                            fontWeight: FontWeight.normal),
                        CustomText(
                            text: 'Username:info@novatechzone.com',
                            fontSize: 15,
                            fontFamily: 'Comfortaa-VariableFont_wght',
                            color: white,
                            fontWeight: FontWeight.normal),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                    text: 'Mobile Number',
                    fontSize: 15,
                    fontFamily: 'Comfortaa-VariableFont_wght',
                    color: Colors.white70,
                    fontWeight: FontWeight.normal),
                SizedBox(
                  height: 10,
                ),
                CustomText(
                    text: '+94710123456',
                    fontSize: 20,
                    fontFamily: 'Comfortaa-VariableFont_wght',
                    color: white,
                    fontWeight: FontWeight.normal),
                SizedBox(
                  height: 15,
                ),
                CustomText(
                    text: 'Mobile Number 2',
                    fontSize: 15,
                    fontFamily: 'Comfortaa-VariableFont_wght',
                    color: Colors.white70,
                    fontWeight: FontWeight.normal),
                SizedBox(
                  height: 10,
                ),
                CustomText(
                    text: '+94710123456',
                    fontSize: 20,
                    fontFamily: 'Comfortaa-VariableFont_wght',
                    color: white,
                    fontWeight: FontWeight.normal),
                SizedBox(
                  height: 15,
                ),
                CustomText(
                    text: 'Gender',
                    fontSize: 15,
                    fontFamily: 'Comfortaa-VariableFont_wght',
                    color: Colors.white70,
                    fontWeight: FontWeight.normal),
                SizedBox(
                  height: 10,
                ),
                CustomText(
                    text: 'Female',
                    fontSize: 20,
                    fontFamily: 'Comfortaa-VariableFont_wght',
                    color: white,
                    fontWeight: FontWeight.normal),
                SizedBox(
                  height: 15,
                ),
                CustomText(
                    text: 'Birthday',
                    fontSize: 15,
                    fontFamily: 'Comfortaa-VariableFont_wght',
                    color: Colors.white70,
                    fontWeight: FontWeight.normal),
                SizedBox(
                  height: 10,
                ),
                CustomText(
                    text: '2018-01-01',
                    fontSize: 20,
                    fontFamily: 'Comfortaa-VariableFont_wght',
                    color: white,
                    fontWeight: FontWeight.normal),
                SizedBox(
                  height: 15,
                ),
                CustomText(
                    text: 'Country',
                    fontSize: 15,
                    fontFamily: 'Comfortaa-VariableFont_wght',
                    color: Colors.white70,
                    fontWeight: FontWeight.normal),
                SizedBox(
                  height: 10,
                ),
                CustomText(
                    text: 'Sri Lanka',
                    fontSize: 20,
                    fontFamily: 'Comfortaa-VariableFont_wght',
                    color: white,
                    fontWeight: FontWeight.normal),
                SizedBox(
                  height: 15,
                ),
                CustomText(
                    text: 'Address',
                    fontSize: 15,
                    fontFamily: 'Comfortaa-VariableFont_wght',
                    color: Colors.white70,
                    fontWeight: FontWeight.normal),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'No 221, High Level Road, Sri lanka',
                  style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'Comfortaa-VariableFont_wght',
                      color: white,
                      fontWeight: FontWeight.normal),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  alignment: Alignment.center,
                  height: 60,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: font_green,
                      borderRadius: BorderRadius.circular(25)),
                  child: CustomText(
                      text: 'Update Profile',
                      fontSize: 20,
                      fontFamily: 'Comfortaa-VariableFont_wght',
                      color: white,
                      fontWeight: FontWeight.normal),
                )
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
