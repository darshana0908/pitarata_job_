import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:sizer/sizer.dart';

import '../color/colors.dart';

class SignUpButton extends StatefulWidget {
  const SignUpButton(
      {super.key,
      required this.width,
      required this.height,
      required this.color,
      required this.colortext,
      required this.onTap,
      required this.icon,
      required this.name});

  final double width;
  final double height;
  final Color color;
  final Color colortext;
  final VoidCallback onTap;
  final String icon;
  final Widget name;

  @override
  State<SignUpButton> createState() => _SignUpButtonState();
}

class _SignUpButtonState extends State<SignUpButton> {
  bool tap = false;
  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: widget.onTap,
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
      child: AnimatedOpacity(
        duration: Duration(milliseconds: 50),
        opacity: tap ? 0.3 : 1,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            alignment: Alignment.center,
            height: widget.height,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20), color: widget.color),
            child: SizedBox(
              width: w / 1.4,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Image.asset(
                      widget.icon,
                    ),
                  ),
                  widget.name
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
