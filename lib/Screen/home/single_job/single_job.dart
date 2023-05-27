import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
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
import '../../../widget/custom_container.dart';
import '../../../widget/custom_text.dart';
import '../../../widget/job_categories.dart';
import '../../name_screen/name_screen.dart';

class SingleJob extends StatefulWidget {
  SingleJob(
      {super.key,
      required this.img,
      required this.description,
      required this.addId,
      required this.categoryName,
      required this.salary,
      required this.email,
      required this.mobile,
      required this.whatapp,
      required this.categoryId,
      required this.x,
      required this.update});

  final String img;
  final String description;
  final String addId;
  final String categoryName;
  final String salary;
  final String email;
  final String mobile;
  final String whatapp;
  final String categoryId;
  final Function update;

  bool x;

  @override
  State<SingleJob> createState() => _SingleJobState();
}

class _SingleJobState extends State<SingleJob> {
  TextEditingController controller = TextEditingController();
  TextEditingController controller2 = TextEditingController();
  bool verified = false;
  SqlDb sqlDb = SqlDb();
  String id = '';
  List favoritesList = [];
  List getSimilarJobsList = [];
  bool selected = false;
  bool loading = false;
  String verification = '';
  String customer_id = '';
  bool seFavorites = false;
  String dropText = 'select a reasons';
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
    getSimilarJobs();
    userLogin();
  }

  ifselected() {
    favoritesList.any((element) => element["addId"].toString() == widget.addId);

    log(favoritesList
        .any((element) => element["addId"].toString() == widget.addId)
        .toString());
  }

  getSimilarJobs() async {
    setState(() {
      loading = true;
    });
    var headers = {'Content-Type': 'application/json'};
    var response = await http.post(
        Uri.parse(
            'https://pitaratajobs.novasoft.lk/_app_remove_server/nzone_server_nzone_api/getSimilarJobs'),
        headers: headers,
        body: json.encode({
          "app_id": "nzone_4457Was555@qsd_job",
          "job_category_id": widget.categoryId
        }));
    log(widget.categoryId);
    var res = jsonDecode(response.body.toString());
    log(res.toString());

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
    var response = await http.post(
        Uri.parse(
            'https://pitaratajobs.novasoft.lk/_app_remove_server/nzone_server_nzone_api/reportThisJob'),
        headers: headers,
        body: json.encode({
          "verification": verification,
          "app_id": "nzone_4457Was555@qsd_job",
          "customer_id": customer_id,
          "job_id": widget.addId,
          "reason": dropText,
          "message": controller.text
        }));

    var res = jsonDecode(response.body);
    log(res.toString());
    String msg = res['msg'];
    if (res['status'].toString() == "1") {
      setState(() {
        dropText = 'select a reasons';
        controller.clear();
      });

      Navigator.pop(context);

      MotionToast.info(title: Text("Info"), description: Text(msg))
          .show(context);
    } else {
      MotionToast.error(title: Text("error"), description: Text(msg))
          .show(context);
    }

    setState(() {});
  }

  sendFeedbackForJob() async {
    setState(() {
      // loading = true;
    });
    var headers = {'Content-Type': 'application/json'};
    var response = await http.post(
        Uri.parse(
            'https://pitaratajobs.novasoft.lk/_app_remove_server/nzone_server_nzone_api/sendFeedbackForJob'),
        headers: headers,
        body: json.encode({
          "verification": verification,
          "app_id": "nzone_4457Was555@qsd_job",
          "customer_id": customer_id,
          "job_id": widget.addId,
          "feedback": controller2.text,
        }));

    var res = jsonDecode(response.body);
    log(res.toString());
    String msg = res['msg'];
    if (res['status'].toString() == "1") {
      setState(() {
        dropText = 'select a reasons';
        controller.clear();
      });

      Navigator.pop(context);

      MotionToast.info(title: Text("Info"), description: Text(msg))
          .show(context);
    } else {
      MotionToast.error(title: Text("error"), description: Text(msg))
          .show(context);
    }

    setState(() {});
  }

  userLogin() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      var z = sharedPreferences.getString('verification');
      var y = sharedPreferences.getString('customer_id');
      setState(() {
        verification = z.toString();
        customer_id = y.toString();
      });

      log("verificatio" + verification);
      if (verification != '0') {
        setState(() {
          verified = true;
          log('kkkkkkkkkkkkkkkkkkddddddqqqqqqqqqqqqqqqqqrrrrrrrrrrrrrrrrrrddddddddddddk');
        });
      } else {
        setState(() {
          verified = false;
        });
      }
    });
  }

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
                          seFavorites
                              ? CircularProgressIndicator(
                                  color: red,
                                )
                              : IconButton(
                                  onPressed: () {
                                    if (verified == true) {
                                      if (widget.x == true) {
                                        alert('you already save this', true,
                                            true);
                                      } else {
                                        alert(
                                            'Are you sure you want to Save this? ',
                                            true,
                                            false);
                                      }
                                    } else {
                                      userCheck(
                                          'Please login to your account to access your favorite jobs!');
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
                                    job_id: widget.addId,
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
                InkWell(
                    onTap: () {
                      MotionToast.info(
                              title: Text("Info"),
                              description:
                                  Text('"This option will be enabled soon!"'))
                          .show(context);
                    },
                    child: AdArea()),
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
                InkWell(
                  onTap: () {
                    MotionToast.info(
                            title: Text("Info"),
                            description:
                                Text('"This option will be enabled soon!"'))
                        .show(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: AdArea(),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    // reportThisJob();

                    if (verified) {
                      reportDialog();
                    } else {
                      userCheck(
                          'Please login to your account to access your report this post!');
                    }
                  },
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
                    onPressed: () {
                      if (verified) {
                        feedback();
                      } else {
                        userCheck(
                            ' Please login to your account to access your send feedback!');
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
      ),
    );
  }

  userCheck(String text) {
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
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: RadiusButton(
                            colortext: black,
                            color: white,
                            height: 70,
                            width: 110,
                            text: 'Cancel',
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
                            text: 'Login',
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

  setFavorite() async {
    setState(() {
      seFavorites = true;
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
          "job_id": widget.addId
        }));
    var res = jsonDecode(response.body.toString());
    log('v' + verification);
    log("c" + customer_id);
    log('kkkkkccccaca' + res.toString());

    setState(() {
      seFavorites = false;
      widget.x = true;
      widget.update();
    });
  }

  getFavouriteJobs() async {
    setState(() {});

    var headers = {'Content-Type': 'application/json'};

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

    log(res['data'].toString());
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
                                  setFavorite();
                                  setState(() {});
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

  reportDialog() async {
    return await showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return SingleChildScrollView(
              child: AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15.0))),
                contentPadding: EdgeInsets.only(top: 10.0),
                backgroundColor: white,
                content: SingleChildScrollView(
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
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
                          CustomText(
                              text: 'Report this job post',
                              fontSize: 21.sp,
                              fontFamily: 'Viga',
                              color: red,
                              fontWeight: FontWeight.w400),
                          Divider(),
                          SizedBox(
                            height: 30,
                          ),
                          Text(
                            'Is there something wrong with this post?',
                            style: TextStyle(
                              fontSize: 15.sp,
                              fontFamily: 'Viga',
                              color: Colors.black54,
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Text(
                            'Were constantly working hard to assure that our job posts meet high standards and we are very grateful for any kind of feedback from our users. ',
                            style: TextStyle(
                              fontSize: 15.sp,
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
                                  fontSize: 10.sp,
                                  fontFamily: 'Viga',
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Container(
                                alignment: Alignment.center,
                                height: 60,
                                width: 190,
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black38),
                                    borderRadius: BorderRadius.circular(2)),
                                child: SizedBox(
                                  child: DropdownButton<String>(
                                    alignment: Alignment.centerRight,
                                    hint: Text(dropText),
                                    style:
                                        TextStyle(fontSize: 9.sp, color: black),
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
                                            log('fffffffff');
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
                          SizedBox(
                            height: 30,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
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
                              SizedBox(
                                width: 240,
                                child: TextField(
                                  controller: controller,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 1,
                                          color: Colors.black38), //<-- SEE HERE
                                    ),
                                    contentPadding:
                                        EdgeInsets.symmetric(vertical: 40.0),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 1,
                                          color: Colors.black38), //<-- SEE HERE
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Divider(),
                          InkWell(
                            onTap: () {
                              reportThisJob();
                            },
                            child: Container(
                              alignment: Alignment.centerRight,
                              child: Container(
                                alignment: Alignment.center,
                                height: 50,
                                width: 150,
                                decoration: BoxDecoration(
                                    color: red,
                                    borderRadius: BorderRadius.circular(5)),
                                child: Text(
                                  'Send Report',
                                  style: TextStyle(
                                    color: black,
                                    fontSize: 17,
                                    fontFamily: 'Viga',
                                  ),
                                ),
                              ),
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
          return StatefulBuilder(builder: (context, setState) {
            return SingleChildScrollView(
              child: AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15.0))),
                contentPadding: EdgeInsets.only(top: 10.0),
                backgroundColor: white,
                content: Container(
                  height: 500,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                        CustomText(
                            text: 'Your Feedback',
                            fontSize: 20.sp,
                            fontFamily: 'Viga',
                            color: red,
                            fontWeight: FontWeight.w400),
                        Divider(),
                        SizedBox(
                          height: 30,
                        ),
                        Text(
                          'We are happy to hear your feedback about our services.',
                          style: TextStyle(
                            fontSize: 17.sp,
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
                              width: MediaQuery.of(context).size.width / 2.5,
                              child: TextField(
                                controller: controller2,
                                decoration: InputDecoration(
                                  contentPadding:
                                      EdgeInsets.symmetric(vertical: 40.0),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1,
                                        color: Colors.black38), //<-- SEE HERE
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1,
                                        color: Colors.black38), //<-- SEE HERE
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Divider(),
                        InkWell(
                          onTap: () {
                            sendFeedbackForJob();
                          },
                          child: Container(
                            alignment: Alignment.centerRight,
                            child: Container(
                              alignment: Alignment.center,
                              height: 50,
                              width: 250,
                              decoration: BoxDecoration(
                                  color: red,
                                  borderRadius: BorderRadius.circular(5)),
                              child: Text(
                                'Send My Feedback',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: 'Viga',
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          });
        });
  }
}
