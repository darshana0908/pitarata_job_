import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:pitarata_job/Screen/home/job_contract/job_contact.dart';
import 'package:pitarata_job/color/colors.dart';
import 'package:pitarata_job/db/sqldb.dart';
import 'package:pitarata_job/widget/ad_area.dart';
import 'package:pitarata_job/widget/arrow_button.dart';
import 'package:pitarata_job/widget/custom_grid.dart';
import 'package:pitarata_job/widget/custom_text_two.dart';
import 'package:pitarata_job/widget/radius_button.dart';
import 'package:share_plus/share_plus.dart';

import '../../../widget/custom_container.dart';
import '../../../widget/custom_text.dart';
import '../../../widget/job_categories.dart';

class SingleJob extends StatefulWidget {
  const SingleJob(
      {super.key,
      required this.img,
      required this.description,
      required this.addId,
      required this.categoryName,
      required this.salary,
      required this.email,
      required this.mobile,
      required this.whatapp,
      required this.similarJob,
      required this.x});

  final String img;
  final String description;
  final String addId;
  final String categoryName;
  final String salary;
  final String email;
  final String mobile;
  final String whatapp;
  final List similarJob;
  final bool x;

  @override
  State<SingleJob> createState() => _SingleJobState();
}

class _SingleJobState extends State<SingleJob> {
  SqlDb sqlDb = SqlDb();
  String id = '';
  List favoritesList = [];
  bool selected = false;
  favoritesData() async {
    List resp = await sqlDb.readData("select * from favorite");

    setState(() {
      favoritesList = resp;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    log(widget.x.toString());
    // favoritesData();
  }

  ifselected() {
    favoritesList.any((element) => element["addId"].toString() == widget.addId);

    log(favoritesList
        .any((element) => element["addId"].toString() == widget.addId)
        .toString());
  }

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
              text: widget.categoryName,
            )),
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          SizedBox(
              width: double.infinity,
              // height: MediaQuery.of(context).size.height / 3,
              child: Image.network(
                widget.img,
                fit: BoxFit.contain,
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
                      text: 'Job id #${widget.addId}',
                    ),
                    Container(
                      child: Row(
                        children: [
                          IconButton(
                              onPressed: () {
                                if (widget.x == true) {
                                  alert('you already save this', true, true);
                                } else {
                                  alert('Are you sure you want to Save this? ',
                                      true, false);
                                }
                              },
                              icon: Icon(
                                widget.x
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: widget.x ? red : white,
                              )),
                          IconButton(
                              onPressed: () {
                                alert(
                                    'Are you sure you need to Share this record ?',
                                    false,
                                    false);
                              },
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
                    text: widget.description,
                  ),
                ),
                //bhbhbhbhbhggggg
                CustomContainer(
                    icon: 'assets/briefcase.svg',
                    text1: widget.categoryName,
                    text2: 'Job Category',
                    colorText: font_green),
                CustomContainer(
                    icon: 'assets/doller.svg',
                    text1: widget.salary,
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
                          MaterialPageRoute(
                              builder: (context) => JobContact(
                                    email: widget.email,
                                    mobile: widget.mobile,
                                    whatapp: widget.whatapp,
                                  )),
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
                  gridList: widget.similarJob,
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

  alert(String text, bool item, bool save) async {
    return await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15.0))),
            contentPadding: EdgeInsets.only(top: 10.0),
            backgroundColor: black,
            content: Container(
              height: 300,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: black, borderRadius: BorderRadius.circular(15)),
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.topRight,
                    child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.close,
                          color: Colors.white70,
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: CustomText(
                        text: text,
                        fontSize: 20,
                        fontFamily: 'Comfortaa-VariableFont_wght',
                        color: white,
                        fontWeight: FontWeight.normal),
                  ),
                  SizedBox(
                    height: 35,
                  ),
                  save && item
                      ? Container()
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            InkWell(
                              onTap: () async {
                                Navigator.pop(context);
                                log('ggggg');
                              },
                              child: RadiusButton(
                                colortext: black,
                                color: white,
                                height: 70,
                                width: 110,
                                text: 'NO',
                              ),
                            ),
                            InkWell(
                              onTap: () async {
                                if (item) {
                                  var res = await sqlDb.insertData(
                                      'INSERT INTO favorite ("img","description","addId","categoryName", "salary", "email" ,"mobile", "whatapp","similarJob") VALUES("${widget.img}","${widget.description}","${widget.addId}","${widget.categoryName}","${widget.salary}","${widget.email}","${widget.mobile}","${widget.whatapp}","${widget.similarJob}")');
                                  setState(() {
                                    favoritesData();
                                    favoritesList;
                                  });
                                  var resp = await sqlDb
                                      .readData("select * from favorite");
                                  log(resp.toString());
                                  Navigator.pop(context);
                                } else {
                                  Share.share(
                                      'Hey, I found this amazing job post in Pita Rata Jobs app. Check this out.\nhttps://pitaratajobs.novasoft.lk/single.php?id=${widget.addId}\nDownload and try Pita Rata Jobs app.\nApp Link - https://shorturl.at/jwHPQ ');
                                  log('ggggggggggg');
                                  log('ggggggggggg');
                                }

                                Navigator.pop(context);
                              },
                              child: RadiusButton(
                                colortext: black,
                                color: font_green,
                                height: 70,
                                width: 110,
                                text: 'YES',
                              ),
                            ),
                          ],
                        )
                ],
              ),
            ),
          );
        });
  }
}
