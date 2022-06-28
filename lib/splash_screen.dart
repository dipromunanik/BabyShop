import 'package:baby_shop/lancher.dart';
import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  static const String routeName='/splash_screen';
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      backgroundColor:const Color(0xFF38c172),
      splash: Lottie.network('https://assets8.lottiefiles.com/packages/lf20_npaer5z7.json',height: 500,width: double.infinity,fit: BoxFit.cover),
      nextScreen: LancherPage(),
      animationDuration:const Duration(seconds: 5),
      duration: 7000,
      splashTransition: SplashTransition.scaleTransition,
    );
  }
}
