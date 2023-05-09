import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:pitarata_job/widget/ad_area.dart';

import '../../../color/colors.dart';
import '../../../widget/arrow_button.dart';
import '../../../widget/color_container.dart';
import '../../../widget/custom_container.dart';
import '../../../widget/custom_text.dart';
import '../../../widget/custom_text_two.dart';

class JobContact extends StatelessWidget {
  const JobContact({super.key});

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
              text: 'Apply for the job',
            )),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            ColorContainer(
              iconColor: red,
              textColor: red,
              text: 'Email Address',
              text1: ' info@novatechzone.com',
              icon: Icons.email_outlined,
              color1: black,
              color: Color.fromARGB(255, 93, 9, 3),
            ),
            ColorContainer(
              iconColor: background_green,
              textColor: background_green,
              text: 'Contact Number',
              text1: '+94115812710',
              icon: Icons.add_call,
              color1: black,
              color: Color.fromARGB(43, 4, 115, 45),
            ),
            ColorContainer(
              iconColor: Color.fromARGB(255, 12, 20, 168),
              textColor: Color.fromARGB(255, 12, 20, 168),
              text: 'Whats app Number',
              text1: '+94115812710',
              icon: Icons.whatsapp_rounded,
              color1: black,
              color: Color.fromARGB(255, 4, 22, 75),
            ),
            AdArea(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: CustomTextTwo(
                color: white,
                fontFamily: 'Comfortaa-VariableFont_wght',
                fontSize: 13,
                fontWeight: FontWeight.bold,
                text: 'Love this job ? Apply now!',
              ),
            ),
            InkWell(
              onTap: () {},
              child: CustomContainer(
                  icon: 'assets/send.svg',
                  text1: 'Send My CV to this Job',
                  text2: 'Easily apply for the job',
                  colorText: font_green),
            ),
          ]),
        ),
      ),
    );
  }
}
