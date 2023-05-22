import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:pitarata_job/color/colors.dart';
import 'package:pitarata_job/widget/custom_text.dart';
import 'package:provider/provider.dart';

import '../provider/get_Job.dart';

class CustomList extends StatefulWidget {
  const CustomList({super.key, required this.cat});
  final List cat;

  @override
  State<CustomList> createState() => _CustomListState();
}

class _CustomListState extends State<CustomList> {
  String selected = 'All';

  @override
  void initState() {
    setState(() {
      String selected = 'All';
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final selectedItems = Provider.of<getJobId>(context);
    bool color = false;
    return Container(
      height: 130,
      child: ListView.builder(
          itemCount: widget.cat.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              onTap: () {
                setState(() {
                  selected = widget.cat[index]['category_id'];
                });
                if (selected == widget.cat[index]['category_id']) {
                  log(selected);
                  setState(() {
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
                      color: selected == widget.cat[index]['category_id']
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
                      child: CustomText(
                          text: widget.cat[index]['category_name'],
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
    );
  }
}
