import 'dart:convert';
import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pitarata_job/color/colors.dart';
import 'package:pitarata_job/widget/arrow_button.dart';
import 'package:pitarata_job/widget/custom_grid.dart';
import 'package:pitarata_job/widget/custom_text.dart';
import 'package:url_launcher/link.dart';
import 'package:url_launcher/url_launcher.dart';

class Blog extends StatefulWidget {
  const Blog({super.key});

  @override
  State<Blog> createState() => _BlogState();
}

class _BlogState extends State<Blog> {
  List blogList = [];
  int page = 0;
  final int limit = 20;
  bool isFirstLoadRunning = false;
  bool hasNextPage = true;
  bool isLoadMoreRunning = false;
  late ScrollController mycontroller;
  bool loading = false;

  loadeMore() async {
    log('hhhhhhhhhhhhhh');
    if (hasNextPage == true &&
        isFirstLoadRunning == false &&
        isLoadMoreRunning == false) {
      setState(() {
        isLoadMoreRunning = true;
      });

      page += 1;
      var headers = {'Content-Type': 'application/json'};
      var response = await http.post(
          Uri.parse(
              'https://pitaratajobs.novasoft.lk/_app_remove_server/nzone_server_nzone_api/getJobBlog'),
          headers: headers,
          body: json.encode({
            "app_id": "nzone_4457Was555@qsd_job",
            "from": page.toString(),
            "to": limit.toString(),
          }));

      var res = jsonDecode(response.body);
      List job = res['data'];
      if (job.isNotEmpty) {
        setState(() {
          blogList.addAll(job);
        });
      } else {
        setState(() {
          hasNextPage = false;
        });
      }

      setState(() {
        isLoadMoreRunning = false;
      });
    }
  }

  getJobBlog() async {
    setState(() {
      loading = true;
    });
    var headers = {'Content-Type': 'application/json'};
    var response = await http.post(
        Uri.parse(
            'https://pitaratajobs.novasoft.lk/_app_remove_server/nzone_server_nzone_api/getJobBlog'),
        headers: headers,
        body: json.encode({
          "app_id": "nzone_4457Was555@qsd_job",
          "from": '0',
          "to": '20',
        }));

    var res = jsonDecode(response.body.toString());
    log(res.toString());
    // Navigator.pop(context);
    setState(() {
      loading = false;
      blogList = res['data'];
    });
  }

  @override
  void initState() {
    getJobBlog();
    mycontroller = ScrollController()..addListener(loadeMore);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black,
      body: loading
          ? Center(
              child: CircularProgressIndicator(
              color: Colors.grey,
            ))
          : Stack(
              children: [
                ListView.builder(
                    controller: mycontroller,
                    itemCount: blogList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Link(
                        uri: Uri.parse(blogList[index]['url']),
                        builder: (context, followLink) => InkWell(
                          onTap: followLink,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              padding: EdgeInsets.all(8),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: light_dark,
                                  borderRadius: BorderRadius.circular(20)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: CustomText(
                                        text: blogList[index]['title'],
                                        fontSize: 17,
                                        fontFamily:
                                            'Comfortaa-VariableFont_wght',
                                        color: white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Container(
                                      padding: EdgeInsets.all(20),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(2),
                                        child: CachedNetworkImage(
                                          imageUrl:
                                              "https://pitaratajobs.novasoft.lk/${blogList[index]['post_image']}",
                                          progressIndicatorBuilder: (context,
                                                  url, downloadProgress) =>
                                              Center(
                                            child: SizedBox(
                                              height: 50,
                                              width: 50,
                                              child: CircularProgressIndicator(
                                                  value: downloadProgress
                                                      .progress),
                                            ),
                                          ),
                                          errorWidget: (context, url, error) =>
                                              Icon(Icons.error),
                                          fit: BoxFit.scaleDown,
                                        ),
                                      )),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: Container(
                                        child: Text(
                                      blogList[index]['summary'],
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontFamily:
                                              'Comfortaa-VariableFont_wght',
                                          color: white,
                                          fontWeight: FontWeight.normal),
                                    )),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Container(
                                        alignment: Alignment.bottomRight,
                                        child: Text(
                                          blogList[index]['date'] == "null"
                                              ? "_________"
                                              : "${blogList[index]['date']}+ ${blogList[index]['time']}",
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontFamily:
                                                  'Comfortaa-VariableFont_wght',
                                              color: Colors.white60,
                                              fontWeight: FontWeight.normal),
                                        )),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                if (isLoadMoreRunning == true)
                  Positioned(
                    bottom: 20,
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
    );
  }
}
