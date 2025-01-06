import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:sparkleship/view/home.dart';
import 'package:sparkleship/global.dart';
import 'package:sparkleship/view/student/studentInfo.dart';


class AskToInfo extends StatelessWidget {
  const AskToInfo({super.key});






  @override
  Widget build(BuildContext context) {
    return Scaffold(
        

        body: Container(
          color: bodyColor,
            width: double.infinity,
            height: double.infinity,
            child: Stack(children: [
           
                 Positioned(
                right: 0,
                // top: 30,
                child: Image(
                    image: const AssetImage(
                      'assets/images/corner-top.png',
                    ),
                    height: 15.h),
              ),
              Positioned(
                left: 0,
                bottom: 0,
                // top: 30,
                child: Image(
                    image: const AssetImage(
                      'assets/images/corner-bottom.png',
                    ),
                    height: 15.h),
              ),
                  
              Center(
                child: SingleChildScrollView(
                  child: Column(
                      children: [
                        Image.asset('assets/images/askInfo.png',height:25.h),
                        SizedBox(height: 3.h),
                  
                        SizedBox(height: 20.h,
                        width:90.w,
                      child: Text('Utilize the full potential of the app by adding your academic information to help us find the best scholarships for you as well as other great features!'
                        ,textAlign: TextAlign.center,style:setFontStyle(11.sp,FontWeight.w500,secondColor)),),
                        SizedBox(height: 5.h),
                  
                        Container(
                          width: 80.w,
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
                            onPressed: () { Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => StudentInfo1("Let’s start with essentials")),
                      );},
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16)),
                                elevation: 0,
                                shadowColor: mainColor,
                                foregroundColor: mainColor,
                                backgroundColor: mainColor),
                            child: Text(
                              'Next'
                              ,
                              style: setFontStyle(
                                  11.sp, FontWeight.w600, Colors.white),
                            ),
                          ),
                        ),
                        SizedBox(height:2.h),
                         Container(
                          width: 80.w,
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
                            onPressed: () {Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => Home(0),
      ),
      (route) => false,
    );},
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16)),
                                elevation: 0,
                                shadowColor: mainColor,
                                foregroundColor:bodySecond,
                                backgroundColor: bodySecond),
                            child: Text(
                              'Skip for now'
                              ,
                              style: setFontStyle(
                                  11.sp, FontWeight.w600, mainColor),
                            ),
                          ),
                        ),
                      ],
                    ),
                ),
              ),
              
             
            ])));
  }

  
}
