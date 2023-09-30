import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:lottie/lottie.dart';
import 'package:pitarata_job/widget/custom_text_two.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../color/colors.dart';
import '../../../widget/arrow_button.dart';
import '../../../widget/custom_text.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

import '../../../widget/radius_button.dart';

class WhatsAppCommunity extends StatelessWidget {
  const WhatsAppCommunity({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black,
      appBar: AppBar(
        leading: ArrowButton(
            onTap: () {
              Navigator.pop(context);
            },
            icons: Icons.arrow_back_ios_new),
        backgroundColor: black,
        title: Container(
            alignment: Alignment.centerRight,
            child: CustomText(
              color: white,
              fontFamily: 'Comfortaa-VariableFont_wght',
              fontSize: 17,
              fontWeight: FontWeight.w900,
              text: 'Community',
            )),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Container(
              alignment: Alignment.center,
              child: CustomText(text: "Join Our\nCommunity", fontSize: 40, fontFamily: "Viga", color: font_green, fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height / 200, horizontal: MediaQuery.of(context).size.width / 10),
              child: Lottie.asset('assets/about_us_image.json'),
            ),
            Container(
              alignment: Alignment.center,
              child: CustomText(
                  text: "Joining our job community help you network,find job lead, and gain support and knowledge,enhancing your career prospects.",
                  fontSize: 14,
                  fontFamily: "Comfortaa-VariableFont_wght",
                  color: white,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                alignment: Alignment.center,
                child: RadiusButton(
                    onTap: () async {
                      // String url = 'whatsapp://send?text=${Uri.encodeFull(groupLink)}';
                      final Uri _url = Uri.parse("https://chat.whatsapp.com/Kg3JsFB4EKoHo1MS32rT68");
                      print(_url);
                
                      if (!await launchUrl(mode: LaunchMode.externalNonBrowserApplication, _url)) {
                        throw Exception('Could not launch $_url');
                      }
                    },
                    text: 'JOIN NOW',
                    width: 250,
                    height: 70,
                    color: font_green,
                    colortext: white),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
