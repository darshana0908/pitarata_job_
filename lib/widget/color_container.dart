import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:pitarata_job/color/colors.dart';
import 'package:pitarata_job/widget/custom_text.dart';
import 'package:sizer/sizer.dart';

class ColorContainer extends StatefulWidget {
  const ColorContainer(
      {super.key,
      required this.color,
      required this.color1,
      required this.icon,
      required this.text,
      required this.text1,
      required this.iconColor,
      required this.textColor,
      required this.onTap});
  final Color color;
  final Color color1;
  final IconData icon;
  final String text;
  final String text1;
  final Color textColor;
  final Color iconColor;
  final VoidCallback onTap;

  @override
  State<ColorContainer> createState() => _ColorContainerState();
}

class _ColorContainerState extends State<ColorContainer> {
  bool tap = false;
  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
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
        onTap: widget.onTap,
        child: AnimatedOpacity(
          duration: Duration(milliseconds: 50),
          opacity: tap ? 0.3 : 1,
          child: SingleChildScrollView(
            child: Container(
                child: Column(children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: Icon(
                          widget.icon,
                          size: 40,
                          color: widget.iconColor,
                        ),
                      ),
                      SingleChildScrollView(
                        child: CustomText(
                            text: widget.text,
                            fontSize: 15.sp,
                            fontFamily: 'Comfortaa-VariableFont_wght',
                            color: widget.textColor,
                            fontWeight: FontWeight.normal),
                      )
                    ],
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: CustomText(
                        text: widget.text1,
                        fontSize: 16.sp,
                        fontFamily: 'Comfortaa-VariableFont_wght',
                        color: white,
                        fontWeight: FontWeight.normal),
                  )
                ]),
                height: h / 8,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: new LinearGradient(
                    colors: [
                      widget.color,
                      widget.color1,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    stops: [0.1, 5.80],
                  ),
                )),
          ),
        ),
      ),
    );
  }
}
