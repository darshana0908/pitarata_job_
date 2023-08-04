import 'dart:convert';
import 'dart:developer';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';

import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:pitarata_job/Screen/home/single_job/single_job.dart';
import 'package:pitarata_job/Screen/name_screen/name_screen.dart';
import 'package:pitarata_job/db/sqldb.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';
import '../color/colors.dart';
import 'custom_list.dart';
import 'custom_text.dart';
import 'package:http/http.dart' as http;
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'fade_home.dart';
import 'radius_button.dart';

class CustomHome extends StatefulWidget {
  const CustomHome(
      {super.key, required this.customerId, required this.userStatus});
  final String customerId;
  final bool userStatus;

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
  bool userStatus = false;
  int _current = 0;
  final CarouselController _controller = CarouselController();
  int _page = 0;

  bool _isFirstLoadRunning = false;
  bool _hasNextPage = true;
  bool _isLoadMoreRuning = false;
  late ScrollController mycontroller = ScrollController();
  SqlDb sqlDb = SqlDb();
  String addId = '';
  List favoritesList = [];
  bool x = false;
  String verification = '';
  String customer_id = '';
  bool setJob = false;
  String job_id = "";
  bool loadFavorites = false;
  bool noData = false;
  @override
  void initState() {
    getWallpaper();
    userLogin();

    // TODO: implement initState
    super.initState();

    mycontroller.addListener(() {
      if (mycontroller.position.maxScrollExtent ==
          mycontroller.position.pixels) {
        log('hhhhhhhh');
        _loadeMore();
      }
    });
  }

  userLogin() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    var z = sharedPreferences.getString('verification');
    var y = sharedPreferences.getString('customer_id');
    setState(() {
      verification = z.toString();
      customer_id = y.toString();
      log(customer_id);
    });

    log("verificatio" + verification);
    if (verification != '0') {
      await getFavouriteJobs();
      setState(() {
        userStatus = true;
      });
    } else {
      setState(() {
        userStatus = false;
      });
    }
  }

  getWallpaper() async {
    setState(() {
      isLoading = true;
    });
    var headers = {'Content-Type': 'application/json'};
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
        log('1');
        isLoading = false;
        getCategory();
      });
    }
  }

  getCategory() async {
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
    await getJobCategory();
    setState(() {
      cat.addAll(res['data']);
      jobCategoryName = cat;

      log('2');
      isLoading = false;
    });
  }

  void _loadeMore() async {
    log('jjjjjjjjjjjj');
    if (_hasNextPage == true &&
        _isFirstLoadRunning == false &&
        _isLoadMoreRuning == false) {
      setState(() {
        _isLoadMoreRuning = true;
      });
      _page += 50;
      var headers = {'Content-Type': 'application/json'};
      // request.headers.addAll(headers);
      var response = await http.post(
          Uri.parse(
              'https://pitaratajobs.novasoft.lk/_app_remove_server/nzone_server_nzone_api/getJobsToHome'),
          headers: headers,
          body: json.encode({
            "app_id": "nzone_4457Was555@qsd_job",
            "category_id": selected,
            "from": _page.toString(),
            "to": "50"
          }));
      var res = jsonDecode(response.body);
      List job = res['data'];
      if (job.isNotEmpty) {
        setState(() {
          jobCategory.addAll(job);
        });
      } else {
        setState(() {
          _hasNextPage = false;
        });
      }
      // job.addAll(res['data']);
      setState(() {
        _isLoadMoreRuning = false;
      });
    }
  }

  getJobCategory() async {
    setState(() {
      _isFirstLoadRunning = true;
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
          "from": 0,
          "to": "50"
        }));
    var res = jsonDecode(response.body.toString());

    if (res['data'].toString() == "[]") {
      setState(() {
        noData = true;
      });
    } else {
      setState(() {
        noData = false;
      });
    }
    setState(() {
      jobCategory = res['data'];

      _isFirstLoadRunning = false;
    });
  }

  setFavorite() async {
    log('bbbbbbbbbbbbbbbb');
    setState(() {
      loadFavorites = true;
    });
    var headers = {'Content-Type': 'application/json'};
    // request.headers.addAll(headers);
    var response = await http.post(
        Uri.parse(
            'https://pitaratajobs.novasoft.lk/_app_remove_server/nzone_server_nzone_api/setFavourite'),
        headers: headers,
        body: json.encode({
          "verification": verification,
          "app_id": "nzone_4457Was555@qsd_job",
          "customer_id": customer_id,
          "job_id": addId
        }));
    var res = jsonDecode(response.body.toString());
    setState(() {
      loadFavorites = false;
      getFavouriteJobs();
    });
  }

  getFavouriteJobs() async {
    setState(() {
      loadFavorites = true;
    });
    var headers = {'Content-Type': 'application/json'};
    // request.headers.addAll(headers);
    var response = await http.post(
        Uri.parse(
            'https://pitaratajobs.novasoft.lk/_app_remove_server/nzone_server_nzone_api/getFavouriteJobs'),
        headers: headers,
        body: json.encode({
          "app_id": "nzone_4457Was555@qsd_job",
          "verification": verification,
          "customer_id": customer_id
        }));
    var res = jsonDecode(response.body.toString());

    if (res['data'].toString() != "null") {
      setState(() {
        if (res['data'].toString().isNotEmpty) {
          favoritesList = res['data'];
          log('3');
        }
        loadFavorites = false;
        // _isFirstLoadRunning = false;
      });
    }
  }

  updateFavorites() {
    setState(() {
      FocusManager.instance.primaryFocus?.unfocus();
      getFavouriteJobs();
      log('fffffffffddddddddddddddddd');
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? AbsorbPointer(absorbing: isLoading, child: FadeHome())
        : SingleChildScrollView(
            controller: mycontroller,
            child: Column(
              children: [
                SizedBox(
                  child: Stack(
                    children: [
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            isLoading
                                ? Container(
                                    height:
                                        MediaQuery.of(context).size.height / 3,
                                    width: MediaQuery.of(context).size.width,
                                    child: Center(
                                        child: CircularProgressIndicator()))
                                : Container(
                                    width: MediaQuery.of(context).size.width,
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 1.0),
                                    decoration: BoxDecoration(color: black),
                                    child: CarouselSlider.builder(
                                      itemBuilder: (context, index, realIndex) {
                                        String img = wallPaper[index]
                                                ['image_path']
                                            .toString();
                                        return Container(
                                          child: Image.network(
                                            "https://pitaratajobs.novasoft.lk/$img",
                                            // i[index]['image_path'],
                                            fit: BoxFit.scaleDown,
                                          ),
                                        );
                                      },
                                      options: CarouselOptions(
                                          padEnds: false,
                                          viewportFraction: 1,
                                          autoPlay: true,
                                          enlargeCenterPage: true,
                                          aspectRatio: 2.0,
                                          autoPlayAnimationDuration:
                                              const Duration(
                                                  milliseconds: 2000),
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
                                children:
                                    wallPaper.asMap().entries.map((entry) {
                                  return GestureDetector(
                                    onTap: () =>
                                        _controller.animateToPage(entry.key),
                                    child: Container(
                                      width: 12.0,
                                      height: 12.0,
                                      margin: EdgeInsets.symmetric(
                                          vertical: 8.0, horizontal: 4.0),
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: (Theme.of(context)
                                                          .brightness ==
                                                      Brightness.dark
                                                  ? Colors.white
                                                  : Colors.white)
                                              .withOpacity(_current == entry.key
                                                  ? 0.9
                                                  : 0.4)),
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
                                        height: 70,
                                        child: ListView.builder(
                                            itemCount: jobCategoryName.length,
                                            scrollDirection: Axis.horizontal,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              String catName =
                                                  jobCategoryName[index]
                                                          ['category_name']
                                                      .toString();

                                              return InkWell(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                onTap: () {
                                                  setState(() {
                                                    selected =
                                                        jobCategoryName[index]
                                                            ['category_id'];
                                                  });
                                                  if (selected ==
                                                      jobCategoryName[index]
                                                          ['category_id']) {
                                                    log(selected);

                                                    getJobCategory();

                                                    setState(() {
                                                      selected;
                                                      color = true;
                                                    });
                                                  }
                                                },
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(6.0),
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    width: 100,
                                                    decoration: BoxDecoration(
                                                        boxShadow: <BoxShadow>[
                                                          BoxShadow(
                                                              color: Colors
                                                                  .white54,
                                                              blurRadius: 3.0,
                                                              offset: Offset(
                                                                  0.7, 0.7))
                                                        ],
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15),
                                                        color: selected ==
                                                                jobCategoryName[
                                                                        index][
                                                                    'category_id']
                                                            ? background_green
                                                            : light_dark),
                                                    child: CustomText(
                                                        text: catName,
                                                        fontSize: 15,
                                                        fontFamily: 'Viga',
                                                        color: white,
                                                        fontWeight:
                                                            FontWeight.normal),
                                                  ),
                                                ),
                                              );
                                            }),
                                      )

                                //  CustomList(cat: jobCategory),
                                ),

                            // jub category all

                            _isFirstLoadRunning
                                ? SizedBox(
                                    height: 500,
                                    child: Center(
                                        child: LoadingAnimationWidget
                                            .staggeredDotsWave(
                                                color: Colors.grey,
                                                size: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    6)),
                                  )
                                : jobCategory.length == 0
                                    ? Container(
                                        height: 500,
                                      )
                                    : ListView.builder(
                                        physics: NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: jobCategory.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          print(noData.toString());
                                          return noData
                                              ? Container(
                                                  height: MediaQuery.of(context)
                                                      .size
                                                      .height)
                                              : InkWell(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  onTap: () async {
                                                    if (userStatus == true) {
                                                      if (favoritesList.any((element) =>
                                                              element["ads_id"]
                                                                  .toString() ==
                                                              jobCategory[index]
                                                                      ["ads_id"]
                                                                  .toString()) ==
                                                          true) {
                                                        setState(() {
                                                          x = true;
                                                        });
                                                      } else {
                                                        setState(() {
                                                          x = false;
                                                        });
                                                      }
                                                    }
                                                    log(jobCategory[index]
                                                            ['job_category_id']
                                                        .toString());
                                                    await Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder:
                                                                (context) =>
                                                                    SingleJob(
                                                                      update:
                                                                          updateFavorites,
                                                                      x: x,
                                                                      categoryId:
                                                                          jobCategory[index]['job_category_id']
                                                                              .toString(),
                                                                      whatapp: jobCategory[index]
                                                                              [
                                                                              'job_whatsapp']
                                                                          .toString(),
                                                                      mobile: jobCategory[index]
                                                                              [
                                                                              'job_mobile']
                                                                          .toString(),
                                                                      email: jobCategory[index]
                                                                              [
                                                                              'job_email']
                                                                          .toString(),
                                                                      salary: jobCategory[index]
                                                                              [
                                                                              'job_salary']
                                                                          .toString(),
                                                                      categoryName:
                                                                          jobCategory[index]['biz_category_name']
                                                                              .toString(),
                                                                      addId: jobCategory[index]
                                                                              [
                                                                              'ads_id']
                                                                          .toString(),
                                                                      description:
                                                                          jobCategory[index]['description']
                                                                              .toString(),
                                                                      img:
                                                                          'https://pitaratajobs.novasoft.lk/${jobCategory[index]['main_image']}',
                                                                    )));
                                                  },
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        color: light_dark,
                                                        border: Border.all(
                                                            color: Colors.green,
                                                            width: 0.8),
                                                        borderRadius:
                                                            BorderRadius.only(
                                                                topRight: Radius
                                                                    .circular(
                                                                        20),
                                                                topLeft: Radius
                                                                    .circular(
                                                                        20),
                                                                bottomLeft: Radius
                                                                    .circular(
                                                                        15),
                                                                bottomRight: Radius
                                                                    .circular(
                                                                        15)),
                                                      ),
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height /
                                                              2.8,
                                                      child: joblist
                                                          ? Center(
                                                              child:
                                                                  CircularProgressIndicator())
                                                          : Stack(children: [
                                                              Positioned(
                                                                bottom: 0,
                                                                left: 0,
                                                                right: 0,
                                                                child:
                                                                    Container(
                                                                  alignment:
                                                                      Alignment
                                                                          .bottomLeft,
                                                                  decoration: BoxDecoration(
                                                                      color:
                                                                          light_dark,
                                                                      borderRadius: BorderRadius.only(
                                                                          bottomLeft: Radius.circular(
                                                                              20),
                                                                          bottomRight:
                                                                              Radius.circular(20))),
                                                                  height: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .height /
                                                                      4.2,
                                                                  width: double
                                                                      .infinity,
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    children: [
                                                                      Padding(
                                                                        padding:
                                                                            const EdgeInsets.all(8.0),
                                                                        child: CustomText(
                                                                            text: jobCategory[index][
                                                                                'biz_category_name'],
                                                                            fontSize:
                                                                                12,
                                                                            fontFamily:
                                                                                'Comfortaa-VariableFont_wght',
                                                                            color:
                                                                                white,
                                                                            fontWeight:
                                                                                FontWeight.w600),
                                                                      ),
                                                                      Padding(
                                                                        padding:
                                                                            const EdgeInsets.all(8.0),
                                                                        child: CustomText(
                                                                            text:
                                                                                "#${jobCategory[index]['ads_id'].toString()}",
                                                                            fontSize:
                                                                                10,
                                                                            fontFamily:
                                                                                'Comfortaa-VariableFont_wght',
                                                                            color:
                                                                                white,
                                                                            fontWeight:
                                                                                FontWeight.w300),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                              Positioned(
                                                                right: 0,
                                                                left: 0,
                                                                top: 0,
                                                                child:
                                                                    Container(
                                                                  height: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .height /
                                                                      3.2,
                                                                  width: double
                                                                      .infinity,
                                                                  decoration: BoxDecoration(
                                                                      color:
                                                                          light_dark,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              20)),
                                                                  child:
                                                                      ClipRRect(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            20),
                                                                    child:
                                                                        CachedNetworkImage(
                                                                      alignment:
                                                                          Alignment(
                                                                              -1,
                                                                              -1),
                                                                      imageUrl:
                                                                          "https://pitaratajobs.novasoft.lk/${jobCategory[index]['main_image']}",
                                                                      progressIndicatorBuilder: (context,
                                                                              url,
                                                                              downloadProgress) =>
                                                                          Center(
                                                                        child:
                                                                            SizedBox(
                                                                          height:
                                                                              50,
                                                                          width:
                                                                              50,
                                                                          child:
                                                                              CircularProgressIndicator(value: downloadProgress.progress),
                                                                        ),
                                                                      ),
                                                                      errorWidget: (context,
                                                                              url,
                                                                              error) =>
                                                                          Icon(Icons
                                                                              .error),
                                                                      fit: BoxFit
                                                                          .cover,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              Positioned(
                                                                right: 8,
                                                                child: IconButton(
                                                                    onPressed: () {
                                                                      if (userStatus ==
                                                                          true) {
                                                                        setState(
                                                                            () {
                                                                          addId =
                                                                              jobCategory[index]['ads_id'].toString();
                                                                          log(addId);
                                                                        });
                                                                        favoritesList.any((element) =>
                                                                                element["ads_id"].toString() ==
                                                                                jobCategory[index]["ads_id"].toString())
                                                                            ? alert(
                                                                                'You have already added this job to your favorite list!',
                                                                                true,
                                                                                true,
                                                                              )
                                                                            : setFavorite();

                                                                        setState(
                                                                            () {
                                                                          favoritesList;
                                                                        });
                                                                      } else {
                                                                        alert(
                                                                          'Please login to your account to add this job to your favorite list!',
                                                                          false,
                                                                          false,
                                                                        );
                                                                      }
                                                                    },
                                                                    icon: loadFavorites == true && jobCategory[index]['ads_id'].toString() == addId.toString()
                                                                        ? CircularProgressIndicator(
                                                                            color:
                                                                                red,
                                                                          )
                                                                        : ShaderMask(
                                                                            shaderCallback:
                                                                                (Rect bounds) {
                                                                              return LinearGradient(
                                                                                begin: Alignment.topCenter,
                                                                                end: Alignment.bottomCenter,
                                                                                colors: [
                                                                                  Colors.red,
                                                                                  Colors.orange
                                                                                ],
                                                                              ).createShader(bounds);
                                                                            },
                                                                            child:
                                                                                Icon(
                                                                              userStatus == true && favoritesList.any((element) => element["ads_id"].toString() == jobCategory[index]["ads_id"].toString()) ? Icons.favorite : Icons.favorite_border,
                                                                              color: userStatus == true && favoritesList.any((element) => element["ads_id"].toString() == jobCategory[index]["ads_id"].toString()) ? red : white,
                                                                            ),
                                                                          )),
                                                              ),
                                                            ]),
                                                    ),
                                                  ),
                                                );
                                        })
                          ]),
                      if (_isLoadMoreRuning == true)
                        Positioned(
                          bottom: 100,
                          left: 0,
                          right: 0,
                          child: Padding(
                            padding: const EdgeInsets.only(
                              bottom: 0,
                            ),
                            child: Center(
                                child: CircularProgressIndicator(
                              color: red,
                            )),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          );
  }

  alert(
    String text,
    bool item,
    bool save,
  ) async {
    return await showDialog(
        context: context,
        builder: (context) {
          var h = MediaQuery.of(context).size.height;
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
                  save
                      ? Container()
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            RadiusButton(
                              onTap: () {
                                Navigator.pop(context);
                                log('ggggg');
                              },
                              colortext: black,
                              color: Colors.white60,
                              height: h / 15,
                              width: 32.w,
                              text: item ? 'NO' : "Cancel",
                            ),
                            RadiusButton(
                              onTap: () async {
                                if (item == true) {
                                  Navigator.pop(context);
                                } else {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => NameScreen()),
                                  );
                                }
                              },
                              colortext: black,
                              color: font_green,
                              height: h / 15,
                              width: 32.w,
                              text: item ? 'YES' : "Login",
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
