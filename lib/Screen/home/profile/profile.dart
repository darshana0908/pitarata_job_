import 'dart:convert';
import 'dart:developer';
import 'dart:ffi';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
// import 'package:image_picker/image_picker.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:pitarata_job/Screen/home/profile/update_profile.dart';
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

  List<String> encodedImages = [];
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
  int x = 0;
  bool proimg = false;

  userLogin() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var res = sharedPreferences.setBool("user", true);

    var userLogin = sharedPreferences.getBool('userLoging');
    var y = sharedPreferences.getString('customer_id');
    var z = sharedPreferences.getString('verification');
    customerId = y.toString();
    verification = z.toString();

    log(y.toString());
    log(z.toString());

    if (userLogin == true) {
      await getCustomerProfileDetails();
      setState(() {
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
  }

  getCustomerProfileDetails() async {
    setState(() {
      isloading = true;
    });

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
    log(res.toString());
    if (res.toString().isNotEmpty) {
      for (var index = 0; index < res['data'].length; ++index) {
        final value = res['data'][0];

        log('dddddddddddddddddddd' + res['data'][index]['name'].toString());

        setState(() {
          isloading = false;
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
  }

  updateuser() {
    setState(() {
      getCustomerProfileDetails();
    });
  }

  Future<void> chooseImage() async {
    final ImagePicker picker = ImagePicker();
    encodedImages = [];
    String fileType;
    String imgName;
    var choosedimage = await picker.pickImage(source: ImageSource.gallery);
    var uploadimage = File(choosedimage!.path);

    List<int> imageBytes = await uploadimage.readAsBytesSync();
    String baseimage = base64Encode(imageBytes);
    // String newb = baseimage;

    // log(baseimage);
    List<String> base64Images = [
      baseimage, baseimage

      // Add more base64-encoded image strings as needed
    ];
    dioTest(base64Images);
    // main(newb);
  }

  Future<void> dioTest(List<String> base64Image) async {
    final dio = Dio();
    var formData = FormData.fromMap({
      'my_field': base64Image,
      'action': 'multiple',
    });
    var response = await dio.post(
        'https://pitaratajobs.novasoft.lk/uploads/upload_customer_profile_image.php',
        data: formData);
    log(formData.toString());
    log(response.data.toString());
  }

  Future<void> uploadImageToServer(String base64Image) async {
    var url =
        Uri.parse('https://example.com/upload'); // Replace with your server URL
    var response = await http.post(
      url,
      body: {
        'my_field': ["$base64Image"],
        'action': 'multiple',
      },
    );
    log(response.body.toString());
    if (response.statusCode == 200) {
      print('Image uploaded successfully');
    } else {
      print('Image upload failed');
    }
  }

  Future<void> uploadImages(List<String> base64Images) async {
    var apiUrl =
        'https://pitaratajobs.novasoft.lk/uploads/upload_customer_profile_image.php';

    for (var base64Image in base64Images) {
      var headers = {'Content-Type': 'application/json'};
      var body = jsonEncode({
        'my_field': base64Image,
        'action': 'multiple',
      });
      log('hhhhh');

      var response = await http.post(Uri.parse(apiUrl), body: body);
      log(response.body.toString());

      if (response.statusCode == 200) {
        print('Image uploaded successfully');
      } else {
        print('Failed to upload image. Error: ${response.reasonPhrase}');
      }
    }
  }

  //okkkkk this

  main(String img) async {
    // This will be sent as form data in the post requst
    var map = new Map<String, dynamic>();
    map['my_field'] = img;
    map['action'] = 'multiple';

    final response = await http.post(
      Uri.parse(
          'https://pitaratajobs.novasoft.lk/uploads/upload_customer_profile_image.php'),
      body: jsonEncode(map),
    );

    print(response.body);
  }

  Future<void> sendFormData(
    String img,
  ) async {
    var url = Uri.parse(
        'https://pitaratajobs.novasoft.lk/uploads/upload_customer_profile_image.php'); // Replace with your actual endpoint URL

    var response = await http.post(url, body: {
      'my_field': [img],
      'action': 'multiple',
    });
    log(response.body.toString());
    if (response.statusCode == 200) {
      // Request successful, do something
      print('Form data sent successfully!');
    } else {
      // Request failed, handle the error
      print('Error sending form data. Status code: ${response.statusCode}');
    }
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
        body: userLoging
            ? Stack(
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
                                        foregroundDecoration:
                                            const BoxDecoration(
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
                                        height:
                                            MediaQuery.of(context).size.height /
                                                3,
                                        width: double.infinity,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 100),
                                          child: Lottie.asset(
                                              'assets/default_user.json'),
                                        ))),
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
                                            fontFamily:
                                                'Comfortaa-VariableFont_wght',
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        CustomText(
                                            text: name,
                                            fontSize: 30,
                                            fontFamily:
                                                'Comfortaa-VariableFont_wght',
                                            color: white,
                                            fontWeight: FontWeight.normal),
                                        CustomText(
                                            text: 'Username:$username',
                                            fontSize: 15,
                                            fontFamily:
                                                'Comfortaa-VariableFont_wght',
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
                                CustomText(
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
                                CustomText(
                                    text: gender == '1'
                                        ? "male"
                                        : gender == '2'
                                            ? "female"
                                            : "_",
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
                                Text(
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
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => UpdateProfile(
                                                gender: gender,
                                                name: name,
                                                address: address,
                                                email: username,
                                                Birth: birtday,
                                                mobile1: mobile,
                                                mobile2: mobile2,
                                                update: updateuser,
                                                cId: customerId,
                                                vId: verification,
                                              )),
                                    );
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: 60,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        color: font_green,
                                        borderRadius:
                                            BorderRadius.circular(25)),
                                    child: CustomText(
                                        text: 'Update Profile',
                                        fontSize: 20,
                                        fontFamily:
                                            'Comfortaa-VariableFont_wght',
                                        color: white,
                                        fontWeight: FontWeight.normal),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ]),
                  ),
                  isloading
                      ? Center(
                          child: CircularProgressIndicator(
                          color: Colors.grey,
                        ))
                      : Container()
                ],
              )
            : Container());
  }
}
