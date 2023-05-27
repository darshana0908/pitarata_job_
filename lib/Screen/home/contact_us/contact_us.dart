import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:lottie/lottie.dart';
import 'package:pitarata_job/widget/custom_text_two.dart';

import '../../../color/colors.dart';
import '../../../widget/arrow_button.dart';
import '../../../widget/custom_text.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class ContactUs extends StatelessWidget {
  const ContactUs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black,
      appBar: AppBar(
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: ArrowButton(icons: Icons.arrow_back_ios_new)),
        backgroundColor: black,
        title: Container(
            alignment: Alignment.centerRight,
            child: CustomText(
              color: white,
              fontFamily: 'Comfortaa-VariableFont_wght',
              fontSize: 17,
              fontWeight: FontWeight.w900,
              text: 'Contact Us',
            )),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Container(
              alignment: Alignment.center,
              child: CustomText(
                  text: "Want to know\n more?",
                  fontSize: 40,
                  fontFamily: "Viga",
                  color: font_green,
                  fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: MediaQuery.of(context).size.height / 200,
                  horizontal: MediaQuery.of(context).size.width / 10),
              child: Lottie.asset('assets/contact_us.json'),
            ),
            Container(
              alignment: Alignment.center,
              child: CustomText(
                  text:
                      "Contact our friendly supporting officers,they\nare ready to assist you.",
                  fontSize: 14,
                  fontFamily: "Comfortaa-VariableFont_wght",
                  color: white,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: 300,
              alignment: Alignment.center,
              child: Row(
                children: [
                  SizedBox(
                      height: 40, child: Image.asset('assets/sms_ico.png')),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    'info@ratapitajobs.lk',
                    style: TextStyle(
                        fontSize: 20,
                        fontFamily: "Viga-Regular",
                        color: Colors.blue,
                        fontWeight: FontWeight.w300),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: 300,
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: 40, child: Image.asset('assets/web.png')),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    'wwww.ratapitajobs.lk',
                    style: TextStyle(
                        fontSize: 20,
                        fontFamily: "Viga-Regular",
                        color: Colors.blue,
                        fontWeight: FontWeight.w300),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              alignment: Alignment.center,
              height: 60,
              decoration: BoxDecoration(
                  color: Colors.grey, borderRadius: BorderRadius.circular(15)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: SizedBox(
                        height: 40, child: Image.asset('assets/fb.png')),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: SizedBox(
                        height: 40, child: Image.asset('assets/pinterest.png')),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: SizedBox(
                        height: 40, child: Image.asset('assets/insta.png')),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: SizedBox(
                        height: 40, child: Image.asset('assets/twitter.png')),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: SizedBox(
                        height: 40, child: Image.asset('assets/youtube.png')),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: SizedBox(
                        height: 40, child: Image.asset('assets/linikedin.png')),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              alignment: Alignment.center,
              child: CustomText(
                  text:
                      "Copyright @ 2023 joby (Pvt) Ltd.\n All rights reserved.",
                  fontSize: 14,
                  fontFamily: "Viga-Regular",
                  color: white,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              alignment: Alignment.center,
              child: CustomText(
                  text: "Powered by NovaTechZone (Pvt) Ltd",
                  fontSize: 14,
                  fontFamily: "Viga-Regular",
                  color: Color.fromARGB(255, 20, 50, 223),
                  fontWeight: FontWeight.bold),
            ),
          ]),
        ),
      ),
    );
  }
}
