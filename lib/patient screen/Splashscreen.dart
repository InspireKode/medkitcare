import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medkitcare/patient%20screen/slideshow/silde1.dart';
import 'package:medkitcare/styles/colors.dart';
import 'package:medkitcare/styles/styles.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(Duration(seconds: 2), () {
      var route = MaterialPageRoute(builder: (BuildContext) => Slide1());
      Navigator.push(context, route);
    });

    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image(
            image: AssetImage('assets/logo.PNG'),
            width: 70,
          ),
          SizedBox(height: 5),
          Text('MedKare', style: PoppinsTitle)
        ],
      )),
    );
  }
}
