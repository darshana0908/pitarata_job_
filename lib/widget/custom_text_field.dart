import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:pitarata_job/color/colors.dart';
import 'package:sizer/sizer.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField({
    super.key,
    required this.hintText,
    required this.controller,
    required this.keyInput,
    required this.icon,
  });
  final String hintText;
  final TextEditingController controller;
  final TextInputType keyInput;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(color: white, fontSize: 13.sp),
      controller: controller,
      keyboardType: keyInput,
      validator: (value) {
        var result = EmailValidator.validate(value.toString());
        return result ? null : "Please enter a valid email";
      },
      decoration: InputDecoration(
          counterStyle: TextStyle(color: Colors.white),
          prefixIcon: Icon(
            icon,
            color: background_green,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          contentPadding: EdgeInsets.all(0),
          
          filled: true,
          hintStyle: TextStyle(color: Colors.grey[600]),
          hintText: hintText,
          fillColor: light_dark),
    );
  }
}
