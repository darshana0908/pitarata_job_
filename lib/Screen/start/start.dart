import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:pitarata_job/Screen/name_screen/name_screen.dart';
import 'package:pitarata_job/color/colors.dart';
import 'package:pitarata_job/widget/custom_text.dart';
import 'package:pitarata_job/widget/radius_button.dart';

class Start extends StatefulWidget {
  const Start({super.key, required this.text});
  final String text;
  @override
  State<Start> createState() => _StartState();
}

class _StartState extends State<Start> {
  loading() {}
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return loading();
      },
      child: Scaffold(
        backgroundColor: black,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 6,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 60),
              child: Lottie.asset('assets/account_created_success.json'),
            ),
            SizedBox(
              height: 30,
            ),
            CustomText(
                fontWeight: FontWeight.normal,
                color: white,
                text:widget.text,
                    
                fontSize: 28,
                fontFamily: 'Viga'),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => NameScreen()));
                  },
                  child: RadiusButton(
                    colortext: white,
                    color: font_green,
                    text: 'Login to my account',
                    width: 230,
                    height: 60,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
          ]),
        ),
      ),
    );
  }
}
