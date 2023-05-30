import 'dart:convert';
import 'dart:developer';
import 'dart:ffi';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:image_picker/image_picker.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:pitarata_job/color/colors.dart';
import 'package:pitarata_job/widget/arrow_button.dart';
import 'package:pitarata_job/widget/custom_text.dart';
import 'package:http/http.dart' as http;
import 'package:pitarata_job/widget/custom_text_field.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../widget/alert.dart';

class UpdateProfile extends StatefulWidget {
  const UpdateProfile(
      {super.key, required this.vId, required this.cId, required this.update});
  final String vId;
  final String cId;
  final Function update;

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  bool userLoging = false;
  // bool x = false;
  String customerId = '';
  String verification = '';
  bool customerLogin = false;
  TextEditingController editmobile = TextEditingController();
  TextEditingController editmobile2 = TextEditingController();
  TextEditingController editGender = TextEditingController();
  TextEditingController editBirthday = TextEditingController();
  TextEditingController editAddress = TextEditingController();
  TextEditingController editName = TextEditingController();
  TextEditingController editEmail = TextEditingController();
  TextEditingController editNic = TextEditingController();
  DateTime date = DateTime.now();
  bool isLoading = false;

  bool update = false;
  bool male = false;
  bool female = false;

  updateCustomerProfile() async {
    setState(() {
      isLoading = true;
    });
    var headers = {'Content-Type': 'application/json'};

    var response = await http.post(
        Uri.parse(
            'https://pitaratajobs.novasoft.lk/_app_remove_server/nzone_server_nzone_api/updateCustomerProfile'),
        headers: headers,
        body: json.encode({
          "app_id": "nzone_4457Was555@qsd_job",
          "verification": widget.vId,
          "customer_id": widget.cId,
          "name": editName.text,
          "mobile_1": editmobile.text,
          "mobile_2": editmobile2.text,
          "email": editEmail.text,
          "gender": male == true ? "1" : "2",
          "address": editAddress.text,
          "birthday": '${date.year}/${date.month}/${date.day}',
          "nic": editNic.text
        }));
    log(customerId + verification);

    var res = jsonDecode(response.body.toString());
    if (res['status'] == '1') {
      log(res.toString());

      setState(() {
        male = false;
        female = false;
        update = false;
        isLoading = false;
        widget.update();
      });
    }

    MotionToast.info(title: Text("info"), description: Text(res['msg']))
        .show(context);

    back();
  }

  back() {
    Navigator.pop(context);
    Navigator.pop(context);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black,
      body: AbsorbPointer(
        absorbing: isLoading,
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child:
                                          ArrowButton(icons: Icons.arrow_back)),
                                  CustomText(
                                      text: 'My UpdateProfile',
                                      fontSize: 30,
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
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                  text: 'name',
                                  fontSize: 15,
                                  fontFamily: 'Comfortaa-VariableFont_wght',
                                  color: Colors.white70,
                                  fontWeight: FontWeight.normal),
                              SizedBox(
                                height: 10,
                              ),
                              SizedBox(
                                child: Form(
                                  child: CustomTextField(
                                      hintText: 'name',
                                      controller: editName,
                                      keyInput: TextInputType.text,
                                      icon: Icons.person),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              CustomText(
                                  text: 'Email',
                                  fontSize: 15,
                                  fontFamily: 'Comfortaa-VariableFont_wght',
                                  color: Colors.white70,
                                  fontWeight: FontWeight.normal),
                              SizedBox(
                                height: 10,
                              ),
                              Form(
                                autovalidateMode: AutovalidateMode.always,
                                child: SizedBox(
                                  child: CustomTextField(
                                      hintText: 'email',
                                      controller: editEmail,
                                      keyInput: TextInputType.text,
                                      icon: Icons.email),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              CustomText(
                                  text: 'NIC',
                                  fontSize: 15,
                                  fontFamily: 'Comfortaa-VariableFont_wght',
                                  color: Colors.white70,
                                  fontWeight: FontWeight.normal),
                              SizedBox(
                                height: 10,
                              ),
                              SizedBox(
                                child: CustomTextField(
                                    hintText: "type hear",
                                    controller: editNic,
                                    keyInput: TextInputType.text,
                                    icon: Icons.insert_drive_file),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                          CustomText(
                              text: 'Mobile Number',
                              fontSize: 15,
                              fontFamily: 'Comfortaa-VariableFont_wght',
                              color: Colors.white70,
                              fontWeight: FontWeight.normal),
                          SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            child: Form(
                              child: CustomTextField(
                                  hintText: 'mobile',
                                  controller: editmobile,
                                  keyInput: TextInputType.number,
                                  icon: Icons.phone),
                            ),
                          ),
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
                          SizedBox(
                            child: Form(
                              child: CustomTextField(
                                  hintText: 'mobile number 2',
                                  controller: editmobile2,
                                  keyInput: TextInputType.number,
                                  icon: Icons.mobile_friendly),
                            ),
                          ),
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
                          SizedBox(
                              child: Row(
                            children: [
                              CustomText(
                                  text: 'male',
                                  fontSize: 13,
                                  fontFamily: 'Comfortaa-VariableFont_wght',
                                  color: Colors.white70,
                                  fontWeight: FontWeight.normal),
                              SizedBox(
                                height: 10,
                              ),
                              Checkbox(
                                hoverColor: black,
                                focusColor: font_green,
                                checkColor: background_green,
                                activeColor: black,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(1.0),
                                ),
                                side: MaterialStateBorderSide.resolveWith(
                                  (states) =>
                                      BorderSide(width: 2.0, color: font_green),
                                ),
                                value: male,
                                onChanged: (value) {
                                  setState(() {
                                    male = value!;
                                    female = false;
                                    log(male.toString());
                                  });
                                },
                              ),
                              CustomText(
                                  text: 'female',
                                  fontSize: 13,
                                  fontFamily: 'Comfortaa-VariableFont_wght',
                                  color: Colors.white70,
                                  fontWeight: FontWeight.normal),
                              SizedBox(
                                height: 10,
                              ),
                              Checkbox(
                                hoverColor: black,
                                focusColor: font_green,
                                checkColor: background_green,
                                activeColor: black,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(1.0),
                                ),
                                side: MaterialStateBorderSide.resolveWith(
                                  (states) =>
                                      BorderSide(width: 2.0, color: font_green),
                                ),
                                value: female,
                                onChanged: (value) {
                                  setState(() {
                                    female = value!;
                                    male = false;

                                    log(male.toString());
                                  });
                                },
                              ),
                            ],
                          )),
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
                          Row(
                            children: [
                              Container(
                                alignment: Alignment.bottomCenter,
                                width: 150,
                                height: 40,
                                child: CustomText(
                                    text:
                                        '${date.year}/${date.month}/${date.day}',
                                    fontSize: 20,
                                    fontFamily: 'Comfortaa-VariableFont_wght',
                                    color: Colors.white70,
                                    fontWeight: FontWeight.normal),
                              ),
                              SizedBox(
                                width: 30,
                              ),
                              IconButton(
                                  onPressed: () async {
                                    DateTime? newDate = await showDatePicker(
                                        context: context,
                                        initialDate: date,
                                        firstDate: DateTime(1960),
                                        lastDate: DateTime(2100));
                                    setState(() {
                                      date = newDate!;
                                      log(date.toString());
                                    });
                                  },
                                  icon: Icon(
                                    Icons.date_range,
                                    color: brown,
                                    size: 40,
                                  ))
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          InkWell(
                            onTap: () {
                              if (editName.text.isNotEmpty) {
                                if (editmobile.text.isNotEmpty &&
                                    editmobile.text.length == 10) {
                                  log('vgvgv ');
                                  updateCustomerProfile();
                                  setState(() {
                                    widget.update();
                                  });
                                } else {
                                  MotionToast.info(
                                          description: Text(
                                              "Please check your mobile number"))
                                      .show(context);
                                }
                              } else {
                                MotionToast.info(
                                        description:
                                            Text('Please enter your name'))
                                    .show(context);
                              }
                            },
                            child: Container(
                              alignment: Alignment.center,
                              height: 60,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: font_green,
                                  borderRadius: BorderRadius.circular(25)),
                              child: CustomText(
                                  text: 'Save',
                                  fontSize: 20,
                                  fontFamily: 'Comfortaa-VariableFont_wght',
                                  color: white,
                                  fontWeight: FontWeight.normal),
                            ),
                          )
                        ],
                      ),
                    ),
                  ]),
            ),
            isLoading
                ? Center(
                    child: CircularProgressIndicator(
                    color: Colors.grey,
                  ))
                : Container()
          ],
        ),
      ),
    );
  }
}
