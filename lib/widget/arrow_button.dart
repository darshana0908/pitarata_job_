import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../color/colors.dart';

class ArrowButton extends StatefulWidget {
  const ArrowButton({super.key, required this.icons, required this.onTap});
  final IconData icons;
  final VoidCallback onTap;

  @override
  State<ArrowButton> createState() => _ArrowButtonState();
}

class _ArrowButtonState extends State<ArrowButton> {
  bool tap = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        borderRadius: BorderRadius.circular(15),
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
          opacity: tap ? 0.2 : 1,
          child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15), color: light_brown),
              height: 50,
              width: 50,
              child: Icon(
                widget.icons,
                color: brown,
              )),
        ),
      ),
    );
  }
}
