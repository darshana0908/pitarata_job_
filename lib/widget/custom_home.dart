import 'dart:convert';
import 'dart:developer';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:pitarata_job/Screen/home/single_job/single_job.dart';
import '../color/colors.dart';
import 'custom_list.dart';
import 'custom_text.dart';
import 'package:http/http.dart' as http;

class CustomHome extends StatefulWidget {
  const CustomHome({super.key});

  @override
  State<CustomHome> createState() => _CustomHomeState();
}

class _CustomHomeState extends State<CustomHome> {
  String selected = '0';
  bool color = false;
  List wallPaper = [];
  List jobCategory = [];
  List jobCategoryName = [];
  bool isLoading = false;
  bool joblist = false;
  int _current = 0;
  final CarouselController _controller = CarouselController();

  @override
  void initState() {
    // getTextData();
    getWallpaper();

    // TODO: implement initState
    super.initState();
  }

  getWallpaper() async {
    setState(() {
      isLoading = true;
    });

    var headers = {'Content-Type': 'application/json'};

    // request.headers.addAll(headers);
    var response = await http.post(
        Uri.parse(
            'https://pitaratajobs.novasoft.lk/_app_remove_server/nzone_server_nzone_api/getHomeWallpapers'),
        headers: headers,
        body: json.encode({"app_id": "nzone_4457Was555@qsd_job"}));
    var res = jsonDecode(response.body.toString());
    List img = res['data'];

    if (img.isNotEmpty) {
      setState(() {
        wallPaper = img;

        isLoading = false;
        getCategory();
      });
    }
  }

  Future getCategory() async {
    setState(() {
      isLoading = true;
    });

    var headers = {'Content-Type': 'application/json'};

    // request.headers.addAll(headers);
    var response = await http.post(
        Uri.parse(
            'https://pitaratajobs.novasoft.lk/_app_remove_server/nzone_server_nzone_api/getCategory'),
        headers: headers,
        body: json.encode({"app_id": "nzone_4457Was555@qsd_job"}));
    var res = jsonDecode(response.body.toString());

    List cat = [
      {"category_id": "0", "category_name": "All"}
    ];

    setState(() {
      cat.addAll(res['data']);
      jobCategoryName = cat;
      getJobCategory();
      isLoading = false;
    });
  }

  getJobCategory() async {
    setState(() {
      joblist = true;
    });

    var headers = {'Content-Type': 'application/json'};

    // request.headers.addAll(headers);
    var response = await http.post(
        Uri.parse(
            'https://pitaratajobs.novasoft.lk/_app_remove_server/nzone_server_nzone_api/getJobsToHome'),
        headers: headers,
        body: json.encode({
          "app_id": "nzone_4457Was555@qsd_job",
          "category_id": selected,
          "from": "0",
          "to": "50"
        }));
    var res = jsonDecode(response.body.toString());
    List job = [];
    job.addAll(res['data']);
    setState(() {
      // log('gccfcfcfcfc' + res['data'].toString());
      // log(res.toString());

      jobCategory = job;
      log(jobCategory.toString());

      joblist = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          isLoading
              ? Container(
                  height: MediaQuery.of(context).size.height / 3,
                  width: MediaQuery.of(context).size.width,
                  child: Center(child: CircularProgressIndicator()))
              : Container(
                  height: MediaQuery.of(context).size.height / 3,
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.symmetric(horizontal: 1.0),
                  decoration: BoxDecoration(color: black),
                  child: CarouselSlider.builder(
                    itemBuilder: (context, index, realIndex) {
                      String img = wallPaper[index]['image_path'].toString();
                      return Container(
                        child: Image.network(
                          "https://pitaratajobs.novasoft.lk/$img",
                          // i[index]['image_path'],
                          fit: BoxFit.cover,
                        ),
                      );
                    },
                    options: CarouselOptions(
                        padEnds: false,
                        viewportFraction: 1,
                        height: 300,
                        autoPlay: true,
                        enlargeCenterPage: true,
                        aspectRatio: 2.0,
                        autoPlayAnimationDuration:
                            const Duration(milliseconds: 2000),
                        onPageChanged: (index, reason) {
                          setState(() {
                            _current = index;
                          });
                        }),
                    itemCount: wallPaper.length,
                  ),
                ),

          // ),
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: wallPaper.asMap().entries.map((entry) {
                return GestureDetector(
                  onTap: () => _controller.animateToPage(entry.key),
                  child: Container(
                    width: 12.0,
                    height: 12.0,
                    margin:
                        EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: (Theme.of(context).brightness == Brightness.dark
                                ? Colors.white
                                : Colors.white)
                            .withOpacity(_current == entry.key ? 0.9 : 0.4)),
                  ),
                );
              }).toList()),

          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 8,
            ),
            child: CustomText(
                text: 'Job Categories',
                fontSize: 17,
                fontFamily: 'Comfortaa-VariableFont_wght',
                color: white,
                fontWeight: FontWeight.normal),
          ),
          SizedBox(
            height: 10,
          ),

          // category name list
          Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
              ),
              child: isLoading
                  ? Center(
                      child: SizedBox(
                      height: 15,
                      width: 15,
                      child: CircularProgressIndicator(
                        color: Colors.white30,
                      ),
                    ))
                  : Container(
                      height: 130,
                      child: ListView.builder(
                          itemCount: jobCategoryName.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (BuildContext context, int index) {
                            String catName = jobCategoryName[index]
                                    ['category_name']
                                .toString();

                            return InkWell(
                              onTap: () {
                                setState(() {
                                  selected =
                                      jobCategoryName[index]['category_id'];
                                });
                                if (selected ==
                                    jobCategoryName[index]['category_id']) {
                                  log(selected);

                                  getJobCategory();

                                  setState(() {
                                    selected;
                                    color = true;
                                  });
                                }
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Container(
                                  width: 120,
                                  height: 120,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: selected ==
                                              jobCategoryName[index]
                                                  ['category_id']
                                          ? background_green
                                          : light_dark),
                                  child: Column(children: [
                                    Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Image.asset(
                                        'assets/c1.PNG',
                                        scale: 2,
                                      ),
                                    ),
                                    SingleChildScrollView(
                                      child: catName == "null"
                                          ? CircularProgressIndicator()
                                          : CustomText(
                                              text: catName,
                                              fontSize: 15,
                                              fontFamily: 'Viga',
                                              color: white,
                                              fontWeight: FontWeight.normal),
                                    )
                                  ]),
                                ),
                              ),
                            );
                          }),
                    )

              //  CustomList(cat: jobCategory),
              ),

          // jub category all

          Container(
            child: ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: jobCategory.length,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SingleJob(
                                    whatapp: jobCategory[index]['job_whatsapp']
                                        .toString(),
                                    similarJob: jobCategory,
                                    mobile: jobCategory[index]['job_mobile']
                                        .toString(),
                                    email: jobCategory[index]['job_email']
                                        .toString(),
                                    salary: jobCategory[index]['job_salary']
                                        .toString(),
                                    categoryName: jobCategory[index]
                                            ['biz_category_name']
                                        .toString(),
                                    addId:
                                        jobCategory[index]['ads_id'].toString(),
                                    description: jobCategory[index]
                                            ['description']
                                        .toString(),
                                    img:
                                        'https://pitaratajobs.novasoft.lk/${jobCategory[index]['main_image']}',
                                  )));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: MediaQuery.of(context).size.height / 2.8,
                        child: joblist
                            ? Center(child: CircularProgressIndicator())
                            : Stack(children: [
                                Positioned(
                                  bottom: 0,
                                  left: 0,
                                  right: 0,
                                  child: Container(
                                    alignment: Alignment.bottomLeft,
                                    decoration: BoxDecoration(
                                        color: light_dark,
                                        borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(10),
                                            bottomRight: Radius.circular(10))),
                                    height: MediaQuery.of(context).size.height /
                                        4.2,
                                    width: double.infinity,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: CustomText(
                                              text: jobCategory[index]
                                                  ['biz_category_name'],
                                              fontSize: 12,
                                              fontFamily:
                                                  'Comfortaa-VariableFont_wght',
                                              color: white,
                                              fontWeight: FontWeight.normal),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 0,
                                  right: 0,
                                  left: 0,
                                  child: Container(
                                    height: MediaQuery.of(context).size.height /
                                        3.2,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        color: light_dark,
                                        borderRadius:
                                            BorderRadius.circular(50)),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Image.network(
                                        'https://pitaratajobs.novasoft.lk/${jobCategory[index]['main_image']}',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  right: 8,
                                  child: IconButton(
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.favorite_border,
                                        color: white,
                                      )),
                                ),
                              ]),
                      ),
                    ),
                  );
                }),
          )
        ]),
      ),
    );
  }
}
