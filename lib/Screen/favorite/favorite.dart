import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:pitarata_job/color/colors.dart';
import 'package:pitarata_job/db/sqldb.dart';
import 'package:pitarata_job/widget/arrow_button.dart';
import 'package:pitarata_job/widget/custom_grid.dart';
import 'package:pitarata_job/widget/custom_text.dart';

import '../home/single_job/single_job.dart';

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
    favoritesData();
    //
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
                            'https://pitaratajobs.novasoft.lk/reso/post_2022_12_19/${gridList[index]['img']}}',
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
                                text: gridList[index]['biz_category_name']
                                    .toString(),
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
                                    // alert('Share this record');
                                  },
                                  child: Icon(
                                    Icons.upload_sharp,
                                    color: background_green,
                                  ),
                                ),
                                InkWell(
                                  splashColor: font_gold,
                                  hoverColor: font_green,
                                  // onTap: () {
                                  //   alert(
                                  //       'Are you sure you you need to remove this job from  your favorite list ?');
                                  // },
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
}
