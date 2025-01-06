import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:sparkleship/screens/splash.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const Image(
        image: AssetImage(
          'assets/images/logo.png',
        ),
        height: 0);
    return Sizer(builder: (context, orientation, screenType) {
      return const SafeArea(
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          // home: SplashScreen(),
          home: SplashScreen(),
        ),
      );
    });
  }
}
