import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:sizer/sizer.dart';
import 'package:sparkleship/view/signUp_in/logIn.dart';
import 'package:sparkleship/view/signUp_in/signUp.dart';

import '../global.dart';

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _Welcome();
}


class _Welcome extends State<Welcome> with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [
  SystemUiOverlay.bottom
]);  
    super.initState();
    controller = AnimationController(
      duration: 2000.ms,
      vsync: this,
    )
      ..forward()
      ..addListener(() {
        if (controller.isCompleted) {
          controller.reverse();
        }
        if (controller.isDismissed) {
          controller.forward();
        }
      });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: bodyColor,
        body: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Stack(children: [
             Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 15.h),
                  SizedBox(height: 3.h),
                  Padding(
                      padding: EdgeInsets.all(3.h),
                      child: SizedBox(
                        height: 15.h,
                      )),
                  SizedBox(height: 40.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 38.w,
                        height: 7.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF8AD4E8),
                              spreadRadius: 0.01.h,
                              blurRadius: 8,
                              offset: const Offset(0, 7),
                            )
                          ],
                        ),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LogIn()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16)),
                              elevation: 0,
                              shadowColor: mainColor,
                              foregroundColor: mainColor,
                              backgroundColor: mainColor),
                          child: Text(
                            'Log in',
                            style: setFontStyle(
                                12.sp, FontWeight.w600, Colors.white),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 2.w,
                      ),
                      Container(
                        width: 38.w,
                        height: 7.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF8AD4E8),
                              spreadRadius: 0.01.h,
                              blurRadius: 8,
                              offset: const Offset(0, 7),
                            )
                          ],
                        ),
                        child: ElevatedButton(
                          onPressed: () {
                            
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SignUp()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16)),
                              elevation: 0,
                              foregroundColor: bodySecond,
                              backgroundColor: bodySecond),
                          child: Text(
                            'Sign up',
                            style:
                                setFontStyle(12.sp, FontWeight.w600, mainColor),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            
            Animate(
              child: Positioned(
                right: 0,
                // top: 30,
                  child: Image(
                      image: const AssetImage(
                        'assets/images/corner-welcome-top.png',
                      ),
                      height: 28.h),
                ).animate(controller: controller).scale(duration: 2000.ms,begin: const Offset(1, 1),end: const Offset(1.1,1.1)),
              ),
            Positioned(
                top: 15.h,
                left: 7.w,
                child: Text('Hello',
                    style: setFontStyle(28.sp, FontWeight.bold, secondColor))),
            Positioned(
                top: 22.h,
                left: 7.w,
                child: Text("Let's get started",
                    style: setFontStyle(14.sp, FontWeight.w400, secondColor))),
            Animate(
              child: Positioned(
                left: -5.h,
                top: 30.h,
                // top: 30,
                  child: Image(
                      image: const AssetImage(
                        'assets/images/corner-welcome-left.png',
                      ),
                      height: 50.h).animate(controller: controller).scale(duration: 2000.ms,begin: const Offset(1, 1),end: const Offset(1.2,1.2)),
                ),
              ),
          ]),
        ));
  }
}
