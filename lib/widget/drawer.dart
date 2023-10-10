import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:pitarata_job/Screen/favorite/favorite.dart';
import 'package:pitarata_job/Screen/home/about_us/single.php.dart';
import 'package:pitarata_job/Screen/home/contact_us/contact_us.dart';
import 'package:pitarata_job/Screen/home/get_support/get_support.dart';
import 'package:pitarata_job/Screen/home/logout/logout.dart';
import 'package:pitarata_job/Screen/profile/profile.dart';
import 'package:pitarata_job/Screen/name_screen/name_screen.dart';
import 'package:pitarata_job/color/colors.dart';
import 'package:pitarata_job/widget/arrow_button.dart';
import 'package:pitarata_job/widget/custom_text.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import '../Screen/home/more_by_team/more_by_team.dart';
import '../Screen/home/whatApp_community/whatsApp_community.dart';
import 'drawer_row.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key, required this.loging});
  final bool loging;

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  bool isLoading = false;
  bool tap = false;
  getWallpaper() async {
    setState(() {
      isLoading = true;
    });

    var headers = {'Content-Type': 'application/json'};

    // request.headers.addAll(headers);
    var response = await http.post(Uri.parse('https://pitaratajobs.novasoft.lk/_app_remove_server/nzone_server_nzone_api/reportThisJob'),
        headers: headers, body: json.encode({"app_id": "nzone_4457Was555@qsd_job"}));
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
                ArrowButton(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    icons: Icons.arrow_back_ios),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(borderRadius: BorderRadius.circular(10), child: Image.asset('assets/menu_icon.png')),
                      SizedBox(
                        height: 20,
                      ),
                      CustomText(
                          text: 'SETTINGS', fontSize: 12, fontFamily: 'Comfortaa-VariableFont_wght', color: white, fontWeight: FontWeight.normal),
                      SizedBox(
                        height: 15,
                      ),
                      DrawerRow(
                          icon: Icons.book,
                          text: 'My CV',
                          on: () {
                            MotionToast.info(title: Text("Info"), description: Text("This option will be enabled soon!")).show(context);
                          }),
                      SizedBox(
                        height: 10,
                      ),
                      DrawerRow(
                          icon: Icons.support_agent_rounded,
                          text: 'Get Support',
                          on: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => GetSupport()));
                          }),
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      CustomText(
                          text: 'SUPPORT US', fontSize: 12, fontFamily: 'Comfortaa-VariableFont_wght', color: white, fontWeight: FontWeight.normal),
                      SizedBox(
                        height: 15,
                      ),
                      DrawerRow(
                          icon: Icons.share,
                          text: 'Share this app',
                          on: () {
                            Share.share(
                                'Hey, I found this amazing Pita Rata Jobs App. Check this out.\n Download app now - https://shorturl.at/jwHPQ \n PitaRata Jobs App');
                          }),
                      SizedBox(
                        height: 10,
                      ),
                      DrawerRow(
                          icon: Icons.more,
                          text: 'More by our team',
                          on: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => MoreByTeam()));
                          }),
                      SizedBox(
                        height: 10,
                      ),
                      DrawerRow(
                          icon: Icons.reviews,
                          text: 'Leave us a Review',
                          on: () {
                            final InAppReview inAppReview = InAppReview.instance;

                            inAppReview.openStoreListing(appStoreId: '1111111', microsoftStoreId: '...');
                          }),
                      SizedBox(
                        height: 15,
                      ),
                      CustomText(text: 'OTHER', fontSize: 12, fontFamily: 'Comfortaa-VariableFont_wght', color: white, fontWeight: FontWeight.normal),
                      SizedBox(
                        height: 15,
                      ),
                      DrawerRow(
                          icon: Icons.messenger,
                          text: 'Join Community',
                          on: () async {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => WhatsAppCommunity()));
                          }),
                      SizedBox(
                        height: 10,
                      ),
                      DrawerRow(
                          icon: Icons.privacy_tip,
                          text: 'Privacy Policy',
                          on: () async {
                            var url = Uri.parse("https://pitaratajobs.novasoft.lk/privacy_policy.php");
                            if (await canLaunchUrl(url)) {
                              await launchUrl(url);
                            } else {
                              throw 'Could not launch $url';
                            }
                          }),
                      SizedBox(
                        height: 10,
                      ),
                      DrawerRow(
                          icon: Icons.contact_phone_rounded,
                          text: 'Contact us',
                          on: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => ContactUs()));
                          }),
                      SizedBox(
                        height: 10,
                      ),
                      DrawerRow(
                          icon: Icons.accessibility_new_sharp,
                          text: 'About Us',
                          on: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AboutUs(
                                          id: '1',
                                        )));
                          }),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: TextButton(
                    style: ButtonStyle(
                      animationDuration: Duration(milliseconds: 2000),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
                      ),
                    ),
                    onPressed: () {
                      log('hhhh');
                      if (widget.loging == true) {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Logout()));
                      } else {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => NameScreen()));
                      }
                    },
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 200),
                      alignment: Alignment.center,
                      height: 30,
                      width: 150,
                      decoration: BoxDecoration(
                          border: Border.all(color: tap ? black : Colors.transparent, width: 0),
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
