import 'dart:convert';
import 'dart:developer';
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

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
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

  List getMsgList = [];
  String name = '';
  String address = '';
  String mobile = '';
  String mobile2 = '';
  String img = '';
  String gender = '';
  String birtday = '';
  String email = '';
  String username = '';
  bool update = false;
  bool male = false;
  bool female = false;
  bool save = false;
  String proimage = '';
  File? uploadimage;
  bool isloading = false;
  bool image = false;
  String user_id = '';
  String urlimg = '';

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
          getCustomerProfileDetails();
          userLoging = true;
        });
      } else {
        setState(() {
          userLoging = false;
          WidgetsBinding.instance.addPostFrameCallback((_) async {
            loading(context,
                'Please login to your account to access your profile setting');
          });
        });
      }
    });
  }

  getCustomerProfileDetails() async {
    setState(() {});

    var headers = {'Content-Type': 'application/json'};

    var response = await http.post(
        Uri.parse(
            'https://pitaratajobs.novasoft.lk/_app_remove_server/nzone_server_nzone_api/getCustomerProfileDetails'),
        headers: headers,
        body: json.encode({
          "app_id": "nzone_4457Was555@qsd_job",
          "customer_id": customerId,
          "verification": verification
        }));
    var res = jsonDecode(response.body.toString());

    for (var index = 0; index < res['data'].length; ++index) {
      final value = res['data'][0];

      log('dddddddddddddddddddd' + res['data'][index]['name'].toString());

      setState(() {
        name = res['data'][index]['name'].toString();
        address = res['data'][index]['address'].toString();
        mobile = res['data'][index]['mobile'].toString();
        mobile2 = res['data'][index]['mobile_2'].toString();
        img = res['data'][index]['profile_image'].toString();
        gender = res['data'][index]['gender'].toString();
        birtday = res['data'][index]['birthday'].toString();
        email = res['data'][index]['email'].toString();
        username = res['data'][index]['username'].toString();
      });
    }
  }

  updateCustomerProfile() async {
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
            'https://pitaratajobs.novasoft.lk/_app_remove_server/nzone_server_nzone_api/updateCustomerProfile'),
        headers: headers,
        body: json.encode({
          "app_id": "nzone_4457Was555@qsd_job",
          "verification": verification,
          "customer_id": customerId,
          "name": editName.text,
          "mobile_1": editmobile.text,
          "mobile_2": editmobile2.text,
          "email": editEmail.text,
          "gender": male == true ? "1" : "2",
          "address": editAddress.text,
          "birthday": editBirthday.text,
          "nic": editNic.text
        }));
    log(customerId + verification);

    var res = jsonDecode(response.body.toString());
    if (res['status'] == '1') {
      getCustomerProfileDetails();
      log(res.toString());
      setState(() {
        editName.clear();
        editmobile.clear();
        editAddress.clear();
        editBirthday.clear();
        editNic.clear();
        editmobile2.clear();
        editEmail.clear();
        male = false;
        female = false;
        update = false;
      });
    }
    Navigator.pop(context);
    MotionToast.info(title: Text("info"), description: Text(res['msg']))
        .show(context);
  }

  Future<void> chooseImage() async {
    final ImagePicker picker = ImagePicker();

    String fileType;
    String imgName;
    var choosedimage = await picker.pickImage(source: ImageSource.gallery);
    var uploadimage = File(choosedimage!.path);

    List<int> imageBytes = uploadimage.readAsBytesSync();
    String baseimage = base64Encode(imageBytes);

    // Upload(baseimage);
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
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
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
                    child: update
                        ? Container()
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                  text: name,
                                  fontSize: 30,
                                  fontFamily: 'Comfortaa-VariableFont_wght',
                                  color: white,
                                  fontWeight: FontWeight.normal),
                              CustomText(
                                  text: 'Username:$username',
                                  fontSize: 15,
                                  fontFamily: 'Comfortaa-VariableFont_wght',
                                  color: white,
                                  fontWeight: FontWeight.normal),
                            ],
                          ),
                  ),
                ),
                Positioned(
                  top: 4,
                  left: 4,
                  child: TextButton(
                    onPressed: () {
                      chooseImage();
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Stack(
                        children: [
                          Icon(
                            Icons.camera_alt_outlined,
                            size: 30,
                          ),
                          Positioned(
                            top: 10,
                            left: 10,
                            child: Icon(
                              Icons.add,
                              color: red,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
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
                update
                    ? Column(
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
                          update
                              ? SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height / 13,
                                  child: Form(
                                    child: CustomTextField(
                                        hintText: name,
                                        controller: editName,
                                        keyInput: TextInputType.text,
                                        icon: Icons.person),
                                  ),
                                )
                              : Container(),
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
                          update
                              ? Form(
                                  autovalidateMode: AutovalidateMode.always,
                                  child: SizedBox(
                                    height:
                                        MediaQuery.of(context).size.height / 10,
                                    child: CustomTextField(
                                        hintText: email,
                                        controller: editEmail,
                                        keyInput: TextInputType.text,
                                        icon: Icons.email),
                                  ),
                                )
                              : Container(),
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
                          update
                              ? SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height / 13,
                                  child: CustomTextField(
                                      hintText: "type hear",
                                      controller: editNic,
                                      keyInput: TextInputType.text,
                                      icon: Icons.insert_drive_file),
                                )
                              : Container(),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      )
                    : Container(),
                CustomText(
                    text: 'Mobile Number',
                    fontSize: 15,
                    fontFamily: 'Comfortaa-VariableFont_wght',
                    color: Colors.white70,
                    fontWeight: FontWeight.normal),
                SizedBox(
                  height: 10,
                ),
                update
                    ? SizedBox(
                        height: MediaQuery.of(context).size.height / 13,
                        child: Form(
                          child: CustomTextField(
                              hintText: mobile,
                              controller: editmobile,
                              keyInput: TextInputType.number,
                              icon: Icons.phone),
                        ),
                      )
                    : CustomText(
                        text: mobile,
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
                update
                    ? SizedBox(
                        height: MediaQuery.of(context).size.height / 13,
                        child: Form(
                          child: CustomTextField(
                              hintText:
                                  mobile2 == 'null' ? 'type hear' : '$mobile2',
                              controller: editmobile2,
                              keyInput: TextInputType.number,
                              icon: Icons.mobile_friendly),
                        ),
                      )
                    : CustomText(
                        text: mobile2 == 'null' ? '-' : '$mobile2',
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
                update
                    ? SizedBox(
                        height: MediaQuery.of(context).size.height / 13,
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
                        ))
                    : CustomText(
                        text: gender == '3' ? '-' : gender,
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
                update
                    ? SizedBox(
                        height: MediaQuery.of(context).size.height / 13,
                        child: Form(
                          child: CustomTextField(
                              hintText:
                                  birtday == "null" ? "type hear" : birtday,
                              controller: editBirthday,
                              keyInput: TextInputType.number,
                              icon: Icons.card_giftcard),
                        ),
                      )
                    : CustomText(
                        text: birtday == "null" ? "-" : birtday,
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
                update
                    ? SizedBox(
                        height: MediaQuery.of(context).size.height / 13,
                        child: Form(
                          child: CustomTextField(
                              hintText: address.isEmpty ? "type hear" : address,
                              controller: editAddress,
                              keyInput: TextInputType.text,
                              icon: Icons.place_sharp),
                        ),
                      )
                    : Text(
                        address.isEmpty ? "-" : address,
                        style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'Comfortaa-VariableFont_wght',
                            color: white,
                            fontWeight: FontWeight.normal),
                      ),
                SizedBox(
                  height: 20,
                ),
                update
                    ? InkWell(
                        onTap: () {
                          if (update) {
                            if (editName.text.isNotEmpty) {
                              if (editEmail.text.isNotEmpty &&
                                  editmobile.text.length == 10) {
                                if (editmobile2.text.isNotEmpty) {
                                  if (male == true || female == true) {
                                    if (editBirthday.text.isNotEmpty) {
                                      if (editAddress.text.isNotEmpty) {
                                        updateCustomerProfile();
                                      } else {
                                        MotionToast.error(
                                                title: Text("info"),
                                                description:
                                                    Text('check your address'))
                                            .show(context);
                                      }
                                    } else {
                                      MotionToast.error(
                                              title: Text("info"),
                                              description:
                                                  Text('check your birthday'))
                                          .show(context);
                                    }
                                  } else {
                                    MotionToast.error(
                                            title: Text("info"),
                                            description:
                                                Text('check your gender '))
                                        .show(context);
                                  }
                                } else {
                                  MotionToast.error(
                                          title: Text("info"),
                                          description: Text(
                                              'check your mobile number 2'))
                                      .show(context);
                                }
                              } else {
                                MotionToast.error(
                                        title: Text("info"),
                                        description: Text('check your email'))
                                    .show(context);
                              }
                            } else {
                              MotionToast.error(
                                      title: Text("info"),
                                      description: Text('check your name'))
                                  .show(context);
                            }
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
                              text: "Save",
                              fontSize: 20,
                              fontFamily: 'Comfortaa-VariableFont_wght',
                              color: white,
                              fontWeight: FontWeight.normal),
                        ),
                      )
                    : InkWell(
                        onTap: () {
                          setState(() {
                            update = true;
                          });
                        },
                        child: Container(
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
                        ),
                      )
              ],
            ),
          ),
        ]),
      ),
    );
    
  }

}
