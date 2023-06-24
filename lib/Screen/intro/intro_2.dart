import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:pitarata_job/Screen/intro/intro_3.dart';
import 'package:pitarata_job/color/colors.dart';
import 'package:sizer/sizer.dart';
import '../../widget/arrow_button.dart';

class IntroTwoPage extends StatefulWidget {
  const IntroTwoPage({super.key});

  @override
  State<IntroTwoPage> createState() => _IntroTwoPageState();
}

class _IntroTwoPageState extends State<IntroTwoPage> {
  var asset;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black,
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(children: [
            SizedBox(height: MediaQuery.of(context).size.height / 15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: Lottie.asset('assets/intro_2.json'),
            ),
            SizedBox(height: MediaQuery.of(context).size.height / 30),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                  ' Find your dream job easily with Pita Rata Jobs.We bring together ob postiongs from around the world, across all industries and job categories.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Viga',
                      fontSize: 20.sp)),
            ),
            Expanded(
              child: Container(
                alignment: Alignment.bottomRight,
                child: ArrowButton(onTap:  () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => IntroThreePage()),
                  );
                },
                  icons: Icons.arrow_forward_ios_rounded,
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
