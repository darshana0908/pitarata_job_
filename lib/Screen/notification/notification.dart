import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:pitarata_job/color/colors.dart';
import 'package:pitarata_job/widget/custom_text.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../class/main_dialog.dart';


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
  bool isLoading = false;
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
          getCustomerNotifications();
        });
      } else {
        setState(() {
          showCustomDialog(context,
              'Please login to your account to access your notification !');
        });
      }
    });
  }

  getCustomerNotifications() async {
    setState(() {
      isLoading = true;
    });
    var headers = {'Content-Type': 'application/json'};
    var response = await http.post(
        Uri.parse(
            'https://pitaratajobs.novasoft.lk/_app_remove_server/nzone_server_nzone_api/getCustomerNotifications'),
        headers: headers,
        body: json.encode({
          "app_id": "nzone_4457Was555@qsd_job",
          "verification": verification,
          "customer_id": customer_id,
        }));

    var res = jsonDecode(response.body.toString());
    log(res.toString());
    setState(() {
      isLoading = false;
    });
    if (res['data'] != "null") {
      setState(() {
        notificationsList = res['data'];
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black,
      body: Stack(
        children: [
          ListView.builder(
              itemCount: notificationsList.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    padding: EdgeInsets.all(8),
                    height: 150,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: light_dark,
                        borderRadius: BorderRadius.circular(20)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        CustomText(
                            text: notificationsList[index]['title'],
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
                              notificationsList[index]['notification'],
                              style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: 'Comfortaa-VariableFont_wght',
                                  color: white,
                                  fontWeight: FontWeight.normal),
                            )),
                        Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Container(
                              alignment: Alignment.bottomRight,
                              child: Text(
                                '${notificationsList[index]['date']}+${notificationsList[index]['time']}',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: 'Comfortaa-VariableFont_wght',
                                    color: Colors.white60,
                                    fontWeight: FontWeight.normal),
                              )),
                        ),
                      ],
                    ),
                  ),
                );
              }),
          isLoading
              ? Center(
                  child: LoadingAnimationWidget.staggeredDotsWave(
                      color: Colors.grey,
                      size: MediaQuery.of(context).size.width / 6))
              : Container()
        ],
      ),
    );
  }
}
