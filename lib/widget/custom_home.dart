import 'dart:convert';
import 'dart:developer';
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
  List cat = ['All', 'Cat 1', 'Cat 2', 'Cat 3', 'Cat 4'];
  bool isLoading = false;
  @override
  void initState() {
    getTextData();
    getCategoryData();
    // TODO: implement initState
    super.initState();
  }

  getTextData() async {
    setState(() {
      isLoading = true;
    });
    log('vvvvvvvvvvvvvv');
    var headers = {'Content-Type': 'application/json'};

    // request.headers.addAll(headers);
    var response = await http.post(
        Uri.parse(
            'https://lol.novasoft.lk/_ready_only/aws_nzone_api/getFunData'),
        headers: headers,
        body: json.encode({
          "app_id": "novatechzone._lol",
          "api_key": "44552522",
          "from": '0',
          "to": '20'
        }));

    setState(() {
      var res = jsonDecode(response.body.toString());
      log(res.toString());

      // log(textList.toString());
      isLoading = false;
    });
  }

  getCategoryData() async {
    setState(() {
      isLoading = true;
    });

    var headers = {'Content-Type': 'application/json'};

    // request.headers.addAll(headers);
    var response = await http.post(
        Uri.parse(
            'https://pitaratajobs.novasoft.lk/_app_remove_server/nzone_server_nzone_api/registerCustomer'),
        headers: headers,
        body: json.encode({
          "app_id": "nzone_4457Was555@qsd_job",
          "password": "12345678",
          "notification_key": "12345678",
          "name": "darshana",
          "mobile_number": "0716232224",
          "email": "darsha@gaai.com"
        }));
    log('hhhhhhhaaaahhhhhhhhhhhh');
    setState(() {
      var res = jsonDecode(response.body.toString());
      log('gccfcfcfcfc' + res.toString());

      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 5,
            width: double.infinity,
            child: ImageSlideshow(
              /// Width of the [ImageSlideshow].
              width: double.infinity,

              /// Height of the [ImageSlideshow].
              height: MediaQuery.of(context).size.height / 8,

              /// The page to show when first creating the [ImageSlideshow].
              initialPage: 0,

              /// The color to paint the indicator.
              indicatorColor: Colors.blue,

              /// The color to paint behind th indicator.
              indicatorBackgroundColor: Colors.grey,

              /// The widgets to display in the [ImageSlideshow].
              /// Add the sample image file into the images folder
              children: [
                Image.asset(
                  'assets/pexels1.jpg',
                  fit: BoxFit.cover,
                ),
                Image.asset(
                  'assets/pexels2.jpg',
                  fit: BoxFit.cover,
                ),
              ],

              /// Called whenever the page in the center of the viewport changes.
              onPageChanged: (value) {
                print('Page changed: $value');
              },

              /// Auto scroll interval.
              /// Do not auto scroll with null or 0.
              autoPlayInterval: 3000,

              /// Loops back to first slide.
              isLoop: true,
            ),
          ),
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
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 8,
            ),
            child: CustomList(cat: cat),
          ),
          Container(
            child: ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: cat.length,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {
                      log(cat[index].toString());
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SingleJob(
                                img: 'assets/Favourite.jpg',
                                cat: cat[index].toString())),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: MediaQuery.of(context).size.height / 2.8,
                        child: Stack(children: [
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
                              height: MediaQuery.of(context).size.height / 4.2,
                              width: double.infinity,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: CustomText(
                                        text: 'Job Category',
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
                              height: MediaQuery.of(context).size.height / 3.2,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: light_dark,
                                  borderRadius: BorderRadius.circular(50)),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.asset(
                                  'assets/Favourite.jpg',
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
