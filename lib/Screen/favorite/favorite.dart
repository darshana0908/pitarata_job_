import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:pitarata_job/color/colors.dart';
import 'package:pitarata_job/db/sqldb.dart';
import 'package:pitarata_job/widget/arrow_button.dart';
import 'package:pitarata_job/widget/custom_grid.dart';
import 'package:pitarata_job/widget/custom_text.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../widget/radius_button.dart';
import '../home/single_job/single_job.dart';
import '../name_screen/name_screen.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({
    super.key,
  });

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  List gridList = [];
  SqlDb sqlDb = SqlDb();
  String id = '';
  bool userLoging = false;

  favoritesData() async {
    List resp = await sqlDb.readData("select * from favorite");
    log(resp.toString());
    setState(() {
      gridList = resp;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    userLogin();
    //
  }

  userLogin() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      var userLogin = sharedPreferences.getBool('userLoging');
      if (userLogin == true) {
        setState(() {
          favoritesData();
        });
      } else {
        setState(() {
          userLoging = false;
          userCheck();
        });
        log('kkkkkkkkkkkkkkkkkkddddddddddddddddddk');
      }
    });
  }

  userCheck() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
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
                      padding: const EdgeInsets.all(8.0),
                      child: CustomText(
                          text:
                              'Please login to your account to access your favorite jobs!',
                          fontSize: 20,
                          fontFamily: 'Comfortaa-VariableFont_wght',
                          color: white,
                          fontWeight: FontWeight.normal),
                    ),
                    SizedBox(
                      height: 35,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
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
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => NameScreen()),
                            );
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
                    ),
                  ],
                ),
              ),
            );
          });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black,
      body: SingleChildScrollView(
        child: GridView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            itemCount: gridList.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Stack(children: [
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: MediaQuery.of(context).size.height / 5,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: light_dark,
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: InkWell(
                        onTap: () {
                          log(gridList[index]['addId'].toString());
                          log(gridList[index]['job_whatsapp'].toString());
                          log(gridList[index]['job_mobile'].toString());
                          log(gridList[index]['job_email'].toString());
                          log(gridList[index]['job_salary'].toString());
                          log(gridList[index]['biz_category_name'].toString());
                          log(gridList[index]['description'].toString());

                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => SingleJob(
                          //               whatapp: gridList[index]['job_whatsapp']
                          //                   .toString(),
                          //               similarJob: gridList,
                          //               mobile: gridList[index]['job_mobile']
                          //                   .toString(),
                          //               email: gridList[index]['job_email']
                          //                   .toString(),
                          //               salary: gridList[index]['job_salary']
                          //                   .toString(),
                          //               categoryName: gridList[index]
                          //                       ['biz_category_name']
                          //                   .toString(),
                          //               addId: gridList[index]['ads_id']
                          //                   .toString(),
                          //               description: gridList[index]
                          //                       ['description']
                          //                   .toString(),
                          //               img:
                          //                   'https://pitaratajobs.novasoft.lk/${gridList[index]['main_image']}',
                          //             )));
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10)),
                          child: Image.network(
                            '${gridList[index]['img']}}',
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      decoration: BoxDecoration(
                          color: light_dark,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(15),
                              bottomRight: Radius.circular(15))),
                      height: 40,
                      width: 150,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CustomText(
                                text:
                                    gridList[index]['categoryName'].toString(),
                                fontSize: 12,
                                fontFamily: 'Comfortaa-VariableFont_wght',
                                color: white,
                                fontWeight: FontWeight.normal),
                          ),
                          Container(
                            alignment: Alignment.center,
                            child: Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    alert(
                                        'Are you sure you need to Share this record',
                                        false);
                                  },
                                  child: Icon(
                                    Icons.upload_sharp,
                                    color: background_green,
                                  ),
                                ),
                                InkWell(
                                  splashColor: font_gold,
                                  hoverColor: font_green,
                                  onTap: () {
                                    setState(() {
                                      id = gridList[index]['addId'].toString();
                                    });
                                    alert(
                                        'Are you sure you  need to remove this job from  your favorite list ?',
                                        true);
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Icon(
                                        Icons.delete_sharp,
                                        color: red,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ]),
              );
            }),
      ),
    );
  }

  alert(
    String text,
    bool item,
  ) async {
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
                  Row(
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
                            var res = await sqlDb.deleteData(
                                'delete from favorite  where addId = $id ');
                            setState(() {
                              favoritesData();
                            });
                          } else {
                            Share.share(
                                'Hey, I found this amazing job post in Pita Rata Jobs app. Check this out.\nhttps://pitaratajobs.novasoft.lk/single.php?id=$id\nDownload and try Pita Rata Jobs app.\nApp Link - https://shorturl.at/jwHPQ ');
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
