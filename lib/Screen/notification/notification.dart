import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:pitarata_job/color/colors.dart';
import 'package:pitarata_job/widget/arrow_button.dart';
import 'package:pitarata_job/widget/custom_grid.dart';
import 'package:pitarata_job/widget/custom_text.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../widget/radius_button.dart';
import '../name_screen/name_screen.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  int x = 0;
  String verification = '';
  String customer_id = '';
  List notificationsList = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    userLogin();
    //
  }

  userLogin() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      var z = sharedPreferences.getString('verification');
      var y = sharedPreferences.getString('customer_id');
      setState(() {
        verification = z.toString();
        customer_id = y.toString();
      });

      log("verificatio" + verification);
      if (verification != '0') {
        setState(() {
          log('kkkkkkkkkkkkkkkkkkddddddqqqqqqqqqqqqqqqqqrrrrrrrrrrrrrrrrrrddddddddddddk');
          getCustomerNotifications();
        });
      } else {
        setState(() {
          userCheck();
          log('kkkkkkkkkqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqkkkkkkkkkddddddddddddddddddk');
          userCheck();
        });
      }
    });
  }

  getCustomerNotifications() async {
    showDialog(
      context: context,
      builder: (context) {
        return Center(
            child: CircularProgressIndicator(
          color: Colors.grey,
        ));
      },
    );
    var headers = {'Content-Type': 'application/json'};
    var response = await http.post(
        Uri.parse(
            'https://pitaratajobs.novasoft.lk/_app_remove_server/nzone_server_nzone_api/getCustomerNotifications'),
        headers: headers,
        body: json.encode({
          "app_id": "nzone_4457Was555@qsd_job",
          "verification": '111111',
          "customer_id": customer_id,
        }));

    var res = jsonDecode(response.body.toString());
    log(res.toString());
    Navigator.pop(context);
    setState(() {});
  }

  // userLogin() async {
  //   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  //   setState(() {
  //     var userLogin = sharedPreferences.getBool('userLoging');
  //     if (userLogin == true) {
  //       setState(() {
  //         x = 10;
  //       });
  //     } else {
  //       setState(() {
  //         x = 0;
  //         userCheck();
  //       });
  //       log('kkkkkkkkkkkkkkkkkkddddddddddddddddddk');
  //     }
  //   });
  // }

  userCheck() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
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
                          text:
                              'Please login to your account to access your favorite jobs!',
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
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: RadiusButton(
                            colortext: black,
                            color: white,
                            height: 70,
                            width: 110,
                            text: 'NO',
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => NameScreen()),
                            );
                          },
                          child: RadiusButton(
                            colortext: black,
                            color: font_green,
                            height: 70,
                            width: 110,
                            text: 'YES',
                          ),
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
    return Scaffold(
      backgroundColor: black,
      body: ListView.builder(
          itemCount: x,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                padding: EdgeInsets.all(8),
                height: 150,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: light_dark, borderRadius: BorderRadius.circular(20)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    CustomText(
                        text: 'Notification title',
                        fontSize: 17,
                        fontFamily: 'Comfortaa-VariableFont_wght',
                        color: white,
                        fontWeight: FontWeight.bold),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                        alignment: Alignment.center,
                        child: Text(
                          'One an sport for next 30 days. This man is th an for comparing for other and this is the cool pac an with the coll attitude',
                          style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'Comfortaa-VariableFont_wght',
                              color: white,
                              fontWeight: FontWeight.normal),
                        )),
                    Container(
                        alignment: Alignment.bottomRight,
                        child: Text(
                          ' 2022-10-26 10:21 AM',
                          style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'Comfortaa-VariableFont_wght',
                              color: Colors.white60,
                              fontWeight: FontWeight.normal),
                        )),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
