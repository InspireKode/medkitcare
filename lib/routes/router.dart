import 'package:flutter/material.dart';
import 'package:medkitcare/doctors%20screen/DocHomePage.dart';
import 'package:medkitcare/doctors%20screen/DocSignIn.dart';
import 'package:medkitcare/doctors%20screen/approve_schedule.dart';
import 'package:medkitcare/patient%20screen/Splashscreen.dart';
import 'package:medkitcare/patient%20screen/doctor_detail.dart';
import 'package:medkitcare/patient%20screen/forget_password.dart';
import 'package:medkitcare/patient%20screen/home.dart';
import 'package:medkitcare/patient%20screen/login_option.dart';
import 'package:medkitcare/doctors%20screen/DocSignUp.dart';
import 'package:medkitcare/patient%20screen/open_schedule.dart';
import 'package:medkitcare/patient%20screen/signin.dart';
import 'package:medkitcare/patient%20screen/signup.dart';
import 'package:medkitcare/patient%20screen/slideshow/silde1.dart';
import 'package:medkitcare/patient%20screen/slideshow/slide2.dart';
import 'package:medkitcare/patient%20screen/slideshow/slide3.dart';
import 'package:medkitcare/patient%20screen/slideshow/slide4.dart';
import 'package:medkitcare/tabs/Profile.dart';

Map<String, Widget Function(BuildContext)> routes = {
  '/': (context) => SplashScreen(),
  '/SignIn': (context) => SigninPage(),
  '/SignUp': (context) => SignUpPage(),
  '/DocSignUp': (context) => DocSignUpPage(),
  '/DocSignIn': (context) => DocSignInPage(),
  '/options': (context) => Loginoption(),
  '/detail': (context) => SliverDoctorDetail(),
  '/home': (context) => Home(),
  '/DocHome': (context) => DocHome(),
  // '/DocApprove': (context) => DoctorApp(doctorName: '', appointments: [],),
  '/profile': (context) => UserProfileScreen(),
  '/pwd_reset': (context) => ForgotPasswordPage(),
  '/1': (context) => Slide1(),
  '/2': (context) => Slide2(),
  '/3': (context) => Slide3(),
  '/4': (context) => Slide4(),
  OpenSchedule.uri: (context) => const OpenSchedule()
};
