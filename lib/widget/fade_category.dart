import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shimmer/shimmer.dart';

import '../color/colors.dart';
import 'custom_text.dart';

class FadeCategory extends StatelessWidget {
  const FadeCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Shimmer.fromColors(
          baseColor: Color.fromARGB(255, 181, 180, 180),
          highlightColor: Color.fromARGB(151, 239, 239, 239),
          enabled: true,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
             
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: white, borderRadius: BorderRadius.circular(20)),
                    height: 30,
                    width: 200,
                    child: Image.asset("assets/c1.PNG"),
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: white,
                              borderRadius: BorderRadius.circular(15)),
                          height: 70,
                          width: 150,
                          child: Image.asset("assets/c1.PNG"),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: white,
                              borderRadius: BorderRadius.circular(15)),
                          height: 70,
                          width: 150,
                          child: Image.asset("assets/c1.PNG"),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: white,
                              borderRadius: BorderRadius.circular(15)),
                          height: 70,
                          width: 150,
                          child: Image.asset("assets/c1.PNG"),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: white,
                              borderRadius: BorderRadius.circular(15)),
                          height: 70,
                          width: 150,
                          child: Image.asset("assets/c1.PNG"),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: white,
                              borderRadius: BorderRadius.circular(15)),
                          height: 70,
                          width: 150,
                          child: Image.asset("assets/c1.PNG"),
                        ),
                      ),
                    ],
                  ),
                ),
                
              ],
            ),
          )),
    );
  }
}
