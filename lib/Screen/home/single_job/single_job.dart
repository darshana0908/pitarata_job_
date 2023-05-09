import 'package:flutter/material.dart';
import 'package:pitarata_job/Screen/home/job_contract/job_contact.dart';
import 'package:pitarata_job/color/colors.dart';
import 'package:pitarata_job/widget/ad_area.dart';
import 'package:pitarata_job/widget/arrow_button.dart';
import 'package:pitarata_job/widget/custom_grid.dart';
import 'package:pitarata_job/widget/custom_text_two.dart';
import 'package:pitarata_job/widget/radius_button.dart';

import '../../../widget/custom_container.dart';
import '../../../widget/custom_text.dart';
import '../../../widget/job_categories.dart';

class SingleJob extends StatelessWidget {
  const SingleJob({super.key, required this.cat, required this.img});
  final String cat;
  final String img;

  @override
  Widget build(BuildContext context) {
    List cat = [' All', 'Cat 1', 'Cat 2', 'Cat 3', 'Cat 4'];
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
              text: 'Job Category',
            )),
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          SizedBox(
              width: double.infinity,
              height: MediaQuery.of(context).size.height / 3,
              child: Image.asset(
                img,
                fit: BoxFit.fill,
              )),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      color: Colors.white60,
                      fontFamily: 'Comfortaa-VariableFont_wght',
                      fontSize: 13,
                      fontWeight: FontWeight.normal,
                      text: 'Job id # 1252',
                    ),
                    Container(
                      child: Row(
                        children: [
                          IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.favorite_border,
                                color: white,
                              )),
                          IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.share,
                                color: font_green,
                              ))
                        ],
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: CustomTextTwo(
                    color: font_gold,
                    fontFamily: 'Comfortaa-VariableFont_wght',
                    fontSize: 17,
                    fontWeight: FontWeight.normal,
                    text:
                        'Job description coes heare.The full description of the ob coes heare.This area is for the details of the ob. All details can be found in this section.',
                  ),
                ),
                //bhbhbhbhbhggggg
                CustomContainer(
                    icon: 'assets/briefcase.svg',
                    text1: 'Job Category Name',
                    text2: 'Job Category',
                    colorText: font_green),
                CustomContainer(
                    icon: 'assets/doller.svg',
                    text1: 'SEK 100 - SEK 200',
                    text2: 'salary',
                    colorText: Colors.blue),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: Divider(
                    color: white,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: CustomTextTwo(
                    color: white,
                    fontFamily: 'Comfortaa-VariableFont_wght',
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    text: 'Love this job ?',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    alignment: Alignment.center,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => JobContact()),
                        );
                      },
                      child: RadiusButton(
                          text: 'Show Contact Details',
                          width: 250,
                          height: 70,
                          color: font_green,
                          colortext: white),
                    ),
                  ),
                ),
                AdArea(),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: CustomTextTwo(
                    color: white,
                    fontFamily: 'Comfortaa-VariableFont_wght',
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    text: 'Other similar jobs you may love',
                  ),
                ),
                SizedBox(
                    child: CustomGrid(
                  row: false,
                )),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: AdArea(),
                ),
                TextButton(
                  onPressed: () {},
                  child: Container(
                    alignment: Alignment.center,
                    height: 60,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: red, borderRadius: BorderRadius.circular(15)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Container(
                            alignment: Alignment.centerLeft,
                            child: Icon(
                              Icons.warning_amber_rounded,
                              color: white,
                              size: 50,
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          child: CustomText(
                            color: white,
                            fontFamily: 'Comfortaa-VariableFont_wght',
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            text: 'Report this post',
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Container(
                            width: 40,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextButton(
                    onPressed: () {},
                    child: Container(
                      alignment: Alignment.center,
                      child: CustomText(
                        color: white,
                        fontFamily: 'Comfortaa-VariableFont_wght',
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        text: 'Send feedback about our Help Center',
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ]),
      ),
    );
  }
}
