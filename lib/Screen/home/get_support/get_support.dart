import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../../color/colors.dart';
import '../../../widget/arrow_button.dart';
import '../../../widget/custom_text.dart';
import '../../../widget/custom_text_two.dart';

class GetSupport extends StatelessWidget {
  const GetSupport({super.key});

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
              text: 'Get Support',
            )),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Stack(children: [
            SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height,
                child: ListView.builder(
                    itemCount: 5,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Container(
                          child: Column(children: [
                            Container(
                              padding: EdgeInsets.all(16),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: light_dark,
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(15),
                                      topLeft: Radius.circular(15))),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomTextTwo(
                                    color: white,
                                    fontFamily: 'Comfortaa-VariableFont_wght',
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    text: 'Question',
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    alignment: Alignment.centerRight,
                                    child: CustomTextTwo(
                                      color: white,
                                      fontFamily: 'Comfortaa-VariableFont_wght',
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                      text:
                                          'This is my question.I need to know more details about your job pasting .I just applied for a job. But I did not get any answer Yet.',
                                    ),
                                  ),
                                  Container(
                                      alignment: Alignment.bottomRight,
                                      child: Text(
                                        ' 2022-10-26 10:21 AM',
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontFamily:
                                                'Comfortaa-VariableFont_wght',
                                            color: Colors.white60,
                                            fontWeight: FontWeight.normal),
                                      )),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(16),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: font_green,
                                  borderRadius: BorderRadius.only(
                                      bottomRight: Radius.circular(15),
                                      bottomLeft: Radius.circular(15))),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomTextTwo(
                                    color: black,
                                    fontFamily: 'Comfortaa-VariableFont_wght',
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    text: 'Answer',
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  CustomTextTwo(
                                    color: black,
                                    fontFamily: 'Comfortaa-VariableFont_wght',
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    text:
                                        'This is the answer fro admin. Hello this is our answer',
                                  ),
                                  Container(
                                      alignment: Alignment.bottomRight,
                                      child: Text(
                                        ' 2022-10-26 10:21 AM',
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontFamily:
                                                'Comfortaa-VariableFont_wght',
                                            color: black,
                                            fontWeight: FontWeight.normal),
                                      )),
                                ],
                              ),
                            )
                          ]),
                        ),
                      );
                    }),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: TextField(
                style: TextStyle(color: white),
                decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 15, horizontal: 16),
                    suffixIcon: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Icon(
                        Icons.send_sharp,
                        color: background_green,
                        size: 50,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderSide:
                          BorderSide(width: 5, color: Colors.greenAccent),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    filled: true,
                    hintStyle: TextStyle(color: Colors.grey[600]),
                    hintText: 'type your question... we will answer...',
                    fillColor: light_dark),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
