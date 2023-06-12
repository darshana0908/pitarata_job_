import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:lottie/lottie.dart';
import 'package:pitarata_job/Screen/blog/blog.dart';
import 'package:pitarata_job/Screen/favorite/favorite.dart';
import 'package:pitarata_job/color/colors.dart';
import 'package:pitarata_job/widget/custom_grid.dart';
import 'package:pitarata_job/widget/custom_home.dart';
import 'package:pitarata_job/widget/custom_list.dart';
import 'package:pitarata_job/widget/custom_text.dart';
import 'package:pitarata_job/widget/drawer.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import '../../widget/fade_home.dart';
import '../../widget/radius_button.dart';
import '../name_screen/name_screen.dart';
import '../notification/notification.dart';
import 'profile/profile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  String title = '';
  bool userLoging = false;
  // bool x = false;
  String customerId = '';
  String verification = '';
  bool customerLogin = false;

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
      authenticateCustomer(customerId, verification);
      if (userLogin == true) {
        setState(() {
          userLoging = true;
          // x = false;
        });
      } else {
        setState(() {
          userLoging = false;
          // x = false;
        });
        log('kkkkkkkkkkkkkkkkkkddddddddddddddddddk');
      }
    });
  }

  loading() async {
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
                        text: 'Are you sure you want to exit?',
                        fontSize: 17.sp,
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
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: RadiusButton(
                          colortext: black,
                          color: white,
                          height: 70,
                          width: 30.w,
                          text: 'NO',
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          exit(0);
                        },
                        child: RadiusButton(
                          colortext: black,
                          color: font_green,
                          height: 70,
                          width: 30.w,
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
  }

  void _onItemTapped(int index) {
    log('ffff');
    setState(() {
      _selectedIndex = index;
      log(_selectedIndex.toString());
    });
    if (_selectedIndex == 0) {
      setState(() {
        title = '';
      });
    }
    if (_selectedIndex == 1) {
      setState(() {
        title = 'Favorite';
      });
    }
    if (_selectedIndex == 2) {
      setState(() {
        title = 'Notification';
      });
    }
    if (_selectedIndex == 3) {
      setState(() {
        title = 'Blog';
      });
    }
    if (_selectedIndex == 4) {
      setState(() {
        title = 'Setting';
      });
    }
  }

  authenticateCustomer(String cid, String ver) async {
    setState(() {
      // isLoading = true;customer_id: 535, user_type: 1, verification: 74668
    });

    var headers = {'Content-Type': 'application/json'};

    // request.headers.addAll(headers);
    var response = await http.post(
        Uri.parse(
            'https://pitaratajobs.novasoft.lk/_app_remove_server/nzone_server_nzone_api/authenticateCustomer'),
        headers: headers,
        body: json.encode({
          "verification": ver,
          "app_id": "nzone_4457Was555@qsd_job",
          "customer_id": cid,
          "api_key": "448755456"
        }));
    var res = jsonDecode(response.body.toString());
    // log(res['status']);
    if (res['status'] == '1') {
      setState(() {
        customerId = cid;
        customerLogin = true;
        log('customer ttttttttttt' + customerLogin.toString());
      });
    } else {
      setState(() {
        customerLogin = false;
        log('customer false' + customerLogin.toString());
      });
    }

    // log("ddddddddddddddddddddddddddddddddddddddddddddd" + res.toString());
  }

  @override
  void initState() {
    userLogin();

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _pages = <Widget>[
      CustomHome(
        customerId: customerId,
        userStatus: customerLogin,
      ),
      FavoriteScreen(),
      NotificationScreen(),
      Blog(),
      Profile(),
      Icon(
        Icons.chat,
        size: 150,
      ),
    ];
    return WillPopScope(
      onWillPop: () {
        return loading();
      },
      child: Scaffold(
        backgroundColor: black,
        appBar: AppBar(
          backgroundColor: black,
          title: Container(
              alignment: Alignment.centerRight,
              child: CustomText(
                color: white,
                fontFamily: 'Comfortaa-VariableFont_wght',
                fontSize: 17,
                fontWeight: FontWeight.w900,
                text: title,
              )),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(4.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: SizedBox(
              child: BottomNavigationBar(
                unselectedIconTheme:
                    IconThemeData(color: font_green, size: 15.sp),
                unselectedItemColor: Colors.deepOrangeAccent,
                selectedIconTheme: IconThemeData(
                  color: font_green,
                ),
                selectedItemColor: font_green,
                elevation: 16,
                onTap: _onItemTapped,
                showSelectedLabels: false,
                showUnselectedLabels: false,
                backgroundColor: light_dark,
                type: BottomNavigationBarType.fixed,
                currentIndex: _selectedIndex,
                items: <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.home_outlined,
                    ),
                    label: '',
                  ),
                  BottomNavigationBarItem(
                      icon: Icon(
                        Icons.favorite_border,
                      ),
                      label: ''),
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.notifications_none,
                    ),
                    label: '',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.menu_book_sharp,
                    ),
                    label: '',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.person,
                    ),
                    label: '',
                  ),
                ],
              ),
            ),
          ),
        ),
        drawer: CustomDrawer(loging: userLoging),
        body: Center(
          child: _pages.elementAt(_selectedIndex), //New
        ),
      ),
    );
  }

  alert(
    String text,
  ) async {
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
                    padding: const EdgeInsets.all(20.0),
                    child: CustomText(
                        text: text,
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
                        onTap: () async {
                          Navigator.pop(context);
                          log('ggggg');
                        },
                        child: RadiusButton(
                          colortext: black,
                          color: white,
                          height: 70,
                          width: 110,
                          text: "Cancel",
                        ),
                      ),
                      InkWell(
                        onTap: () async {
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
                          text: "Login",
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }
}
