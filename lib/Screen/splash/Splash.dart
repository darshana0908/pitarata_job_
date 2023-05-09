import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:pitarata_job/Screen/intro/intro_1.dart';
import 'package:pitarata_job/color/colors.dart';

class SplashPage extends StatefulWidget {
  SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  String assetName = '';
  @override
  void initState() {
    Future.delayed(
      const Duration(seconds: 2),
      () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => IntroOnePage()),
        );
      },
    );
    // TODO: implement initState
    super.initState();
  }

  svg() async {
    // assetName = await rootBundle.loadString('assets/create_new_account.json');
    assetName = jsonDecode('assets/create_new_account.json');
    setState(() {
      assetName;
      log(assetName.toString());
    });
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
                    'assets/app-logo.png',
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text('PITA RATA JOBS',
                  style: TextStyle(
                      color: Colors.green, fontFamily: 'Viga', fontSize: 39)),
              SizedBox(
                height: 5,
              ),
              Text(' the best place to find your dream job',
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Comfortaa-VariableFont_wght',
                      fontSize: 15)),
            ]),
            Align(
              alignment: Alignment.bottomCenter,
              child: Text(' Powered By NovatechZone',
                  style: TextStyle(
                      color: Colors.white54,
                      fontFamily: 'Comfortaa-VariableFont_wght',
                      fontSize: 15)),
            ),
          ],
        ),
      ),
    );
  }
}
