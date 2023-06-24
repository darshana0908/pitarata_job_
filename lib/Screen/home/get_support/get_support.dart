import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../color/colors.dart';
import '../../../widget/alert.dart';
import '../../../widget/arrow_button.dart';
import '../../../widget/custom_text.dart';
import '../../../widget/custom_text_two.dart';
import 'package:http/http.dart' as http;

class GetSupport extends StatefulWidget {
  const GetSupport({super.key});

  @override
  State<GetSupport> createState() => _GetSupportState();
}

class _GetSupportState extends State<GetSupport> {
  bool userLoging = false;
  // bool x = false;
  String customerId = '';
  String verification = '';
  bool customerLogin = false;
  TextEditingController controller = TextEditingController();
  List getMsgList = [];

  userLogin() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var res = sharedPreferences.setBool("user", true);
    setState(() {
      var userLogin = sharedPreferences.getBool('userLoging');
      var y = sharedPreferences.getString('customer_id');
      var z = sharedPreferences.getString('verification');
      customerId = y.toString();
      verification = z.toString();

      log(y.toString());
      log(z.toString());

      if (userLogin == true) {
        setState(() {
          userLoging = true;
          getSupportMessages();
        });
      } else {
        setState(() {
          userLoging = false;
          WidgetsBinding.instance.addPostFrameCallback((_) async {
            loading(context,
                'Please login to your account to access your Get Support!');
          });
        });
      }
    });
  }

  getSupportMessages() async {
    setState(() {});

    var headers = {'Content-Type': 'application/json'};

    var response = await http.post(
        Uri.parse(
            'https://pitaratajobs.novasoft.lk/_app_remove_server/nzone_server_nzone_api/getSupportMessages'),
        headers: headers,
        body: json.encode({
          "app_id": "nzone_4457Was555@qsd_job",
          "verification": verification,
          "customer_id": customerId,
        }));
    var res = jsonDecode(response.body.toString());
    log(res.toString());

    if (res.toString().isNotEmpty) {
      setState(() {
        getMsgList = res['data'];
      });
    } else {
      MotionToast.info(
              title: Text("info"), description: Text("empty suport massege"))
          .show(context);
    }
  }

  sendSupportMessageByCustomer() async {
    setState(() {});

    var headers = {'Content-Type': 'application/json'};

    var response = await http.post(
        Uri.parse(
            'https://pitaratajobs.novasoft.lk/_app_remove_server/nzone_server_nzone_api/sendSupportMessageByCustomer'),
        headers: headers,
        body: json.encode({
          "app_id": "nzone_4457Was555@qsd_job",
          "verification": verification,
          "customer_id": customerId,
          "message": controller.text
        }));
    var res = jsonDecode(response.body.toString());
    log(res.toString());
    if (res['msg'].toString().isNotEmpty) {
      MotionToast.info(title: Text("info"), description: Text(res['msg']))
          .show(context);
      setState(() {
        controller.clear();
        getSupportMessages();
      });
    } else {}
  }

  @override
  void initState() {
    userLogin();

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black,
      appBar: AppBar(
        leading: ArrowButton(onTap: () {
          Navigator.pop(context);
        },
          icons: Icons.arrow_back_ios_new),
        backgroundColor: black,
        title: Container(
            alignment: Alignment.centerRight,
            child: CustomText(
              color: white,
              fontFamily: 'Comfortaa-VariableFont_wght',
              fontSize: 17,
              fontWeight: FontWeight.w900,
              text: 'Get Support',
            )),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Stack(children: [
            SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height,
                child: ListView.builder(
                    itemCount: getMsgList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Container(
                          child: Column(children: [
                            Container(
                              padding:
                                  EdgeInsets.only(top: 16, left: 16, right: 16),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: light_dark,
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(15),
                                      topLeft: Radius.circular(15))),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomTextTwo(
                                    color: white,
                                    fontFamily: 'Comfortaa-VariableFont_wght',
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    text: 'Question',
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    alignment: Alignment.centerRight,
                                    child: CustomTextTwo(
                                      color: white,
                                      fontFamily: 'Comfortaa-VariableFont_wght',
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                      text: getMsgList[index]
                                          ['customer_message'],
                                    ),
                                  ),
                                  Container(
                                      padding: EdgeInsets.only(top: 8),
                                      alignment: Alignment.bottomRight,
                                      child: Text(
                                        getMsgList[index]['cus_date'] +
                                            getMsgList[index]['cus_time'],
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontFamily:
                                                'Comfortaa-VariableFont_wght',
                                            color: Colors.white60,
                                            fontWeight: FontWeight.normal),
                                      )),
                                ],
                              ),
                            ),
                            Container(
                              padding:
                                  EdgeInsets.only(top: 16, left: 16, right: 16),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: font_green,
                                  borderRadius: BorderRadius.only(
                                      bottomRight: Radius.circular(15),
                                      bottomLeft: Radius.circular(15))),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomTextTwo(
                                    color: black,
                                    fontFamily: 'Comfortaa-VariableFont_wght',
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    text: 'Answer',
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  CustomTextTwo(
                                    color: black,
                                    fontFamily: 'Comfortaa-VariableFont_wght',
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    text: getMsgList[index]['admin_message'],
                                  ),
                                  Container(
                                      padding: EdgeInsets.only(top: 8),
                                      alignment: Alignment.bottomRight,
                                      child: Text(
                                        "${getMsgList[index]['admin_date']}${getMsgList[index]['admin_time']}",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontFamily:
                                                'Comfortaa-VariableFont_wght',
                                            color: black,
                                            fontWeight: FontWeight.normal),
                                      )),
                                ],
                              ),
                            )
                          ]),
                        ),
                      );
                    }),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: TextField(
                controller: controller,
                style: TextStyle(color: white),
                decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                    suffixIcon: IconButton(
                      onPressed: () {
                        if (controller.text.isNotEmpty) {
                          sendSupportMessageByCustomer();
                        } else {
                          MotionToast.error(
                                  title: Text("error"),
                                  description: Text("please type your massege"))
                              .show(context);
                        }
                      },
                      icon: Icon(
                        Icons.send_sharp,
                        color: background_green,
                        size: 30,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderSide:
                          BorderSide(width: 5, color: Colors.greenAccent),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    filled: true,
                    hintStyle: TextStyle(color: Colors.grey[600]),
                    hintText: 'type your question... we will answer...',
                    fillColor: light_dark),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
