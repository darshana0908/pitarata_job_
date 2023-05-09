import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../Screen/home/single_job/single_job.dart';
import '../color/colors.dart';
import 'custom_text.dart';

class JobCategories extends StatefulWidget {
  JobCategories({super.key, required this.catlist});
  List catlist;

  @override
  State<JobCategories> createState() => _JobCategoriesState();
}

class _JobCategoriesState extends State<JobCategories> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: MediaQuery.of(context).size.height,
        child: GridView.builder(
            itemCount: widget.catlist.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, crossAxisSpacing: 4.0, mainAxisSpacing: 4.0),
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                onTap: () {
                  log(widget.catlist[index].toString());
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SingleJob(
                            img: 'assets/Favourite.jpg',
                            cat: widget.catlist[index].toString())),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.5,
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CustomText(
                                    text: 'Job Category',
                                    fontSize: 12,
                                    fontFamily: 'Comfortaa-VariableFont_wght',
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
                          height: MediaQuery.of(context).size.height * 0.48,
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
      ),
    );
  }
}
