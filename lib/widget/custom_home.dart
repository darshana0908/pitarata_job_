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
  List cat = ['All', 'Cat 1', 'Cat 2', 'Cat 3', 'Cat 4'];
  final List<String> imgList = [
    'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
    'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
    'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
    'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
  ];
  List<String> wallPaper = [];
  bool isLoading = false;
  int _current = 0;
  final CarouselController _controller = CarouselController();

  @override
  void initState() {
    // getTextData();
    getWallpaper();
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
    log('hhhhhhhaaaahhhhhhhhhhhh');
    setState(() {
      var res = jsonDecode(response.body.toString());
      log('gccfcfcfcfc' + res['data'].toString());
      wallPaper = res['data'];
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          CarouselSlider(
            options: CarouselOptions(
                padEnds: false,
                viewportFraction: 3,
                height: 300,
                autoPlay: true,
                enlargeCenterPage: true,
                aspectRatio: 2.0,
                onPageChanged: (index, reason) {
                  setState(() {
                    _current = index;
                  });
                }),
            items: imgList.map((i) {
              return Builder(builder: (BuildContext context) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.symmetric(horizontal: 1.0),
                  decoration: BoxDecoration(color: Colors.amber),
                  child: Image.network(
                    i,
                    fit: BoxFit.fill,
                  ),
                );
              });
            }).toList(),
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: imgList.asMap().entries.map((entry) {
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
          // SizedBox(
          //   height: MediaQuery.of(context).size.height / 5,
          //   width: double.infinity,
          //   child: ImageSlideshow(
          //     /// Width of the [ImageSlideshow].
          //     width: double.infinity,

          //     /// Height of the [ImageSlideshow].
          //     height: MediaQuery.of(context).size.height / 8,

          //     /// The page to show when first creating the [ImageSlideshow].
          //     initialPage: 0,

          //     /// The color to paint the indicator.
          //     indicatorColor: Colors.blue,

          //     /// The color to paint behind th indicator.
          //     indicatorBackgroundColor: Colors.grey,

          //     /// The widgets to display in the [ImageSlideshow].
          //     /// Add the sample image file into the images folder
          //     children: [
          //       Image.network(
          //         'https://pitaratajobs.novasoft.lk/img/default_wallpaper.jpg',
          //         fit: BoxFit.cover,
          //       ),
          //       // Image.asset(
          //       //   'assets/pexels2.jpg',
          //       //   fit: BoxFit.cover,
          //       // ),
          //     ],

          //     /// Called whenever the page in the center of the viewport changes.
          //     onPageChanged: (value) {
          //       print('Page changed: $value');
          //     },

          //     /// Auto scroll interval.
          //     /// Do not auto scroll with null or 0.
          //     autoPlayInterval: 3000,

          //     /// Loops back to first slide.
          //     isLoop: true,
          //   ),
          // ),
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
