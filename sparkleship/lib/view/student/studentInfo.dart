import 'dart:async';
import 'dart:convert';

import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:sparkleship/additional/custom_icons_icons.dart';
import 'package:sparkleship/global.dart';
import 'package:http/http.dart' as http;

import 'package:sparkleship/view/student/studentLanguages.dart';

class StudentInfo1 extends StatefulWidget {

   String text;
   StudentInfo1(this.text, {super.key});


  @override
  State<StudentInfo1> createState() => _StudentInfo1(text);
}

class _StudentInfo1 extends State<StudentInfo1> {

           @override
             void initState() {
    super.initState();
           fillInfo();



  }
  
String text;
   _StudentInfo1(this.text);
     bool addComma = false;
  bool pageLoaded = false;


  String  nationality = '';
  String residence = '';
  String typeOfdegree = '';
  String fieldOfStudy = '';
  String levelOfEnglish='';
  String langLevel='';
  final hoursOfExperience = TextEditingController();
  final hoursOfvolunteering = TextEditingController();
  final highSchoolDeg = TextEditingController();
  final gpaController = TextEditingController();
  final age = TextEditingController();

  double w = 0;
  double scale = 0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          setState(() {
            w = 0;
          });
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Scaffold(
            body: SizedBox(
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
                          SizedBox(height: 9.h,width:double.infinity),
                          Animate(
                            child: Text(text,
                                style: setFontStyle(
                                    14.sp, FontWeight.bold, secondColor)),
                          ).animate().fadeIn(duration: 500.ms)
                          .slideY(begin: 1.h,end: 0,delay: 800.ms,duration: 1000.ms, curve: Curves.easeInOut, ),
                          SizedBox(height: 5.h),
                          createInput(
                              'Natoinality',
                              CustomIcons.noun_flag_1004333,
                              ElevatedButton(
                                
                                onPressed: () {
                                  showCountryPicker(
                                    
                                    context: context,
                                    showPhoneCode:
                                        false, // optional. Shows phone code before the country name.
                                    onSelect: (Country country) {
                                      setState(() {
                                        nationality = country.name;
                                      });
                                    },
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                    elevation: 0,
                                    shadowColor: mainColor,
                                    foregroundColor: Colors.transparent,
                                    backgroundColor: Colors.transparent),
                                child: Text(
                                  nationality,
                                  style: const TextStyle(color: secondColor),
                                ),
                              )),

                               createInput(
                            'Your age',
                            Icons.person_outline_rounded,
                            TextField(
                              controller: age,
                              maxLength: 2,

                              style: setFontStyle(
                                  11.sp, FontWeight.w600, secondColor),
                              textAlign: TextAlign.center,
                              textAlignVertical: TextAlignVertical.center,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.only(bottom: 0),
                                counterText: '',
                                counterStyle: const TextStyle(fontSize: 0),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(16)),
                              ),
                              keyboardType: TextInputType.number,
                            ),
                          ),
                          SizedBox(
                            width: 3.w,
                          ),

                          createInput(
                              'Last aquired degree',
                              CustomIcons.noun_certificate_1018813_1,
                              Center(
                                child: DropdownButton(
                                  borderRadius: BorderRadius.circular(12),
                                  items: typesOfDegree,
                                  alignment: Alignment.center,
                                  dropdownColor: bodyColor,
                                  value:
                                      typeOfdegree == '' ? null : typeOfdegree,
                                  onChanged: (value) {
                                    setState(() {
                                      typeOfdegree = value.toString();
                                    });
                                  },
                                ),
                              ),
                              15.w),
                               createInput(
                              'English level',
                              CustomIcons.noun_english_4146437,
                              Center(
                                child: DropdownButton(
                                    borderRadius: BorderRadius.circular(12),
                                    items: levelsOfLangs,
                                    alignment: Alignment.center,
                                    dropdownColor: bodyColor,
                                    value: langLevel == '' ? null : langLevel,
                                    onChanged: (value) {
                                      
                                      setState(() {
                                        langLevel = value.toString();
                                      });
                                    },
                                  ),
                              ),
                              15.w),
                          createInput(
                              'Field of study',
                              CustomIcons.noun_study_3140051,
                              Center(
                                child: DropdownButton(
                                  borderRadius: BorderRadius.circular(12),
                                  items: feildsOfStudy,
                                  alignment: Alignment.center,
                                  dropdownColor: bodyColor,
                                  value:
                                      fieldOfStudy == '' ? null : fieldOfStudy,
                                  onChanged: (value) {
                                    setState(() {
                                      fieldOfStudy = value.toString();
                                    });
                                  },
                                ),
                              ),
                              15.w),
                          createInput(
                            'Hours of experience',
                            CustomIcons.noun_experience_5976025,
                            TextField(
                              maxLength: 4,
                              controller: hoursOfExperience,
                              style: setFontStyle(
                                  11.sp, FontWeight.w600, secondColor),
                                  
                              textAlign: TextAlign.center,
                              textAlignVertical: TextAlignVertical.center,
                              decoration: InputDecoration(
                                counterText: '',
                                contentPadding: const EdgeInsets.only(bottom: 0),
                                

                                counterStyle: const TextStyle(fontSize: 0),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(16)),
                              ),
                              keyboardType: TextInputType.number,
                            ),
                            19.w,
                          ),
                          createInput(
                            'Hours of volunteering',
                            CustomIcons.noun_volunteer_3842725_1,
                            TextField(
                              controller: hoursOfvolunteering,
                              maxLength: 4,

                              style: setFontStyle(
                                  11.sp, FontWeight.w600, secondColor),
                              textAlign: TextAlign.center,
                              textAlignVertical: TextAlignVertical.center,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.only(bottom: 0),
                                counterText: '',
                                counterStyle: const TextStyle(fontSize: 0),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(16)),
                              ),
                              keyboardType: TextInputType.number,
                            ),
                          ),
                          SizedBox(
                            width: 3.w,
                          ),



                          createInput(
                              'Current residency',
                              CustomIcons.noun_location_6681349,
                              ElevatedButton(
                                onPressed: () {
                                  showCountryPicker(
                                    context: context,

                                    showPhoneCode:
                                        false, // optional. Shows phone code before the country name.
                                    onSelect: (Country country) {
                                      setState(() {
                                        residence = country.name;
                                      });
                                    },
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                    elevation: 0,
                                    shadowColor: mainColor,
                                    foregroundColor: Colors.transparent,
                                    backgroundColor: Colors.transparent),
                                child: Text(
                                  residence,
                                  style: const TextStyle(color: secondColor),
                                ),
                              ),
                              17.w),
                               createInput(
                            'High school degree (percentage)',
                            CustomIcons.noun_mark_2977626,
                            TextField(
                              controller: highSchoolDeg,
                              maxLength: 4,
                               onChanged: (value) {
                              
                               
                                if(highSchoolDeg.text.length==2){
                                  setState(() {                                    
                                  highSchoolDeg.text='${highSchoolDeg.text}%';
                                  });
                                }
                                else if(highSchoolDeg.text.length>2){
                                  setState(() {                                    
                                  highSchoolDeg.text='';
                                  });
                                }

            
                 double floatValue = double.parse(highSchoolDeg.text.substring(0,2));
                 if(floatValue>100) {
                   setState(() {
                   highSchoolDeg.text='';
                  });

                 }
                 
              },

                              style: setFontStyle(
                                  11.sp, FontWeight.w600, secondColor),
                              textAlign: TextAlign.center,
                              textAlignVertical: TextAlignVertical.center,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.only(bottom: 0),
                                counterText: '',
                                counterStyle: const TextStyle(fontSize: 0),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(16)),
                              ),
                              keyboardType: TextInputType.number,
                            ),
                          ),
                          SizedBox(
                            width: 3.w,
                          ),
                           createInput(
                            'GPA (scale of 4)',
                            Icons.grade_rounded,
                            TextField(
                              controller: gpaController,
                              maxLength: 4,
                              onChanged: (value) {
                                                            if (gpaController
                                                                        .text
                                                                        .length ==
                                                                    2 &&
                                                                gpaController
                                                                        .text
                                                                        .substring(
                                                                            1,
                                                                            2) !=
                                                                    '.') {
                                                              gpaController
                                                                      .text =
                                                                  "${gpaController.text.substring(0, 1)}.${gpaController.text.substring(1)}";
                                                            }
                                                            double floatValue =
                                                                double.parse(
                                                                    gpaController
                                                                        .text);
                                                            if (floatValue >
                                                                4) {
                                                              gpaController
                                                                  .text = '';
                                                            }
                                                            setState(() {});
        
                 
              },

                              style: setFontStyle(
                                  11.sp, FontWeight.w600, secondColor),
                              textAlign: TextAlign.center,
                              textAlignVertical: TextAlignVertical.center,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.only(bottom: 0),
                                counterText: '',
                                counterStyle: const TextStyle(fontSize: 0),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(16)),
                              ),
                              keyboardType: TextInputType.number,
                            ),
                          ),
                          SizedBox(
                            width: 3.w,
                          ),
                          SizedBox(height: 4.h),
                          Container(
                            width: 80.w,
                            height: 7.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: lightBlue,
                                  spreadRadius: 0.01.h,
                                  blurRadius: 8,
                                  offset: const Offset(0, 7),
                                )
                              ],
                            ),
                            child: ElevatedButton(
                              onPressed: () async {
                                if (nationality == '' ||
                                    typeOfdegree == '' ||
                                    residence==''||
                                    fieldOfStudy == '' ||
                                    hoursOfExperience.text == '' ||
                                    hoursOfvolunteering.text == '') {
                                  setState(() {
                                  showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          icon: Icon(Icons.error,color: orangeColor,size: 12.w,),
          backgroundColor: bodyColor,
          surfaceTintColor: bodyColor,
          
          title:  Text('Please fill all fields',style:setFontStyle(11.sp,FontWeight.w500,orangeColor),),
          
          actions: <Widget>[
            SizedBox(width: 90.w,),
               
        
            TextButton(
              onPressed: () => Navigator.pop(context, 'OK'),
              child: Center(child: Text('OK',style: setFontStyle(10.sp, FontWeight.w600, mainColor),)),
            ),
          ],
        ),
      );
                                  });
                                }
                                else if(highSchoolDeg.text.substring(highSchoolDeg.text.length-1)!='%' ){
                                  showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          icon: Icon(Icons.error,color: orangeColor,size: 12.w,),
          backgroundColor: bodyColor,
          surfaceTintColor: bodyColor,
          
          title:  Text('Please enter a valid degree percentage',style:setFontStyle(11.sp,FontWeight.w500,orangeColor),),
          
          actions: <Widget>[
            SizedBox(width: 90.w,),
               
        
            TextButton(
              onPressed: () => Navigator.pop(context, 'OK'),
              child: Center(child: Text('OK',style: setFontStyle(10.sp, FontWeight.w600, mainColor),)),
            ),
          ],
        ),
      );
                                 
                                } 
                                else  {
                                   final SharedPreferences prefs = await SharedPreferences.getInstance();
                                   await prefs.setString('userNationality', nationality);
                                   await prefs.setString('userResidence', residence);
                                   await prefs.setString('userTypeOfDegree', typeOfdegree);
                                   await prefs.setString('userFieldOfStudy', fieldOfStudy);
                                   await prefs.setString('userLevelOfEnglish', levelOfEnglish);
                                   await prefs.setString('userHoursOfExperience', hoursOfExperience.text);
                                   await prefs.setString('userHoursOfvolunteering', hoursOfvolunteering.text);
                                   await prefs.setString('userHighSchoolDeg', highSchoolDeg.text);
                                   await prefs.setString('usergpaController', gpaController.text);
                                   await prefs.setString('userAge', age.text);
                                   await prefs.setString('userLangLevel',langLevel);




                                    patchStudentData();
                                  
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16)),
                                  elevation: 0,
                                  shadowColor: mainColor,
                                  foregroundColor: mainColor,
                                  backgroundColor: mainColor),
                              child: Text(
                                'Next',
                                style: setFontStyle(
                                    11.sp, FontWeight.w600, Colors.white),
                              ),
                            ),
                          ),
                          SizedBox(height: 2.h,),
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
                          onPressed: () {
                            
                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16)),
                              elevation: 0,
                              foregroundColor: bodySecond,
                              backgroundColor: bodySecond),
                          child: Text(
                            'Back',
                            style:
                                setFontStyle(12.sp, FontWeight.w600, mainColor),
                          ),
                        ),
                      ),
                          SizedBox(height: 5.h),
                        ],
                      ),
                    ),
                  ),
                  Center(
                    child: Animate(
                      child: Container(
                        width: 87.w,
                        height: w,
                        decoration: BoxDecoration(
                            color: bodyColor,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: orangeColor, width: 2)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 2.h,
                            ),
                            Text('Please fill all fields',
                                style: setFontStyle(
                                    11.sp, FontWeight.w500, orangeColor)),
                            SizedBox(
                              height: 3.h,
                            ),
                            SizedBox(
                              width: 25.w,
                              height: 6.h,
                              child: ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    w = 0;
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(16)),
                                    elevation: 0,
                                    shadowColor: mainColor,
                                    foregroundColor: orangeColor,
                                    backgroundColor: orangeColor),
                                child: Text(
                                  'Ok',
                                  style: setFontStyle(
                                      10.sp, FontWeight.w600, bodyColor),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                        .animate()
                        .scale(
                            begin: const Offset(0, 0),
                            end: Offset(scale, scale),
                            duration: (w + 50).ms)
                        .scale(
                          delay: (w + 50).ms,
                          begin: Offset(scale, scale),
                          end: const Offset(0.9, 0.9),
                          curve: Curves.easeInOut,
                        ),
                  )
                ]))));
  }

  Widget createInput(String title, IconData icon, Widget button,
      [double? size]) {
    return Animate(
      child: Container(
        margin: EdgeInsets.only(bottom: 2.5.h),
        width: 80.w,
        height: 18.h,
        decoration: BoxDecoration(
          color: offWhite,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: lightBlue,
              spreadRadius: 0.1.h,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 2.h),
            SizedBox(
              height: 6.5.h,
              child: Icon(
                icon,
                size: size ?? 13.w,
                color: secondColor,
              ),
            ),
            Text(title,
                style: setFontStyle(9.sp, FontWeight.bold, secondColor)),
            SizedBox(height: 1.h),
            Container(
                width: 50.w,
                height: 4.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadiusDirectional.circular(12),
                  color: const Color(0xFF8FCFE0),
                ),
                child: button)
          ],
        ),
      ),
    ).animate().fadeIn(duration: 400.ms).slideY(
          begin: 0.8.h,
          end: 0,
          delay: 800.ms,
          duration: 1100.ms,
          curve: Curves.easeInOut,
        );
  }
  void fillInfo()async{
    
     final SharedPreferences prefs = await SharedPreferences.getInstance();
     if(prefs.getString('userNationality')!=null)
     {setState(() {
                                   nationality= prefs.getString('userNationality').toString();
                                   residence= prefs.getString('userResidence').toString();
                                   typeOfdegree= prefs.getString('userTypeOfDegree').toString();
                                   langLevel=prefs.getString('userLangLevel').toString();
                                   fieldOfStudy= prefs.getString('userFieldOfStudy').toString();
                                   levelOfEnglish= prefs.getString('userLevelOfEnglish').toString();
                                   hoursOfExperience.text= prefs.getString('userHoursOfExperience').toString();
                                   hoursOfvolunteering.text= prefs.getString('userHoursOfvolunteering').toString();
                                   highSchoolDeg.text= prefs.getString('userHighSchoolDeg').toString();
                                   gpaController.text= prefs.getString('usergpaController').toString();
                                   age.text= prefs.getString('userAge').toString();
                                   
                                     
                                   });}

  }

   Future<void> patchStudentData() async {
        bool timeOut=true;
    Timer(const Duration(seconds: 15), () {timeOut? showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          icon: Icon(Icons.signal_wifi_statusbar_connected_no_internet_4_rounded,color: orangeColor,size: 12.w,),
          backgroundColor: bodyColor,
          surfaceTintColor: bodyColor,
          
          
          title:  Text("Connection error",style:setFontStyle(11.sp,FontWeight.w500,orangeColor),),
          
          actions: <Widget>[
            SizedBox(width: 90.w,),
           
               
        
            TextButton(
              onPressed: () => {Navigator.pop(context, 'OK'),Navigator.pop(context, 'OK')},
              child: Center(child: Text('OK',style: setFontStyle(10.sp, FontWeight.w600, mainColor),)),
            ),
          ],
        ),
      ):{}; });
     showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
       
          backgroundColor: bodyColor,
          surfaceTintColor: bodyColor,
          

          
          actions: <Widget>[
            SizedBox(width: 90.w,height: 5.h,),
            Center(
              child: Column(
                children: [

                  LoadingAnimationWidget.staggeredDotsWave(
                          color: mainColor,
                          size: 16.w,
                        ),
        SizedBox(height: 2.h,),

                    Text("Please wait..",style:setFontStyle(13.sp,FontWeight.w500,secondColor),),

                ],
              ),
            ),
               
        SizedBox(height: 3.h,)
          ],
        ),
      ); 

 

    final SharedPreferences prefs = await SharedPreferences.getInstance();
     userToken = prefs.getString("userToken").toString();
    final url = Uri.parse('http://$serverIp:3000/api/students/${prefs.getString('userId')}'); //Repclace Your Endpoint

    print(url);
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': "Bearer $userToken"
    };
    final body = jsonEncode({
      'lastDegreeAcquired':typeOfdegree,
      'age':int.parse(age.text),
      'nationality':nationality,
      'fieldOfStudy': fieldOfStudy,
      "hoursOfWorkExperience":int.parse( hoursOfExperience.text),
      'hoursOfVolunteeringExperience':int.parse(hoursOfvolunteering.text),
      'currentResidency':residence,
      'languageLevelLetter':langLevel,
      'gpa':gpaController.text

    });

    final response = await http.patch(url, headers: headers, body: body);
    print(response.body);
    if (response.statusCode==200) {
     

      // if (true) {
      timeOut=false;

Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const StudentLangs()),
                                  );
      
        
    }
  }

}
