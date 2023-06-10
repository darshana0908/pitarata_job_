import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:pitarata_job/color/colors.dart';
import 'package:pitarata_job/widget/custom_text.dart';
import 'package:pitarata_job/widget/radius_button.dart';

import '../Screen/home/single_job/single_job.dart';

class CustomGrid extends StatefulWidget {
  const CustomGrid(
      {super.key,
      required this.row,
      required this.gridList,
      required this.x,
      required this.update});

  final bool row;
  final List gridList;
  final bool x;
  final Function update;

  @override
  State<CustomGrid> createState() => _CustomGridState();
}

class _CustomGridState extends State<CustomGrid> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    log(widget.gridList.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GridView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          itemCount: widget.gridList.length.clamp(0, 6),
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
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SingleJob(
                                      update: widget.update,
                                      categoryId: widget.gridList[index]
                                              ['biz_category_id']
                                          .toString(),
                                      x: true,
                                      whatapp: widget.gridList[index]
                                              ['job_whatsapp']
                                          .toString(),
                                      mobile: widget.gridList[index]
                                              ['job_mobile']
                                          .toString(),
                                      email: widget.gridList[index]['job_email']
                                          .toString(),
                                      salary: widget.gridList[index]
                                              ['job_salary']
                                          .toString(),
                                      categoryName: widget.gridList[index]
                                              ['biz_category_name']
                                          .toString(),
                                      addId: widget.gridList[index]['ads_id']
                                          .toString(),
                                      description: widget.gridList[index]
                                              ['description']
                                          .toString(),
                                      img:
                                          'https://pitaratajobs.novasoft.lk/${widget.gridList[index]['main_image']}',
                                    )));
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        child: Image.network(
                          alignment: Alignment(-1, -1),
                          'https://pitaratajobs.novasoft.lk/${widget.gridList[index]['main_image']}',
                          fit: BoxFit.cover,
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
                              text: widget.gridList[index]['biz_category_name']
                                  .toString(),
                              fontSize: 12,
                              fontFamily: 'Comfortaa-VariableFont_wght',
                              color: white,
                              fontWeight: FontWeight.normal),
                        ),
                        widget.row
                            ? Container(
                                alignment: Alignment.center,
                                child: Row(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        alert('Share this record');
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
                                        alert(
                                            'Are you sure you you need to remove this job from  your favorite list ?');
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
                            : Container()
                      ],
                    ),
                  ),
                )
              ]),
            );
          }),
    );
  }

  alert(String text) async {
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
                      TextButton(
                        onPressed: () {
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
                      TextButton(
                        onPressed: () {},
                        child: RadiusButton(
                          colortext: black,
                          color: red,
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
  }
}
