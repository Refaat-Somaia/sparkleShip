import 'package:sizer/sizer.dart';

import 'package:flutter/material.dart';
import 'package:sparkleship/view/home.dart';
import 'package:sparkleship/view/student/account.dart';

import '../global.dart';

class Adds extends Home1{


late BuildContext context;
Adds(this.context);
List<dynamic> scholarships=[];
   


 List<Widget> slidersFilled(BuildContext context1){
  
  sliders.add(Container(
                                 decoration: BoxDecoration(
                      color: bodySecond,
                      borderRadius: BorderRadius.circular(16),
                      
                    ),
                    width: 60.w,
                    height: 18.h,
                 
                    child: Row(children: [
                      Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                top: 2.h, left: 2.h, bottom: 1.h),
                            child: SizedBox(
                                width: 40.w,
                                child: Text(
                                    "Haven't joined new groups in a while?",
                                    style: setFontStyle(
                                        9.sp, FontWeight.bold, secondColor))),
                          ),
                      
                          SizedBox(
                            width: 27.w,
                            child: ElevatedButton(
                                onPressed: () {
          Navigator.pushAndRemoveUntil(
      context1,
      MaterialPageRoute(
        builder: (BuildContext context1) => Home(2),
      ),
      (route) => false,
    );
                                },
                                style: const ButtonStyle(
                                    backgroundColor: MaterialStatePropertyAll(
                                        mainColor),
                                    foregroundColor: MaterialStatePropertyAll(
                                      mainColor,
                                    )),
                                child: Text('Groups',
                                    style: setFontStyle(
                                        8.sp, FontWeight.bold, bodyColor))),
                          )
                        ],
                      ),
                      Image.asset(
                        'assets/images/groups2.png',
                        height: 20.h,
                        width: 40.w,
                      )
                    ]),
                  ),);

                  sliders.add( Container(
                                 decoration: BoxDecoration(
                                            color: bodySecond,

                      borderRadius: BorderRadius.circular(16),
                      
                    ),
                    width: 60.w,
                    height: 18.h,
                 
                    child: Row(children: [
                      Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                top: 2.h, left: 2.h, bottom: 1.h),
                            child: SizedBox(
                                  width: 40.w,
                                child: Text(
                                    'Continue setting up your account',
                                    style: setFontStyle(
                                        9.sp, FontWeight.bold, secondColor))),
                          ),
                      
                          SizedBox(
                            width: 27.w,
                            child: ElevatedButton(
                                onPressed: () {

                                  
                                       Navigator.push(
      context1,
      MaterialPageRoute(
        builder: (BuildContext context1) => const Account(),
      ),
    );
                                  
                               
                                },
                                style: const ButtonStyle(
                                    backgroundColor: MaterialStatePropertyAll(
                                        mainColor),
                                    foregroundColor: MaterialStatePropertyAll(
                                      mainColor,
                                    )),
                                child: Text('Set up',
                                    style: setFontStyle(
                                        8.sp, FontWeight.bold, Colors.white))),
                          )
                        ],
                      ),
                      Image.asset(
                        'assets/images/profile.png',
                        height: 20.h,
                        width: 40.w,
                      )
                    ]),
                  ),);

                  sliders.add(Container(
                                 decoration: BoxDecoration(
                                            color: bodySecond,

                      borderRadius: BorderRadius.circular(16),
                      
                    ),
                    width: 60.w,
                    height: 18.h,
                 
                    child: Row(children: [
                      Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                top: 2.h, left: 2.h, bottom: 1.h),
                            child: SizedBox(
                                 width: 40.w,
                                child: Text(
                                    'Let’s explore\nopportunities together!',
                                    style: setFontStyle(
                                        9.sp, FontWeight.bold, secondColor))),
                          ),
                      
                          SizedBox(
                            width: 30.w,
                            child: ElevatedButton(
                                onPressed: () {
                                  Navigator.pushAndRemoveUntil(
      context1,
      MaterialPageRoute(
        builder: (BuildContext context1) => Home(2),
      ),
      (route) => false,
    );
                                  
                               
                                },
                                style: const ButtonStyle(
                                    backgroundColor: MaterialStatePropertyAll(
                                        mainColor),
                                    foregroundColor: MaterialStatePropertyAll(
                                      mainColor,
                                    )),
                                child: Text('Search',
                                    style: setFontStyle(
                                        8.sp, FontWeight.bold, Colors.white))),
                          )
                        ],
                      ),
                      Image.asset(
                        'assets/images/home-1.png',
                        height: 20.h,
                        width: 40.w,
                      )
                    ]),
                  ),);

                  return sliders;

}


static List<Widget>  sliders=sliders=[
                 
                  
                  ];
}