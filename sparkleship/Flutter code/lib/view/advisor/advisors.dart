
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:sparkleship/global.dart';

import 'package:sizer/sizer.dart';
import 'package:sparkleship/view/advisor/viewAdvisor.dart';
import 'package:sparkleship/view/groups/viewGroup.dart';


class Advisors extends StatefulWidget {
  const Advisors({super.key});

  @override
  State<Advisors> createState() => _Advisors();
}

class _Advisors extends State<Advisors> {

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
        Padding(
               padding:  EdgeInsets.only(top: 6.h),
        child: Container(
          height: 10.h,
          child: Center(
          child: Text("Advisors",style: setFontStyle(16.sp, FontWeight.w600, secondColor),))),
        ),
  Padding(
               padding:  EdgeInsets.only(top: 20.h,left: 3.w,right: 3.w),
               child: GridView(
                gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2
               ),
               children: [
                createAdvisor("name", 'rate'),
                createAdvisor("name", 'rate'),
                createAdvisor("name", 'rate'),
                createAdvisor("name", 'rate'),
                createAdvisor("name", 'rate'),
                createAdvisor("name", 'rate'),
                createAdvisor("name", 'rate'),
               ]))

        ]
        )
    );
  }

  Widget createAdvisor(String name, String rate,) {
    

    return TextButton(
      onPressed: (){
                    Navigator.push(context,CupertinoPageRoute(builder:
                     (context)=>ViewAdvisor(name,'assets/images/user.png')));

      },
      child: Container(
        margin: EdgeInsets.only(right: 3.w),
        width: 40.w,
        decoration: BoxDecoration(
          color: bodySecond,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            SizedBox(height: 2.h,),
            Container(
                width: 11.h,
                height: 8.h,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle),
                    child: Image.asset('assets/images/user.png',fit: BoxFit.contain,),),
            SizedBox(
              height: 6.h,
              child: Center(
               
                    child: Text(
                  name,
                  style: setFontStyle(10.sp, FontWeight.normal,
                      const Color.fromARGB(255, 51, 113, 142)),textAlign: TextAlign.center,
                ),
              ),
            ),
            SizedBox(
              height: 3.h,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    rate,
                    style: setFontStyle(
                        10.sp, FontWeight.normal, const Color(0xFF6A9EB5)),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 0.5.h),
                    child: const Icon(
                      Icons.star_rate_rounded,
                      color: Color(0xFFF36F56),
                    ),
                  )
                ],
              ),
            ),
           
      
          ],
        ),
      ),
    );


  }
}