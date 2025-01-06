
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:sparkleship/global.dart';

import 'package:sizer/sizer.dart';

import 'package:url_launcher/url_launcher.dart';

class ScholarshipDetails extends StatefulWidget {
  const ScholarshipDetails(this.scholarship, {super.key});

  @override
  State<ScholarshipDetails> createState() => _ScholarshipDetails(scholarship);

  final Map<String, dynamic> scholarship;
}

class _ScholarshipDetails extends State<ScholarshipDetails> {
  final Map<String, dynamic> scholarship;
  _ScholarshipDetails(this.scholarship);

  @override
  void initState() {
    super.initState();
    getUserInfo();
    weighted_percentage(scholarship);
  }

  void getUserInfo() async {

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if(prefs.getString('userFieldOfStudy')!=null)
{  setState(() {
    fieldOfStudy = prefs.getString('userFieldOfStudy').toString();
    typeOfdegree = prefs.getString('userTypeOfDegree').toString();
    levelOfEnglish = prefs.getString('userLangLevel').toString();
    gpa = prefs.getString('usergpaController').toString();
    hoursOfExperience = prefs.getString('userHoursOfExperience').toString();
    hoursOfvolunteering =
        prefs.getString('userHoursOfvolunteering').toString();
  });}
  }

  String fieldOfStudy = '';
  String typeOfdegree = '';
  String levelOfEnglish = '';
  String gpa = '';
  String hoursOfvolunteering = '';
  String hoursOfExperience = '';
  Map<String, int> weightOfLevels = {
    "A1": 1,
    "A2": 2,
    "B1": 3,
    "B2": 4,
    "C1": 5,
    "C2": 6,
  };
  int weight = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Stack(children: [
              Positioned(
                right: 0,
                child: Image(
                    image: const AssetImage(
                      'assets/images/corner-top.png',
                    ),
                    height: 12.h),
              ),
              Positioned(
                left: 0,
                bottom: 0,
                // top: 30,
                child: Image(
                    image: const AssetImage(
                      'assets/images/corner-bottom.png',
                    ),
                    height: 13.h),
              ),
              SingleChildScrollView(
                  child: SizedBox(
                width: double.infinity,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 3.h),
                      Row(
                        children: [
                          SizedBox(width: 3.w),
                          IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: Icon(
                                Icons.arrow_back_ios_new_rounded,
                                size: 8.w,
                                color: secondColor,
                              )),
                        ],
                      ),
                      Container(
                        width: 60.w,
                        height: 15.h,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image:
                                    AssetImage('assets/images/scholarship.png'),
                                fit: BoxFit.cover),
                            color: mainColor,
                            borderRadius:
                                BorderRadius.all(Radius.circular(12))),
                      ),
                      SizedBox(height: 2.h),
                      Container(
                          padding: EdgeInsets.symmetric(horizontal: 4.w),
                          child: Text(
                            scholarship['title']??"title"
                            ,
                            style: setFontStyle(
                                13.sp, FontWeight.bold, secondColor),
                            textAlign: TextAlign.center,
                          )),
                      Container(
                          padding: EdgeInsets.symmetric(horizontal: 2.w),
                          child: Center(
                              child: Text(
                            scholarship['description'] ?? "description",
                            style: setFontStyle(
                                9.sp, FontWeight.w500, secondColor),
                            textAlign: TextAlign.center,
                          ))),
                      SizedBox(height: 2.h),
                      Container(
                        width: double.infinity,
                        color: bodySecond,
                        child: Row(
                          children: [
                            Container(
                              width: 80.w,
                              padding: EdgeInsets.all(4.w),
                              child: Text(scholarship['country']!=null? "Country: " + scholarship['country']:"Country: Unknown",
                                  style: setFontStyle(
                                      9.sp, FontWeight.w500, mainColor)),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      Container(
                        width: double.infinity,
                        color: bodySecond,
                        child: Row(
                          children: [
                            Container(
                              width: 80.w,
                              padding: EdgeInsets.all(4.w),
                              child: Text(
                                 scholarship['providedBy']!=null? "Provided by: " + scholarship['providedBy']:"Provided by: Unkown",
                                  style: setFontStyle(
                                      9.sp, FontWeight.w500, mainColor)),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      Container(
                        width: double.infinity,
                        color: bodySecond,
                        child: Row(
                          children: [
                            Container(
                              width: 80.w,
                              padding: EdgeInsets.all(4.w),
                              child: Text(scholarship['funding']!=null?"Funding: " + scholarship['funding']:"Funding: Unknown",
                                  style: setFontStyle(
                                      9.sp, FontWeight.w500, mainColor)),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      createAtt('fieldOfStudy'),
                      createAtt('requiredDegree'),
                      createAtt('languageLevelLetter'),
                      createAtt('minimumGPA'),
                      createAtt('hoursOfWorkExperience'),
                      createAtt('hoursOfVolunteeringExperience'),
                      SizedBox(
                        height: 2.h,
                      ),
                      Column(
                        children: [
                          Container(
                            height: 15.h,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: bodyColor,
                                border: Border.all(
                                    color: (weight  <= 100 &&
                                            weight  >= 90)
                                        ? const Color.fromARGB(
                                            255, 126, 211, 128)
                                        : (weight  <= 89 && weight >= 70)
                                            ? const Color(0xFFF6CC59)
                                            : (weight  == 0)
                                                ? lightBlue
                                                : orangeColor,
                                    width: 5)),
                            child: Center(
                              child: Text(
                                '%$weight',
                                style: setFontStyle(
                                    12.sp,
                                    FontWeight.w600,
                                    (weight  <= 100 && weight >= 90)
                                        ? Colors.green
                                        : (weight <= 89 && weight >= 70)
                                            ? const Color(0xFFF6CC59)
                                            : (weight == 0)
                                                ? lightBlue
                                                : orangeColor),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 1.h,
                          ),
                          Text('Overall matching percentage',
                              style: setFontStyle(
                                  10.sp, FontWeight.w600, mainColor))
                        ],
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
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
                          onPressed: () async {
                            Uri uri = Uri.parse(scholarship['link']??"");
                            if (await canLaunchUrl(uri)) {
                              await launchUrl(uri);
                            } else {
                              // can't launch url
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16)),
                              elevation: 0,
                              foregroundColor: mainColor,
                              backgroundColor: mainColor),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Go to website',
                                style: setFontStyle(
                                    12.sp, FontWeight.w500, bodyColor),
                              ),
                              SizedBox(
                                width: 3.w,
                              ),
                              Icon(
                                Icons.language_rounded,
                                color: bodyColor,
                                size: 10.w,
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                    ]),
              )),
            // Container(width: 100.w,height: 20.h,color: Colors.black.withOpacity(0.5),
            // padding: EdgeInsets.all(3.w),child: 
            // Container(decoration: BoxDecoration(color: mainColor),),)

            ])));
  }

  Widget createAtt(String att) {

    int p = -1;

    if (att == 'fieldOfStudy') {
         if(scholarship["fieldOfStudy"]!=null){

      if (fieldOfStudy == '') {
        p = -1;
      } else if (scholarship["fieldOfStudy"] == fieldOfStudy) {
        p = 100;
      } else {
        p = 0;
      }
         }
    } else if (att == 'requiredDegree') {
         if(scholarship["requiredDegree"]!=null){

      if (typeOfdegree == '') {
        p = -1;
      } else if (scholarship["requiredDegree"] == typeOfdegree) {
        p = 100;
      } else {
        p = 0;
      }
         }
    } else if (att == "languageLevelLetter") {
         if(scholarship["languageLevelLetter"]!=null){
      if (levelOfEnglish == '') {
        p = -1;
      } else if ((weightOfLevels[scholarship[att]])!.toInt() <=
          (weightOfLevels[levelOfEnglish])!.toInt()) {
        p = 100;
      } else {
        p = 0;
      }
    } }else if (att == "minimumGPA") {
        if(scholarship["minimumGPA"]!=null&&scholarship["minimumGPA"]!="Not applicable"&&scholarship["minimumGPA"]!="Not specified"){
      if (gpa == '') {
        p = -1;
      } else if (double.parse(scholarship["minimumGPA"]) < double.parse(gpa)) {
        p = 100;
      } else {
        p = ((double.parse(gpa) / double.parse(scholarship[att])) * 100).toInt();
      }
    }} else if (att == "hoursOfVolunteeringExperience") {
        if(scholarship["hoursOfVolunteeringExperience"]!=null&&scholarship["hoursOfVolunteeringExperience"]!="Not applicable"){

      if (hoursOfvolunteering == '') {
        p = -1;
      } else if (scholarship[att] < double.parse(hoursOfvolunteering)) {
        p = 100;
      } else {
        p = ((int.parse(hoursOfvolunteering) / scholarship[att]) * 100).toInt();
      }
    }} else if (att == "hoursOfWorkExperience") {
        if(scholarship["hoursOfWorkExperience"]!=null&&scholarship["hoursOfWorkExperience"]!="Not applicable"){

      if (hoursOfExperience == '') {
        p = -1;
      } else if (scholarship[att] < double.parse(hoursOfExperience)) {
        p = 100;
      } else {
        p = ((int.parse(hoursOfExperience) / scholarship[att]) * 100).toInt();
      }
    }}
//                 const uri = Uri.parse("https://flutter.io");
// if (await canLaunchUrl(uri)){
//     await launchUrl(uri);
// } else {
//     // can't launch url
// }
   
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 1.h),
      decoration: BoxDecoration(
          color: bodySecond,
          border: Border(
              bottom: BorderSide(
                  color: (p <= 100 && p >= 90)
                      ? Colors.green
                      : (p <= 89 && p >= 70)
                          ? const Color(0xFFF6CC59)
                          : (p == -1)
                              ? lightBlue
                              : orangeColor,
                  width: 2))),
      child: Row(
        children: [
          Container(
            width: 80.w,
            padding: EdgeInsets.all(4.w),
            child: Text(
                (att == 'fieldOfStudy'
                        ? "Field of study: "
                        : att == 'requiredDegree'
                            ? "Required degree: "
                            : att == 'languageLevelLetter'
                                ? 'Required English level: '
                                : att == 'hoursOfWorkExperience'
                                    ? 'Required hours of experience: '
                                    : att == 'minimumGPA'
                                        ? 'Required GPA: '
                                        : att == 'hoursOfVolunteeringExperience'
                                            ? 'Required hours of volunteering: '
                                            : 'gfdsgs') +
                    scholarship[att].toString(),
                style: setFontStyle(9.sp, FontWeight.w500, mainColor)),
          ),
          Container(
            width: 12.w,
            height: 12.w,
            margin: EdgeInsets.all(1.w),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: (p <= 100 && p >= 90)
                  ? Colors.green
                  : (p <= 89 && p >= 70)
                      ? const Color(0xFFF6CC59)
                      : (p == -1)
                          ? lightBlue
                          : orangeColor,
            ),
            child: Center(
              child: Text(
                p == -1 ? "?" : '$p%',
                style: setFontStyle(8.sp, FontWeight.w400, bodyColor),
              ),
            ),
          ),
        ],
      ),
    );
  }

 weighted_percentage(Map<String, dynamic> scholarship)async{
   int p = 0;

    Map<String, int> features_weights = {
      'fieldOfStudy': 5,
      'requiredDegree': 5,
      'languageLevelLetter': 4,
      'minimumGPA': 3,
      'hoursOfWorkExperience': 3,
      'hoursOfVolunteeringExperience': 2
    };

    int total_weights=0;
    
    features_weights.forEach((key, value) { 
      total_weights+=value;
    });

        final SharedPreferences prefs = await SharedPreferences.getInstance();
  if(prefs.getString('userFieldOfStudy')!=null){


  features_weights.forEach((key, value) {
 
    if(key=='fieldOfStudy') {
          if(scholarship["fieldOfStudy"]!=null){
  if (scholarship[key] == fieldOfStudy) {
      weight += value;
    }
    }
    }
    else if(key=='requiredDegree'){
          if(scholarship["requiredDegree"]!=null){
          if (scholarship[key] ==typeOfdegree ) {
      weight += value;
    }
          }

    }
    else if (key == "languageLevelLetter") {
          if(scholarship["languageLevelLetter"]!=null){

      if ((weightOfLevels[scholarship[key]])!.toInt() <= (weightOfLevels[levelOfEnglish])!.toInt()) {
      weight += value;
    } 
          }
  }
  else if (key == "minimumGPA") {
     if(scholarship["minimumGPA"]!=null&&scholarship["minimumGPA"]!="Not applicable"&&scholarship["minimumGPA"]!="Not specified"){
    if (double.parse(scholarship["minimumGPA"]) < double.parse(gpa)) {
      weight += value;
    } else {
      p = double.parse(gpa) ~/ double.parse(scholarship[key]);
      weight += p*value;
    }
  }}

  else if (key == "hoursOfVolunteeringExperience") {
         if(scholarship["hoursOfVolunteeringExperience"]!=null&&scholarship["hoursOfVolunteeringExperience"]!="Not applicable"){
    if (scholarship[key] < double.parse(hoursOfvolunteering)) {
      weight += value;
    } else {
      p = int.parse(hoursOfvolunteering) ~/ scholarship[key];
      weight += p*value;
    }
         }
  }
    else if (key == "hoursOfWorkExperience") {
         if(scholarship["hoursOfWorkExperience"]!=null&&scholarship["hoursOfWorkExperience"]!="Not applicable"){

    if (scholarship[key] < double.parse(hoursOfExperience)) {
      weight += value;
    } else {
      p = int.parse(hoursOfExperience) ~/ scholarship[key];
      weight += p*value;
    }
  }}

    
  });

setState(() {
weight=((weight/total_weights)*100).ceil();

});
}
 } 
}


