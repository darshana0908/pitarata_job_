import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shimmer/shimmer.dart';

import '../color/colors.dart';
import 'custom_text.dart';

class FadeHome extends StatelessWidget {
  const FadeHome({super.key});

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
                Container(
                  decoration: BoxDecoration(
                      color: white, borderRadius: BorderRadius.circular(20)),
                  height: MediaQuery.of(context).size.height / 3.1,
                  width: MediaQuery.of(context).size.width,
                  child: Image.asset("assets/c1.PNG"),
                ),
                Container(
                  padding: EdgeInsets.all(15),
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: CircleAvatar(
                          backgroundColor: Colors.blue,
                          radius: 5,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: CircleAvatar(
                          backgroundColor: Colors.blue,
                          radius: 5,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: CircleAvatar(
                          backgroundColor: Colors.blue,
                          radius: 5,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: CircleAvatar(
                          backgroundColor: Colors.blue,
                          radius: 5,
                        ),
                      ),
                    ],
                  ),
                ),
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
                              borderRadius: BorderRadius.circular(10)),
                          height: 100,
                          width: 100,
                          child: Image.asset("assets/c1.PNG"),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: white,
                              borderRadius: BorderRadius.circular(10)),
                          height: 100,
                          width: 100,
                          child: Image.asset("assets/c1.PNG"),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: white,
                              borderRadius: BorderRadius.circular(10)),
                          height: 100,
                          width: 100,
                          child: Image.asset("assets/c1.PNG"),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: white,
                              borderRadius: BorderRadius.circular(10)),
                          height: 100,
                          width: 100,
                          child: Image.asset("assets/c1.PNG"),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: white,
                              borderRadius: BorderRadius.circular(10)),
                          height: 100,
                          width: 100,
                          child: Image.asset("assets/c1.PNG"),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: white, borderRadius: BorderRadius.circular(20)),
                    height: MediaQuery.of(context).size.height / 3,
                    width: MediaQuery.of(context).size.width,
                    child: Image.asset("assets/c1.PNG"),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
