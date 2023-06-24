import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../color/colors.dart';

class GmailLogin extends StatefulWidget {
  const GmailLogin({Key? key}) : super(key: key);

  @override
  State<GmailLogin> createState() => _GmailLoginState();
}

class _GmailLoginState extends State<GmailLogin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: black,
        body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              print('dddddddddddddddddddddddddddddddddddddd');
              return Center(
                  child: Center(
                child: LoadingAnimationWidget.staggeredDotsWave(
                  color: Colors.white,
                  size: 100,
                ),
              ));
            } else if (snapshot.hasData) {
              print('dddddddddddddddddddddddddddddddqqqqqqqqqqqdddddddddddddd');
              print(FirebaseAuth.instance.currentUser!.phoneNumber);
              print(FirebaseAuth.instance.currentUser);
              print(snapshot.hasData);

              return Center(
                child: Text(
                  'success',
                  style: TextStyle(color: white, fontSize: 20),
                ),
              );
            } else if (snapshot.hasError) {
              print(
                  'ddddddddddddddddddddddddssssssssssssssssssssdddddddddddddd');
              return const Center(
                child: Center(child: Text('Something went wrong')),
              );
            } else {
              return Center(
                  child: Center(
                child: LoadingAnimationWidget.staggeredDotsWave(
                  color: Colors.white,
                  size: 100,
                ),
              ));
            }
          },
          // ),
        ));
  }
}
