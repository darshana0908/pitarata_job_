import 'dart:convert';
import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:pitarata_job/Screen/home/job_contract/job_contact.dart';
import 'package:pitarata_job/color/colors.dart';
import 'package:pitarata_job/db/sqldb.dart';
import 'package:pitarata_job/widget/ad_area.dart';
import 'package:pitarata_job/widget/arrow_button.dart';
import 'package:pitarata_job/widget/custom_grid.dart';
import 'package:pitarata_job/widget/custom_text_two.dart';
import 'package:pitarata_job/widget/radius_button.dart';
import 'package:pitarata_job/widget/report.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:sizer/sizer.dart';
import '../../../class/add.dart';
import '../../../class/main_dialog.dart';
import '../../../widget/custom_container.dart';
import '../../../widget/custom_text.dart';
import '../../../widget/feedback_button.dart';
import '../../../widget/job_categories.dart';
import '../../name_screen/name_screen.dart';

class SingleJob extends StatefulWidget {
  SingleJob(
      {super.key,
      // required this.img,
      // required this.description,
      required this.addId,
      // required this.categoryName,
      // required this.salary,
      // required this.email,
      // required this.mobile,
      // required this.whatapp,
      // required this.categoryId,
      required this.x,
      required this.update});

  // final String img;
  // final String description;
  final String addId;
  // final String categoryName;
  // final String salary;
  // final String email;
  // final String mobile;
  // final String whatapp;
  // final String categoryId;
  final Function update;

  bool x;

  @override
  State<SingleJob> createState() => _SingleJobState();
}

class _SingleJobState extends State<SingleJob> {
  TextEditingController controller = TextEditingController();
  TextEditingController controller2 = TextEditingController();
  bool verified = false;
  // SqlDb sqlDb = SqlDb();
  String id = '';
  List favoritesList = [];
  List getSimilarJobsList = [];
  bool selected = false;
  bool loading = false;
  String verification = '';
  String customer_id = '';
  bool seFavorites = false;
  String dropText = 'select a reasons';
  bool tap = false;
  BannerAd? _bannerAd;
  bool isLoading = false;

  bool _isLoaded = false;

  String img = '';
  String description = '';
  String addId = '';
  String categoryName = '';
  String salary = '';
  String email = '';
  String mobile = '';
  String whatapp = '';
  String categoryId = '';
  // favoritesData() async {
  //   List resp = await sqlDb.readData("select * from favorite");

  //   setState(() {
  //     favoritesList = resp;
  //   });
  // }

  @override
  void initState() {
    print(widget.addId);
    getSingleJobDetails();
    FocusManager.instance.primaryFocus?.unfocus();
    // TODO: implement initState

    super.initState();

    // favoritesData();
    getSimilarJobs();
    userLogin();
    loadAd();
  }

  // TODO: replace this test ad unit with your own ad unit.

  final adUnitId = 'ca-app-pub-3940256099942544/6300978111';

  /// Loads a banner ad.

  // ifselected() {
  //   favoritesList.any((element) => element["addId"].toString() == addId);
  // }

  getSimilarJobs() async {
    setState(() {
      loading = true;
    });
    var headers = {'Content-Type': 'application/json'};
    var response = await http.post(Uri.parse('https://pitaratajobs.novasoft.lk/_app_remove_server/nzone_server_nzone_api/getSimilarJobs'),
        headers: headers, body: json.encode({"app_id": "nzone_4457Was555@qsd_job", "job_category_id": categoryId}));

    var res = jsonDecode(response.body.toString());

    setState(() {
      loading = false;
      getSimilarJobsList = res['data'];
    });
  }

  reportThisJob() async {
    setState(() {
      // loading = true;
    });
    var headers = {'Content-Type': 'application/json'};
    var response = await http.post(Uri.parse('https://pitaratajobs.novasoft.lk/_app_remove_server/nzone_server_nzone_api/reportThisJob'),
        headers: headers,
        body: json.encode({
          "verification": verification,
          "app_id": "nzone_4457Was555@qsd_job",
          "customer_id": customer_id,
          "job_id": addId,
          "reason": dropText,
          "message": controller.text
        }));

    var res = jsonDecode(response.body);

    String msg = res['msg'];
    if (res['status'].toString() == "1") {
      setState(() {
        dropText = 'select a reasons';
        controller.clear();
      });

      Navigator.pop(context);

      MotionToast.info(title: Text("Info"), description: Text(msg)).show(context);
    } else {
      MotionToast.error(title: Text("error"), description: Text(msg)).show(context);
    }

    setState(() {});
  }

  sendFeedbackForJob() async {
    setState(() {
      // loading = true;
    });
    var headers = {'Content-Type': 'application/json'};
    var response = await http.post(Uri.parse('https://pitaratajobs.novasoft.lk/_app_remove_server/nzone_server_nzone_api/sendFeedbackForJob'),
        headers: headers,
        body: json.encode({
          "verification": verification,
          "app_id": "nzone_4457Was555@qsd_job",
          "customer_id": customer_id,
          "job_id": addId,
          "feedback": controller2.text,
        }));

    var res = jsonDecode(response.body);

    String msg = res['msg'];
    if (res['status'].toString() == "1") {
      setState(() {
        dropText = 'select a reasons';
        controller.clear();
      });

      Navigator.pop(context);

      MotionToast.info(title: Text("Info"), description: Text(msg)).show(context);
    } else {
      MotionToast.error(title: Text("error"), description: Text(msg)).show(context);
    }

    setState(() {});
  }

  userLogin() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    var z = sharedPreferences.getString('verification');
    var y = sharedPreferences.getString('customer_id');
    getSingleJobDetails();
    setState(() {
      verification = z.toString();
      customer_id = y.toString();
    });

    if (verification != '0') {
      await updateJobView(customer_id);
      setState(() {
        verified = true;
      });
    } else {
      updateJobView("0");
      setState(() {
        verified = false;
      });
    }
  }

  updateJobView(String Cid) async {
    setState(() {
      // _isFirstLoadRunning = true;
    });

    var headers = {'Content-Type': 'application/json'};

    // request.headers.addAll(headers);
    var response = await http.post(Uri.parse('https://pitaratajobs.novasoft.lk/_app_remove_server/nzone_server_nzone_api/updateJobView'),
        headers: headers,
        body: json.encode({
          "app_id": "nzone_4457Was555@qsd_job",
          "customer_id": verified ? customer_id : "0",
          "job_id": Cid,
        }));
    var res = jsonDecode(response.body.toString());
  }

  getSingleJobDetails() async {
    setState(() {
      isLoading = true;
    });
    var headers = {'Content-Type': 'application/json'};

    // request.headers.addAll(headers);
    var response = await http.post(Uri.parse('https://pitaratajobs.novasoft.lk/_app_remove_server/nzone_server_nzone_api/getSingleJobDetails'),
        headers: headers, body: json.encode({"app_id": "nzone_4457Was555@qsd_job", "job_id": "${widget.addId}"}));
    var data = jsonDecode(response.body.toString());
    var res = data['data'];
    print('111111111111111111111111111111111111111111111111111111111111111111111111');
    print(data);

    setState(() {
      img = "https://pitaratajobs.novasoft.lk/reso/post_2023_06_20/NovaTechZone_5098205120230620044959am.jpeg";
      print(img);
      description = res[0]['description'].toString();
      addId = res[0]['ads_id'].toString();
      categoryName = res[0]['biz_category_name'].toString();
      salary = res[0]['job_salary'].toString();
      email = res[0]['job_email'].toString();
      mobile = res[0]['job_mobile'].toString();
      whatapp = res[0]['job_whatsapp'].toString();
      categoryId = res[0]['job_category_id'].toString();
      // Function update;
      print(img);
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final AdSize adSize = AdSize(height: 100, width: 100);
    return Scaffold(
      backgroundColor: black,
      appBar: AppBar(
        leading: ArrowButton(
            onTap: () {
              Navigator.pop(context);
            },
            icons: Icons.arrow_back_ios_new),
        backgroundColor: black,
        title: Container(
            alignment: Alignment.centerRight,
            child: CustomText(
              color: white,
              fontFamily: 'Comfortaa-VariableFont_wght',
              fontSize: 17,
              fontWeight: FontWeight.w900,
              text: categoryName,
            )),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Column(children: [
                SizedBox(
                  width: double.infinity,
                  // height: MediaQuery.of(context).size.height / 3,
                  child: CachedNetworkImage(
                    imageUrl: img,
                    progressIndicatorBuilder: (context, url, downloadProgress) => Center(
                      child: SizedBox(
                        height: 50,
                        width: 50,
                        child: CircularProgressIndicator(value: downloadProgress.progress),
                      ),
                    ),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                    fit: BoxFit.cover,
                  ),
                ),
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
                            text: 'Job id #${addId}',
                          ),
                          Container(
                            child: Row(
                              children: [
                                seFavorites
                                    ? CircularProgressIndicator(
                                        color: red,
                                      )
                                    : IconButton(
                                        onPressed: () {
                                          if (verified == true) {
                                            if (widget.x == true) {
                                              alert('You have already added this job to your favorite list!', true, true);
                                            } else {
                                              setFavorite();
                                            }
                                          } else {
                                            showCustomDialog(context, 'Please login to your account to access your favorite jobs!');
                                          }
                                        },
                                        icon: Icon(
                                          widget.x ? Icons.favorite : Icons.favorite_border,
                                          color: widget.x ? red : white,
                                        )),
                                IconButton(
                                    onPressed: () {
                                      alert('Are you sure you need to Share this record ?', false, false);
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
                          text: description,
                        ),
                      ),
                      //bhbhbhbhbhggggg
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: CustomContainer(icon: 'assets/briefcase.svg', text1: categoryName, text2: 'Job Category', colorText: font_green),
                      ),
                      CustomContainer(icon: 'assets/doller.svg', text1: salary, text2: 'salary', colorText: Colors.blue),
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
                          child: RadiusButton(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => JobContact(
                                            job_id: addId,
                                            email: email,
                                            mobile: mobile,
                                            whatapp: whatapp,
                                          )),
                                );
                              },
                              text: 'Show Contact Details',
                              width: 250,
                              height: 70,
                              color: font_green,
                              colortext: white),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      AppAds.bannerAds(context),
                      SizedBox(
                        height: 20,
                      ),
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
                          child: loading
                              ? Center(
                                  child: CircularProgressIndicator(
                                  color: Colors.grey,
                                ))
                              : CustomGrid(
                                  update: widget.update,
                                  x: widget.x,
                                  gridList: getSimilarJobsList,
                                  row: false,
                                )),
                      SizedBox(
                        height: 20,
                      ),
                      AppAds.bannerAds(context),
                      SizedBox(
                        height: 20,
                      ),
                      InkWell(
                        borderRadius: BorderRadius.circular(15),
                        onTapCancel: () {
                          setState(() {
                            tap = false;
                          });
                        },
                        onTapDown: (_) {
                          setState(() {
                            tap = true;
                          });
                        },
                        onTapUp: (_) {
                          setState(() {
                            tap = false;
                          });
                        },
                        onTap: () {
                          // reportThisJob();

                          if (verified) {
                            reportDialog();
                          } else {
                            showCustomDialog(context, 'Please login to your account to access your report this post!');
                          }
                        },
                        child: AnimatedOpacity(
                          duration: Duration(milliseconds: 50),
                          opacity: tap ? 0.3 : 1,
                          child: Container(
                            alignment: Alignment.center,
                            height: 60,
                            width: double.infinity,
                            decoration: BoxDecoration(color: red, borderRadius: BorderRadius.circular(15)),
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
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: TextButton(
                          onPressed: () {
                            if (verified) {
                              feedback();
                            } else {
                              showCustomDialog(context, ' Please login to your account to access your send feedback!');
                            }
                          },
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
              isLoading
                  ? Center(child: LoadingAnimationWidget.staggeredDotsWave(color: Colors.grey, size: MediaQuery.of(context).size.width / 6))
                  : Container()
            ],
          ),
        ),
      ),
    );
  }

  setFavorite() async {
    setState(() {
      seFavorites = true;
    });

    var headers = {'Content-Type': 'application/json'};

    // request.headers.addAll(headers);
    var response = await http.post(Uri.parse('https://pitaratajobs.novasoft.lk/_app_remove_server/nzone_server_nzone_api/setFavourite'),
        headers: headers,
        body: json.encode({"verification": verification, "app_id": "nzone_4457Was555@qsd_job", "customer_id": customer_id, "job_id": addId}));
    var res = jsonDecode(response.body.toString());

    setState(() {
      seFavorites = false;
      widget.x = true;
      widget.update();
    });
  }

  getFavouriteJobs() async {
    setState(() {});

    var headers = {'Content-Type': 'application/json'};

    var response = await http.post(Uri.parse('https://pitaratajobs.novasoft.lk/_app_remove_server/nzone_server_nzone_api/getFavouriteJobs'),
        headers: headers, body: json.encode({"app_id": "nzone_4457Was555@qsd_job", "verification": verification, "customer_id": customer_id}));
    var res = jsonDecode(response.body.toString());

    if (res['data'].toString().isNotEmpty) {
      setState(() {
        if (res['data'].toString().isNotEmpty) {
          favoritesList = res['data'];
        }
      });
    }
  }

  alert(String text, bool item, bool save) async {
    return await showDialog(
        context: context,
        builder: (context) {
          var h = MediaQuery.of(context).size.height;
          return AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15.0))),
            contentPadding: EdgeInsets.only(top: 10.0),
            backgroundColor: black,
            content: Container(
              height: 300,
              width: double.infinity,
              decoration: BoxDecoration(color: black, borderRadius: BorderRadius.circular(15)),
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
                    child:
                        CustomText(text: text, fontSize: 20, fontFamily: 'Comfortaa-VariableFont_wght', color: white, fontWeight: FontWeight.normal),
                  ),
                  SizedBox(
                    height: 35,
                  ),
                  save && item
                      ? Container()
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            RadiusButton(
                              onTap: () async {
                                Navigator.pop(context);
                              },
                              colortext: black,
                              color: Colors.white60,
                              height: h / 15,
                              width: 32.w,
                              text: 'NO',
                            ),
                            RadiusButton(
                              onTap: () async {
                                if (item) {
                                } else {
                                  Share.share(
                                      'Hey, I found this amazing job post in Pita Rata Jobs app. Check this out.\n \nhttps://pitaratajobs.novasoft.lk/single.php?id=${addId}\n\nDownload and try Pita Rata Jobs app.\nApp Link - https://shorturl.at/jwHPQ ');
                                }

                                Navigator.pop(context);
                              },
                              colortext: black,
                              color: font_green,
                              height: h / 15,
                              width: 32.w,
                              text: 'YES',
                            ),
                          ],
                        )
                ],
              ),
            ),
          );
        });
  }

  reportDialog() async {
    return await showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return SingleChildScrollView(
              child: AlertDialog(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15.0))),
                insetPadding: EdgeInsets.zero,
                contentPadding: EdgeInsets.zero,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                backgroundColor: white,
                content: SingleChildScrollView(
                  child: Container(
                    width: MediaQuery.of(context).size.width - 50,
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            alignment: Alignment.topRight,
                            child: IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: Icon(
                                  Icons.close,
                                  color: black,
                                )),
                          ),
                          CustomText(text: 'Report this job post', fontSize: 21.sp, fontFamily: 'Viga', color: red, fontWeight: FontWeight.w400),
                          Divider(),
                          SizedBox(
                            height: 30,
                          ),
                          Text(
                            'Is there something wrong with this post?',
                            style: TextStyle(
                              fontSize: 13.sp,
                              color: Colors.black54,
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Text(
                            'Were constantly working hard to assure that our job posts meet high standards and we are very grateful for any kind of feedback from our users. ',
                            style: TextStyle(
                              fontSize: 13.sp,
                              color: Colors.black54,
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Reasons',
                                  style: TextStyle(
                                    fontSize: 10.sp,
                                    fontFamily: 'Viga',
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: 60,
                                    width: MediaQuery.of(context).size.width / 1.8,
                                    decoration: BoxDecoration(border: Border.all(color: Colors.black38), borderRadius: BorderRadius.circular(2)),
                                    child: DropdownButton<String>(
                                      hint: Text(dropText),
                                      style: TextStyle(fontSize: 9.sp, color: black),
                                      borderRadius: BorderRadius.circular(4),
                                      items: <String>[
                                        'item sold/unavailable',
                                        'Fraud',
                                        'Duplicate',
                                        'Spam',
                                        "Wrong Category",
                                        "Offensive",
                                        "Other"
                                            ""
                                      ].map((String value) {
                                        return DropdownMenuItem<String>(
                                          alignment: Alignment.topLeft,
                                          value: value,
                                          child: Text(value),
                                          onTap: () {
                                            setState(() {
                                              dropText = value;
                                            });
                                          },
                                        );
                                      }).toList(),
                                      onChanged: (_) {},
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Message',
                                style: TextStyle(
                                  fontSize: 10.sp,
                                  fontFamily: 'Viga',
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SizedBox(
                                  width: MediaQuery.of(context).size.width / 1.8,
                                  child: TextField(
                                    controller: controller,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(width: 1, color: Colors.black38), //<-- SEE HERE
                                      ),
                                      contentPadding: EdgeInsets.symmetric(vertical: 40.0),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(width: 1, color: Colors.black38), //<-- SEE HERE
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Divider(),
                          Container(
                            alignment: Alignment.bottomRight,
                            child: FeedbackButton(
                              text: 'Report this job',
                              width: 170,
                              height: 50,
                              color: font_green,
                              colortext: black,
                              onTap: () {
                                reportThisJob();
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          });
        });
  }

  feedback() async {
    return await showDialog(
        context: context,
        builder: (context) {
          var w = MediaQuery.of(context).size.width;
          return StatefulBuilder(builder: (context, setState) {
            return SingleChildScrollView(
              child: AlertDialog(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15.0))),
                backgroundColor: white,
                contentPadding: EdgeInsets.all(0),
                content: Container(
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
                              color: black,
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(text: 'Your Feedback', fontSize: 20.sp, fontFamily: 'Viga', color: red, fontWeight: FontWeight.w400),
                            Divider(),
                            SizedBox(
                              height: 30,
                            ),
                            Text(
                              'We are happy to hear your feedback about our services.',
                              style: TextStyle(
                                fontSize: 17.sp,
                                color: Colors.black54,
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: TextField(
                                controller: controller2,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(vertical: 50.0),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(width: 1, color: Colors.black38), //<-- SEE HERE
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(width: 1, color: Colors.black38), //<-- SEE HERE
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Divider(),
                            Container(
                              alignment: Alignment.bottomRight,
                              child: FeedbackButton(
                                text: 'Send My Feedback',
                                width: 170,
                                height: 50,
                                color: font_green,
                                colortext: black,
                                onTap: () {
                                  sendFeedbackForJob();
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          });
        });
  }

  void loadAd() {
    _bannerAd = BannerAd(
      adUnitId: adUnitId,
      request: const AdRequest(),
      size: AdSize.largeBanner,
      listener: BannerAdListener(
        // Called when an ad is successfully received.
        onAdLoaded: (ad) {
          debugPrint('$ad loaded.');
          setState(() {
            _isLoaded = true;
          });
        },
        // Called when an ad request failed.
        onAdFailedToLoad: (ad, err) {
          debugPrint('BannerAd failed to load: $err');
          // Dispose the ad here to free resources.
          ad.dispose();
        },
      ),
    )..load();
    log('adddddd');
  }
}
