import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:sparkleship/screens/loading.dart';
import 'package:sparkleship/screens/splash.dart';


// void main() {
//   // runApp is also used in AngularDart
//   runApp(const MyApp());
// }
void main() => runApp(
  // DevicePreview(
  //   builder: (context) => const MyApp(), // Wrap your app
  // ),
  const MyApp()
);
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
 @override
  Widget build(BuildContext context) {
      precacheImage(const AssetImage("assets/images/logo3.png"), context);
    return Sizer(
      builder:(context, orientation, screenType){
    return   const SafeArea(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        // home: SplashScreen(),
        home:Loading(),
      
      
        
      ),
    );
  }
    );
}
}


