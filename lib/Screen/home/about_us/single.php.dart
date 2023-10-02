import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:lottie/lottie.dart';


import '../../../color/colors.dart';
import '../../../widget/arrow_button.dart';
import '../../../widget/custom_text.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class AboutUs extends StatefulWidget {
  const AboutUs({super.key, required this.id});
  final String id;

  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  @override
  void initState() {
    print("gggggggg${widget.id}");
    // TODO: implement initState
    super.initState();
  }

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
              text: 'About Us',
            )),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Container(
              alignment: Alignment.center,
              child:
                  CustomText(text: "Find your next job\n with us", fontSize: 40, fontFamily: "Viga", color: font_green, fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height / 200, horizontal: MediaQuery.of(context).size.width / 10),
              child: Lottie.asset('assets/about_us_image.json'),
            ),
            Container(
              alignment: Alignment.center,
              child: CustomText(
                  text:
                      '"Pitarata Jobs පිට රට ජොබ්ස් (Foreign Jobs)" is an exclusive platform that has been developed in collaboration with numerous job agencies, bringing together leading recruiters and offering a vast selection of international job opportunities across various levels.\n\nAs one of the foremost international job marketplaces based in Singapore and Sri Lanka, Pitarata Jobs is dedicated to providing access to the best and highest-paying job positions worldwide. Our marketplace caters to a diverse range of job seekers, including those looking for roles such as cleaners, drivers, helpers, caretakers, welders, and many more.\n\nAt Pitarata Jobs, we prioritize ensuring that your applications are seamlessly submitted to the relevant job agencies, enabling them to facilitate you through the subsequent stages of the recruitment process. With our latest job marketplace app, you are not limited to applying for a single vacancy but can explore multiple opportunities that align with your unique talents.\n\nWe warmly invite you to embark on your journey with Pitarata Jobs, where you can explore a world of possibilities and pave the way for a brighter future for yourself, your family, and friends, while attaining financial freedom. Join us today and unlock a realm of exciting international job prospects.\n\nPitarata Jobs හොඳම රට ජොබ්ස්',
                  fontSize: 14,
                  fontFamily: "Comfortaa-VariableFont_wght",
                  color: white,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20,
            ),
            GradientText(
              'The best place to find your dream job',
              style: TextStyle(fontSize: 20, fontFamily: "Viga", color: font_green, fontWeight: FontWeight.bold),
              colors: [font_green, white],
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              alignment: Alignment.center,
              child: CustomText(
                  text: "Copyright @ 2023 joby (Pvt) Ltd.\n All rights reserved.",
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
