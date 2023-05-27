import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:pitarata_job/Screen/favorite/favorite.dart';
import 'package:pitarata_job/Screen/home/about_us/about_us.dart';
import 'package:pitarata_job/Screen/home/contact_us/contact_us.dart';
import 'package:pitarata_job/Screen/home/get_support/get_support.dart';
import 'package:pitarata_job/Screen/home/logout/logout.dart';
import 'package:pitarata_job/Screen/home/profile/profile.dart';
import 'package:pitarata_job/Screen/name_screen/name_screen.dart';
import 'package:pitarata_job/color/colors.dart';
import 'package:pitarata_job/widget/arrow_button.dart';
import 'package:pitarata_job/widget/custom_text.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'drawer_row.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key, required this.loging});
  final bool loging;

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  bool isLoading = false;
  getWallpaper() async {
    setState(() {
      isLoading = true;
    });

    var headers = {'Content-Type': 'application/json'};

    // request.headers.addAll(headers);
    var response = await http.post(
        Uri.parse(
            'https://pitaratajobs.novasoft.lk/_app_remove_server/nzone_server_nzone_api/reportThisJob'),
        headers: headers,
        body: json.encode({"app_id": "nzone_4457Was555@qsd_job"}));
    var res = jsonDecode(response.body.toString());
    List img = res['data'];

    if (img.isNotEmpty) {
      setState(() {});
    }
  }

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
                          child: Image.asset('assets/menu_icon.png')),
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
                      DrawerRow(
                          text: 'My CV',
                          on: () {
                            MotionToast.info(
                                    title: Text("Info"),
                                    description: Text(
                                        "This option will be enabled soon!"))
                                .show(context);
                          }),
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
                      DrawerRow(
                          text: 'Share this app',
                          on: () {
                            Share.share(
                                'Hey, I found this amazing Pita Rata Jobs App. Check this out.\n Download app now - https://shorturl.at/jwHPQ \n PitaRata Jobs App');
                          }),
                      Divider(color: Colors.white38),
                      DrawerRow(text: 'More by our team', on: () {}),
                      Divider(color: Colors.white38),
                      // DrawerRow(text: 'Donate us', on: () {}),
                      Divider(color: Colors.white38),
                      DrawerRow(
                          text: 'Leave us a Review',
                          on: () {
                            final InAppReview inAppReview =
                                InAppReview.instance;

                            inAppReview.openStoreListing(
                                appStoreId: '1111111', microsoftStoreId: '...');
                          }),
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
                      DrawerRow(
                          text: 'Privacy Policy',
                          on: () async {
                            var url = Uri.parse(
                                "https://pitaratajobs.novasoft.lk/privacy_policy.php ");
                            if (await canLaunchUrl(url)) {
                              await launchUrl(url);
                            } else {
                              throw 'Could not launch $url';
                            }
                          }),
                      Divider(color: Colors.white38),
                      DrawerRow(
                          text: 'Contect us',
                          on: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ContactUs()));
                          }),
                      Divider(color: Colors.white38),
                      DrawerRow(
                          text: ' open about us screen.',
                          on: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AboutUs()));
                          }),
                      Divider(color: Colors.white38),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    if (widget.loging == true) {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Logout()));
                    } else {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => NameScreen()));
                    }
                  },
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      alignment: Alignment.center,
                      height: 30,
                      width: 150,
                      decoration: BoxDecoration(
                          color: widget.loging ? red : Colors.blue,
                          borderRadius: BorderRadius.circular(10)),
                      child: CustomText(
                          text: widget.loging ? 'Logout' : "Login",
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
