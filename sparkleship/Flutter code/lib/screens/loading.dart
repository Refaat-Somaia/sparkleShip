import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:sparkleship/screens/splash.dart';

import 'package:sizer/sizer.dart';



class Loading extends StatefulWidget{
  const Loading({super.key});

  @override
  State<Loading> createState()=> _Loading();

}
class _Loading extends State<Loading>
with SingleTickerProviderStateMixin{
@override
void initState(){
  super.initState();

Timer(const Duration(milliseconds: 200), () { 
    Navigator.of(context).pushReplacement(CupertinoPageRoute(
      builder: (_)=>Sizer(
      builder:(context, orientation, screenType){
    return const SplashScreen();
  }
    
    )
    )
    );
    
});
}



  @override
  Widget  build(BuildContext context) {
const Image(
                      image: AssetImage(
                        
                        'assets/images/corner-welcome-top.png',
                        
                      ),height: 0,);
                      const Image(
                      image: AssetImage(
                        
                        'assets/images/corner-welcome-left.png',
                        
                      ),height: 0,);
                      const Image(
                      image: AssetImage(
                        'assets/images/corner-intro-top.png',
                      ),
                      height: 0);
                      const Image(
                      image: AssetImage(
                        'assets/images/corner-intro-bottom.png',
                      ),
                      height: 0);
                       const Image(
                    image: AssetImage(
                      'assets/images/corner-bottom.png',
                    ),
                    height: 0);
                     const Image(
                    image: AssetImage(
                      'assets/images/corner-top.png',
                    ),
                    height: 0);
              

    return  const Scaffold(
      
    
    );
  }
}