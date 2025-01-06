import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sparkleship/global.dart';
import 'package:http/http.dart' as http;

import 'package:sizer/sizer.dart';
import 'package:sparkleship/view/groups/groups.dart';

class ViewNewGroup extends StatefulWidget {
  ViewNewGroup(this.name, this.img, this.membersCount,this.fieldOfStudy,this.description, this.id,{super.key});
  late String name;
  late AssetImage img;
  late int id;
  late int membersCount;
  late String fieldOfStudy;
  late String description;

  @override
  State<ViewNewGroup> createState() =>
      _ViewNewGroup(this.name, this.img, this.membersCount,this.fieldOfStudy,this.id,this.description);
}

class _ViewNewGroup extends State<ViewNewGroup> {
  late String name;
  late int id;
  late AssetImage img;
  late int membersCount;
 late  String fieldOfStudy;
  late String description;


  _ViewNewGroup(this.name, this.img, this.membersCount,this.fieldOfStudy,this.id,this.description);

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
                    SizedBox(width: 5.w),
                    Column(

                      children: [
                        Container(
                          width: 40.w,
                          height: 20.h,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: lightBlue.withOpacity(0.5),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 30.w,
                                height: 15.h,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        image: img, fit: BoxFit.cover)),
                              ),
                            ],
                          ),
                        ),
                         Center(
                           child: Container(
                                                 width: 40.w,
                                                 child: Text(
                                                   name,
                                                   style:
                              setFontStyle(12.sp, FontWeight.w600, mainColor,),
                              textAlign: TextAlign.center,
                                                 ),
                                               ),
                         ),
                      ],
                    ),
                    SizedBox(width: 5.w),
                    Container(
                      width: 40.w,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              SizedBox(
                                child: Text(
                                  "Field Of Study: ",
                                  style:
                                      setFontStyle(9.sp, FontWeight.w600, secondColor.withOpacity(1)),
                                ),
                              ),
                              Text(
                                fieldOfStudy,
                                style:
                                    setFontStyle(9.sp, FontWeight.w600, mainColor),
                              ),
                            ],
                          ),
                          SizedBox(height: 3.h,),
                            Row(
                            children: [
                              Text(
                                "Members count: ",
                                style:
                                    setFontStyle(9.sp, FontWeight.w600, secondColor.withOpacity(1)),
                              ),
                              Text(
                                membersCount.toString(),
                                style:
                                    setFontStyle(9.sp, FontWeight.w600, mainColor),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    SizedBox(width: 5.w),
                   
                  ],
                ),
                SizedBox(
                  height: 5.h,
                ),
                SizedBox(
                    width: 90.w,
                    child: Text(
                      description,
                      style: setFontStyle(10.sp, FontWeight.w600, secondColor),
                    )),
                SizedBox(
                  height: 15.h,
                ),
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
                      onPressed: () async{
                         final SharedPreferences prefs =
                                        await SharedPreferences.getInstance();
                                        for(int i=0;i<5;i++){
                                          if(prefs.getString("userGroups,$i")==null){
                                            prefs.setString("userGroups,$i", name);
                                            prefs.setString("userGroups,$i,description", description);
                                            prefs.setString("userGroups,$i,field",fieldOfStudy);
                                            prefs.setString("userGroups,$i,memberCount",(membersCount+1).toString());
                                            break;
                                          }

                                      }
                                      final url=Uri.parse('http://$serverIp:3000/api/groups/$id');
      String? token= await prefs.getString('userToken');
// int newCount=membersCount+1;
//     final headers = {
//       'Content-Type': 'application/json',
//       'Authorization': "Bearer $token"
//     };
//     final body=jsonEncode({
//       "memberCount":newCount
//     });

//     final response=await http.patch(url,headers: headers,body: body);
//     if(response.statusCode==200){
                                    Navigator.pushAndRemoveUntil(
      context,
      CupertinoPageRoute(
        builder: (BuildContext context) =>const Groups(),
      ),
      (route) => false,
    );

                            // }            

                      },
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16)),
                          elevation: 0,
                          shadowColor: mainColor,
                          foregroundColor: mainColor,
                          backgroundColor: mainColor),
                      child: Text(
                        'Join',
                        style: setFontStyle(12.sp, FontWeight.w600, bodyColor),
                      ),
                    ),
                  ),
                ).animate().fadeIn(duration: 400.ms).slideY(
                      begin: 12,
                      end: 0,
                      delay: 200.ms,
                      duration: 1100.ms,
                      curve: Curves.easeInOut,
                    ),

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
                      onPressed: () {Navigator.pop(context);},
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16)),
                          elevation: 0,
                          shadowColor: mainColor,
                          foregroundColor: bodySecond,
                          backgroundColor: bodySecond),
                      child: Text(
                        'Back',
                        style: setFontStyle(12.sp, FontWeight.w600, mainColor),
                      ),
                    ),
                  ),
                ).animate().fadeIn(duration: 400.ms).slideY(
                      begin: 12,
                      end: 0,
                      delay: 200.ms,
                      duration: 1100.ms,
                      curve: Curves.easeInOut,
                    ),
                
              ],
            ),
          )
        ]));
  }
}
