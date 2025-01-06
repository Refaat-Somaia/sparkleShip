
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:sparkleship/global.dart';

import 'package:sizer/sizer.dart';


class ViewAdvisor extends StatefulWidget {
   ViewAdvisor(this.name,this.img,{super.key});
 late String name;
 late String img;


  @override
  State<ViewAdvisor> createState() => _ViewAdvisor(this.name,this.img);
}

class _ViewAdvisor extends State<ViewAdvisor> {
 late String name;
 late String img;
  _ViewAdvisor(this.name,this.img);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: bodyColor,

        body: Stack(children: [
      Positioned(
        right: 0,
        child: Image(
            image: const AssetImage(
              'assets/images/corner-top.png',
            ),
            height: 12.h),
      ),
      SizedBox(
        width: 100.w,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                SizedBox(width:5.w),
                Container(
                  width: 40.w,
                  height: 25.h,
                    decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: lightBlue.withOpacity(0.5),
                        ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 25.w,
                      
                        height: 13.h,
                        decoration: BoxDecoration(
                          image: DecorationImage(image:AssetImage(img),fit:BoxFit.cover)
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width:5.w),

                Container(
                  width: 25.w,
                  child: Text(name,style: setFontStyle(12.sp, FontWeight.w600
                  , secondColor),),
                )
                
              ],
            ),
            SizedBox(height: 2.h,),
            SizedBox(width: 90.w,child: 
            Text('fahsdjgfashjlkfasjdlkfas dashgashdg hdhgjshagjhasd sgdjdhask',
            style: setFontStyle(10.sp, FontWeight.w600, mainColor),)),
            SizedBox(height: 25.h,),

                     Animate(
                            child: Container(
                              width: 72.w,
                              height: 6.5.h,
                                  margin: EdgeInsets.only(bottom: 3.h),
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
                             
                              
                                },
                                style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(16)),
                                    elevation: 0,
                                    shadowColor: mainColor,
                                    foregroundColor: mainColor,
                                    backgroundColor: mainColor),
                                child: Text(
                                  'Contact',
                                  style: setFontStyle(
                                      12.sp, FontWeight.w600, Colors.white),
                                ),
                              ),
                            ),
                          ).animate().fadeIn(duration: 400.ms).slideY(begin: 12,end: 0,delay: 200.ms,duration: 1100.ms, curve: Curves.easeInOut, ),

             Animate(
                            child: Container(
                              width: 72.w,
                              height: 6.5.h,
                                  margin: EdgeInsets.only(bottom: 3.h),
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
                                  Navigator.pop(context);
                               
                              
                                },
                                style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(16)),
                                    elevation: 0,
                                    shadowColor: mainColor,
                                    foregroundColor: bodySecond,
                                    backgroundColor: bodySecond),
                                child: Text(
                                  'Back',
                                  style: setFontStyle(
                                      12.sp, FontWeight.w600, mainColor),
                                ),
                              ),
                            ),
                          ).animate().fadeIn(duration: 400.ms).slideY(begin: 12,end: 0,delay: 200.ms,duration: 1100.ms, curve: Curves.easeInOut, ),

                  


            
          ],
        ),
      )
        ]
        )
    );
  }
}