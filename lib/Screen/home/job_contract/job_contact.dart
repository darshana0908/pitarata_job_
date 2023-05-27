import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:pitarata_job/widget/ad_area.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../color/colors.dart';
import '../../../widget/arrow_button.dart';
import '../../../widget/color_container.dart';
import '../../../widget/custom_container.dart';
import '../../../widget/custom_text.dart';
import '../../../widget/custom_text_two.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

class JobContact extends StatefulWidget {
  const JobContact(
      {super.key,
      required this.email,
      required this.mobile,
      required this.whatapp,
      required this.job_id});
  final String email;
  final String mobile;
  final String whatapp;
  final String job_id;

  @override
  State<JobContact> createState() => _JobContactState();
}

class _JobContactState extends State<JobContact> {
  String customer_id = "";
  String verification = "";
  bool userStatus = false;

  userLogin() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      var z = sharedPreferences.getString('verification');
      var y = sharedPreferences.getString('customer_id');
      setState(() {
        customer_id = y.toString();
        log(customer_id);
      });

      log("verificatio" + verification);
      if (verification != '0') {
        setState(() {
          userStatus = true;
        });
      } else {
        setState(() {
          userStatus = false;
        });
      }
    });
  }

  updateJobLead() async {
    setState(() {
      // _isFirstLoadRunning = true;
    });

    var headers = {'Content-Type': 'application/json'};

    // request.headers.addAll(headers);
    var response = await http.post(
        Uri.parse(
            'https://pitaratajobs.novasoft.lk/_app_remove_server/nzone_server_nzone_api/updateJobView'),
        headers: headers,
        body: json.encode({
          "app_id": "nzone_4457Was555@qsd_job",
          "customer_id": userStatus ? customer_id : "0",
          "job_id": widget.job_id,
        }));
    var res = jsonDecode(response.body.toString());

    log(res['data'].toString());
  }

  @override
  void initState() {
    userLogin();
    updateJobLead();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black,
      appBar: AppBar(
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: ArrowButton(icons: Icons.arrow_back_ios_new)),
        backgroundColor: black,
        title: Container(
            alignment: Alignment.centerRight,
            child: CustomText(
              color: white,
              fontFamily: 'Comfortaa-VariableFont_wght',
              fontSize: 17,
              fontWeight: FontWeight.w900,
              text: 'Apply for the job',
            )),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            InkWell(
              onTap: () {
                _launchURL();
              },
              child: ColorContainer(
                iconColor: red,
                textColor: red,
                text: 'Email Address',
                text1: widget.email,
                icon: Icons.email_outlined,
                color1: black,
                color: Color.fromARGB(255, 93, 9, 3),
              ),
            ),
            InkWell(
              onTap: () async {
                if (widget.mobile.isNotEmpty) {
                  makingPhoneCall();
                }
              },
              child: ColorContainer(
                iconColor: background_green,
                textColor: background_green,
                text: 'Contact Number',
                text1: widget.mobile,
                icon: Icons.add_call,
                color1: black,
                color: Color.fromARGB(43, 4, 115, 45),
              ),
            ),
            InkWell(
              onTap: () async {
                if (widget.whatapp.isNotEmpty) {
                  makingWhatsappCall();
                }
              },
              child: ColorContainer(
                iconColor: Color.fromARGB(255, 12, 20, 168),
                textColor: Color.fromARGB(255, 12, 20, 168),
                text: 'Whats app Number',
                text1: widget.whatapp,
                icon: Icons.whatsapp_rounded,
                color1: black,
                color: Color.fromARGB(255, 4, 22, 75),
              ),
            ),
            InkWell(
                onTap: () {
                  MotionToast.info(
                          title: Text("Info"),
                          description:
                              Text('"This option will be enabled soon!"'))
                      .show(context);
                },
                child: AdArea()),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: CustomTextTwo(
                color: white,
                fontFamily: 'Comfortaa-VariableFont_wght',
                fontSize: 13,
                fontWeight: FontWeight.bold,
                text: 'Love this job ? Apply now!',
              ),
            ),
            InkWell(
              onTap: () {
                MotionToast.info(
                        title: Text("Info"),
                        description:
                            Text('"This option will be enabled soon!"'))
                    .show(context);
              },
              child: CustomContainer(
                  icon: 'assets/send.svg',
                  text1: 'Send My CV to this Job',
                  text2: 'Easily apply for the job',
                  colorText: font_green),
            ),
          ]),
        ),
      ),
    );
  }

  makingPhoneCall() async {
    var url = Uri.parse("tel:${widget.mobile}");
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  makingWhatsappCall() async {
    var url = Uri.parse("https://wa.me/${widget.whatapp}?text=Hello");
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void _launchURL() async {
    final Uri params = Uri(
        scheme: 'mailto',
        path: widget.email,
        queryParameters: {
          'subject': 'Default Subject',
          'body': 'Default body'
        });
    if (await canLaunchUrl(params)) {
      await launchUrl(params);
    } else {
      print('Could not launch $params');
    }
  }
}
