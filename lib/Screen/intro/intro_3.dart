import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:lottie/lottie.dart';
import 'package:pitarata_job/Screen/welcom/welcom.dart';
import 'package:pitarata_job/color/colors.dart';

import '../../widget/arrow_button.dart';

class IntroThreePage extends StatefulWidget {
  const IntroThreePage({super.key});

  @override
  State<IntroThreePage> createState() => _IntroThreePageState();
}

class _IntroThreePageState extends State<IntroThreePage> {
  var asset;

  @override
  void initState() {
    loadAsset();
    // TODO: implement initState
    super.initState();
  }

  @override
  Future<String> loadAsset() async {
    return asset = await rootBundle.loadString('assets/intro_1.json');
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black,
      body: Column(children: [
        SizedBox(height: MediaQuery.of(context).size.height / 6),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 100),
          child: Lottie.asset('assets/intro_3.json'),
        ),
        SizedBox(height: MediaQuery.of(context).size.height / 7),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text(
              'Our mission is to help job seekers overcome barriers to finding work abroad, including language barriers, visa processes, and unfamiliar job search methods ',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white, fontFamily: 'Viga', fontSize: 27)),
        ),
        Expanded(
          child: Container(
            alignment: Alignment.bottomRight,
            child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => WelcomePage()),
                  );
                },
                child: ArrowButton(
                  icons: Icons.arrow_forward_ios_rounded,
                )),
          ),
        )
      ]),
    );
  }
}
