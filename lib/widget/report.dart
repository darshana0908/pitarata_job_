import 'dart:developer';

import 'package:dropdown_below/dropdown_below.dart';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:pitarata_job/widget/radius_button.dart';

import '../color/colors.dart';
import 'custom_text.dart';

class Report extends StatefulWidget {
  const Report({super.key});

  @override
  State<Report> createState() => _ReportState();
}

class _ReportState extends State<Report> {
  List mobileList = [
    {'no': 1, 'mobile': 'Apple'},
    {'no': 2, 'mobile': 'Google'},
    {'no': 3, 'mobile': 'Samsung'},
    {'no': 4, 'mobile': 'Sony'},
    {'no': 5, 'mobile': 'LG'},
  ];
  List<DropdownMenuItem<Object?>> _dropdownTestItems = [];
  List<DropdownMenuItem<Object?>> buildDropdownTestItems(List mobileList) {
    List<DropdownMenuItem<Object?>> items = [];
    for (var i in mobileList) {
      items.add(
        DropdownMenuItem(
          value: i,
          child: Text(
            i['mobile'],
            style: TextStyle(color: Colors.black),
          ),
        ),
      );
    }
    return items;
  }

  @override
  void initState() {
    _dropdownTestItems = buildDropdownTestItems(mobileList);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String dropdownvalue = 'Apple';

    var selectedmobile;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
                text: 'Report this job post',
                fontSize: 27,
                fontFamily: 'Viga',
                color: red,
                fontWeight: FontWeight.w400),
            Divider(),
            SizedBox(
              height: 30,
            ),
            CustomText(
                text: 'Is there something wrong with this post?',
                fontSize: 27,
                fontFamily: 'Viga',
                color: black,
                fontWeight: FontWeight.w200),
            SizedBox(
              height: 30,
            ),
            Text(
              'Were constantly working hard to assure that our job posts meet high standards and we are very grateful for any kind of feedback from our users. ',
              style: TextStyle(
                fontSize: 27,
                fontFamily: 'Viga',
                color: Colors.black54,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Reasons',
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'Viga',
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Container(
                  height: 60,
                  width: 300,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black38),
                      borderRadius: BorderRadius.circular(2)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('-select a reasons'),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DropdownButton<String>(
                          borderRadius: BorderRadius.circular(4),
                          items:
                              <String>['A', 'B', 'C', 'D'].map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (_) {},
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Message',
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'Viga',
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                SizedBox(
                  width: 300,
                  child: TextField(
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 40.0),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 3, color: Colors.black38), //<-- SEE HERE
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Divider(),
            Container(
              alignment: Alignment.center,
              height: 60,
              width: 150,
              decoration: BoxDecoration(
                  color: red, borderRadius: BorderRadius.circular(5)),
              child: Text(
                'Send Report',
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Viga',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
