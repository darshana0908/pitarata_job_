import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:html/parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:lottie/lottie.dart';
// import 'package:image_picker/image_picker.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:pitarata_job/Screen/profile/update_profile.dart';
import 'package:pitarata_job/color/colors.dart';
import 'package:pitarata_job/widget/arrow_button.dart';
import 'package:pitarata_job/widget/custom_text.dart';
import 'package:http/http.dart' as http;
import 'package:pitarata_job/widget/custom_text_field.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../api/api_deatails.dart';
import '../../class/main_dialog.dart';
import '../../db/sqldb.dart';
import '../../widget/alert.dart';

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
  bool imgLoad = false;
  bool tap = false;
  SqlDb sqlDb = SqlDb();
  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  userLogin() async {
    setState(() {
      isloading = true;
    });
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
        print('ddddddddddddddddddddddddddddddddddddd');

        isloading = false;
        WidgetsBinding.instance.addPostFrameCallback((_) async {
          showCustomDialog(context, 'Please login to your account to access your profile setting !');
          Future.delayed(Duration(milliseconds: 20));
          log('kkkkkkkkkqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqkkkkkkkkkddddddddddddddddddk');
        });
      });
    }
    setState(() {
      isloading = false;
    });
  }

  getCustomerProfileDetails() async {
    bool result = await InternetConnectionChecker().hasConnection;
    List pList = await sqlDb.readData("select * from profile");
    print('ffffffff');
    setState(() {
      isloading = true;
    });
    if (result == true) {
      var headers = {'Content-Type': 'application/json'};

      var response = await http.post(Uri.parse('$apiUrl/getCustomerProfileDetails'),
          headers: headers, body: json.encode({"app_id": "nzone_4457Was555@qsd_job", "customer_id": customerId, "verification": verification}));
      var res = jsonDecode(response.body.toString());
      print(res.toString());
      if (res.toString().isNotEmpty) {
        for (var index = 0; index < res['data'].length; ++index) {
          final value = res['data'][0];

          print('dddddddddddddddddddd' + res['data'][index]['name'].toString());

          var lname = res['data'][index]['name'].toString();
          var laddress = res['data'][index]['address'].toString();
          var lmobile = res['data'][index]['mobile'].toString();
          var lmobile2 = res['data'][index]['mobile_2'].toString();
          var limg = res['data'][index]['profile_image'].toString();
          var lgender = res['data'][index]['gender'].toString();
          var lbirtday = res['data'][index]['birthday'].toString();
          var lemail = res['data'][index]['email'].toString();
          var lusername = res['data'][index]['username'].toString();
          print(lusername);
          isloading = false;

          address = res['data'][index]['address'].toString();
          address = res['data'][index]['address'].toString();
          if (pList.isEmpty) {
            print('fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff');
            var r = await sqlDb.insertData(
                "insert into profile ('m_no','m2_no','gender','birthday','address','email','name','status') values('$lmobile','$lmobile2','$lgender','$lbirtday','$laddress','$lemail','$lname','1')");
          } else {
            print('fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffssssssssssssssssffffffffffffff');
            await sqlDb.updateData(
                "update profile set 'm_no' = '$lmobile','m2_no'='$lmobile2','gender'='$lgender','birthday'='$lbirtday','address'='$laddress','email'='$lemail','name'='$lname','status'='1' where id ='1' ");
          }
          pList = await sqlDb.readData("select * from profile");
          print(pList);
          setState(() {
            isloading = false;

            name = pList[index]['name'].toString();
            address = pList[index]['address'].toString();
            mobile = pList[index]['m_no'].toString();
            mobile2 = pList[index]['m2_no'].toString();
            img = res['data'][index]['profile_image'].toString();
            gender = pList[index]['gender'].toString();
            birtday = pList[index]['birthday'].toString();
            email = pList[index]['email'].toString();
            username = pList[index]['email'].toString();
            print(username);
            isloading = false;
          });
        }
      }
    } else {
      pList = await sqlDb.readData("select * from profile");
      if (pList.isNotEmpty) {
        for (var index = 0; index < pList.length; ++index) {
          pList = await sqlDb.readData("select * from profile");
          print(pList);
          setState(() {
            isloading = false;

            name = pList[index]['name'].toString();
            address = pList[index]['address'].toString();
            mobile = pList[index]['m_no'].toString();
            mobile2 = pList[index]['m2_no'].toString();

            gender = pList[index]['gender'].toString();
            birtday = pList[index]['birthday'].toString();
            email = pList[index]['email'].toString();
            username = pList[index]['email'].toString();
            isloading = false;
          });
        }
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
    print('dddddddddddddddddddddddddddddddddddddddddddddd');
    uploadImage(choosedimage.path);
  }

  Future<void> uploadImage(String imageFile) async {
    setState(() {
      imgLoad = true;
    });
    var request = http.MultipartRequest('POST', Uri.parse('$domain/uploads/upload_customer_profile_image.php'));
    request.fields.addAll({'action': 'simple'});
    request.files.add(await http.MultipartFile.fromPath('my_field', imageFile));

    http.StreamedResponse response = await request.send();

    var httpResponse = await http.Response.fromStream(response);

    // log(httpResponse.body.toString());
    // log(httpResponse.body);

    String html = httpResponse.body.toString();
    String urlPrefix = '<a href="';

    int urlStart = html.indexOf(urlPrefix) + urlPrefix.length;
    int urlEnd = html.indexOf('"', urlStart);
    var data = html.substring(urlStart, urlEnd);
    String result = data.substring(3);
    updateCustomerProfileImage(result);
    print(result);
  }

  updateCustomerProfileImage(String path) async {
    setState(() {
      imgLoad = true;
    });

    var headers = {'Content-Type': 'application/json'};

    var response = await http.post(Uri.parse('$apiUrl/updateCustomerProfileImage'),
        headers: headers,
        body: json.encode({"app_id": "nzone_4457Was555@qsd_job", "customer_id": customerId, "verification": verification, "image_path": path}));
    var res = jsonDecode(response.body.toString());
    log(res.toString());
    setState(() {
      isloading = true;
      imgLoad = false;
      getCustomerProfileDetails();
    });
  }

  @override
  void initState() {
    userLogin();
    initConnectivity();

    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  Future<void> initConnectivity() async {
    late ConnectivityResult result;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      print(
        'Couldn\'t check connectivity status',
      );
      return;
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    setState(() {
      _connectionStatus = result;
      print(result);
      if (result != 'ConnectivityResult.none') {
        print('dddddd');
        updateCustomerProfile();
      } else {
        print('ddddddssssssssssss');
      }
    });
  }

  updateCustomerProfile() async {
    List localProfile = await sqlDb.readData("select * from profile");
    setState(() {
      isloading = true;
    });

    for (var index = 0; index < localProfile.length; ++index) {
      if (localProfile[index]['status'] == '0') {
        var headers = {'Content-Type': 'application/json'};
        var response = await http.post(Uri.parse('$apiUrl/updateCustomerProfile'),
            headers: headers,
            body: json.encode({
              "app_id": "nzone_4457Was555@qsd_job",
              "verification": verification,
              "customer_id": customerId,
              "name": localProfile[index]['name'].toString(),
              "mobile_1": localProfile[index]['m_no'].toString(),
              "mobile_2": localProfile[index]['m2_no'].toString(),
              "email": localProfile[index]['email'].toString(),
              "gender": localProfile[index]['gender'].toString(),
              "address": localProfile[index]['address'].toString(),
              'birthday': localProfile[index]['birthday'].toString()
            }));
        log(customerId + verification);

        var res = jsonDecode(response.body.toString());
        if (res['status'] == '1') {
          await sqlDb.updateData("update profile set status ='1' where id ='1' ");
          localProfile = await sqlDb.readData("select * from profile");
          print(localProfile);
          getCustomerProfileDetails();
        }

        print(res);
      }
    }
    setState(() {
      isloading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: black,
        body: Stack(
          children: [
            userLoging
                ? SingleChildScrollView(
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Container(
                        height: MediaQuery.of(context).size.height / 3,
                        width: double.infinity,
                        child: Stack(
                          children: [
                            Positioned(
                                child: Stack(
                              children: [
                                Container(
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
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(horizontal: img == "null" ? 100 : 0),
                                      child: img == "null"
                                          ? Lottie.asset('assets/default_user.json')
                                          :
                                          // Image.network(
                                          //     "$domain/$img",
                                          //     fit: BoxFit.cover,
                                          //   ),
                                          CachedNetworkImage(
                                              imageUrl: "$domain/$img",
                                              progressIndicatorBuilder: (context, url, downloadProgress) => Center(
                                                child: SizedBox(
                                                  height: 50,
                                                  width: 50,
                                                  child: CircularProgressIndicator(value: downloadProgress.progress),
                                                ),
                                              ),
                                              errorWidget: (context, url, error) {
                                                return Lottie.asset('assets/default_user.json');
                                              },
                                              fit: BoxFit.cover,
                                            ),
                                    )),
                                Positioned(child: imgLoad ? Center(child: CircularProgressIndicator()) : Container())
                              ],
                            )),
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
                                child: Column(
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
                                child: CircleAvatar(
                                  radius: 30,
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
                                text: mobile, fontSize: 20, fontFamily: 'Comfortaa-VariableFont_wght', color: white, fontWeight: FontWeight.normal),
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
                              style: TextStyle(fontSize: 20, fontFamily: 'Comfortaa-VariableFont_wght', color: white, fontWeight: FontWeight.normal),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            InkWell(
                              borderRadius: BorderRadius.circular(25),
                              onTapCancel: () {
                                setState(() {
                                  tap = false;
                                });
                              },
                              onTapDown: (_) {
                                setState(() {
                                  tap = true;
                                });
                              },
                              onTapUp: (_) {
                                setState(() {
                                  tap = false;
                                });
                              },
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => UpdateProfile(
                                            img: img,
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
                              child: AnimatedOpacity(
                                duration: Duration(milliseconds: 50),
                                opacity: tap ? 0.3 : 1,
                                child: Container(
                                  alignment: Alignment.center,
                                  height: 60,
                                  width: double.infinity,
                                  decoration: BoxDecoration(color: font_green, borderRadius: BorderRadius.circular(25)),
                                  child: CustomText(
                                      text: 'Update Profile',
                                      fontSize: 20,
                                      fontFamily: 'Comfortaa-VariableFont_wght',
                                      color: white,
                                      fontWeight: FontWeight.normal),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ]),
                  )
                : Container(),
            isloading
                ? Center(child: LoadingAnimationWidget.staggeredDotsWave(color: Colors.grey, size: MediaQuery.of(context).size.width / 6))
                : Container()
          ],
        ));
  }
}
