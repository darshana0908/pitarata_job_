import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../color/colors.dart';

class RadiusButton extends StatefulWidget {
  const RadiusButton({
    super.key,
    required this.text,
    required this.width,
    required this.height,
    required this.color,
    required this.colortext,
    required this.onTap,
  });
  final String text;
  final double width;
  final double height;
  final Color color;
  final Color colortext;
  final VoidCallback onTap;

  @override
  State<RadiusButton> createState() => _RadiusButtonState();
}

class _RadiusButtonState extends State<RadiusButton> {
  bool tap = false;
  @override
  Widget build(BuildContext context) {
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
        child: Container(
          alignment: Alignment.center,
          height: widget.height,
          width: widget.width,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20), color: widget.color),
          child: Text(widget.text,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: widget.colortext,
                  fontFamily: 'Comfortaa-VariableFont_wght',
                  fontSize: 17)),
        ),
      ),
    );
  }
}
