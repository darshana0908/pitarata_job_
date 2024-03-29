import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:pitarata_job/Screen/home/navigation.dart';
import 'package:pitarata_job/Screen/intro/intro_1.dart';
import 'package:pitarata_job/Screen/name_screen/name_screen.dart';
import 'package:pitarata_job/color/colors.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;
import '../../api/api_deatails.dart';
import '../../helper/api.dart';
import '../../providers/all_provider.dart';

class SplashPage extends StatefulWidget {
  SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  String assetName = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getWallpaper();
      Api().getCategory(context);
      Api().getJobCategory(context);
    });
    Future.delayed(
      const Duration(seconds: 2),
      () {
        userLogin();
      },
    );
  }

  getWallpaper() async {
    var headers = {'Content-Type': 'application/json'};
    var response =
        await http.post(Uri.parse('$apiUrl/getHomeWallpapers'), headers: headers, body: json.encode({"app_id": "nzone_4457Was555@qsd_job"}));
    var res = jsonDecode(response.body.toString());
    List img = res['data'];
    print(img);

    if (img.isNotEmpty) {
      Provider.of<AppProvider>(context, listen: false).wallPaper = img;
    }
  }

  userLogin() async {
    log('jjjjjjjjjjjjjjjj');
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    var userLogin = await sharedPreferences.getBool('user');
    log(userLogin.toString());
    var z = await sharedPreferences.getString('verification');
    log("sssssssssss" + z.toString());
    if (userLogin == true) {
      if (z == "0") {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const NameScreen()),
        );
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
      }
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const IntroOnePage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black,
      body: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Stack(
          children: [
            Column(children: [
              SizedBox(
                height: MediaQuery.of(context).size.height / 5,
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 80),
                  child: Image.asset(
                    'assets/app icon.png',
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text('PITA RATA JOBS', style: TextStyle(color: Colors.green, fontFamily: 'Viga', fontSize: 25.sp)),
              SizedBox(
                height: 5,
              ),
              Text(' the best place to find your dream job',
                  style: TextStyle(color: Colors.white, fontFamily: 'Comfortaa-VariableFont_wght', fontSize: 11.sp)),
            ]),
            Align(
              alignment: Alignment.bottomCenter,
              child:
                  Text(' Powered By NovatechZone', style: TextStyle(color: Colors.white54, fontFamily: 'Comfortaa-VariableFont_wght', fontSize: 15)),
            ),
          ],
        ),
      ),
    );
  }
}
