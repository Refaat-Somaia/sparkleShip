import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:language_picker/language_picker_dropdown.dart';
import 'package:language_picker/languages.dart';
import 'package:sizer/sizer.dart';

import 'package:sparkleship/global.dart';
import 'package:sparkleship/view/home.dart';
import 'package:sparkleship/view/student/studentPrefrences.dart';

class StudentLangs extends StatefulWidget {
  const StudentLangs({super.key});

  @override
  State<StudentLangs> createState() => _StudentLangs();
}

class Langs{
  String language;
  String level;

  Langs(this.language,this.level);
}

class _StudentLangs extends State<StudentLangs> {
  final supportedLanguages = [
    Languages.english,
    Languages.french,
    Languages.japanese,
    Languages.korean,
  ];

  List<Widget> languages=[];
  List<String> studentLanguages=[];
  List<String> studentLevels=[];

  String motherLang='Arabic';

  String langLevel = '';
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
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
                  SingleChildScrollView(
                      child: SizedBox(
                    width: double.infinity,
                    child: Column(children: [
                      SizedBox(
                        height: 10.h,
                      ),
                      Animate(
                        child: Text('Languages',
                            style: setFontStyle(
                                14.sp, FontWeight.bold, secondColor)),
                      ).animate().fadeIn(duration: 500.ms)
                      .slideY(begin: 0.7.h,end: 0,delay: 800.ms,duration: 1000.ms, curve: Curves.easeInOut, ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Animate(
                        child: Container(
                          width: 90.w,
                          height: 15.h,
                          decoration: BoxDecoration(
                            color: offWhite,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: lightBlue,
                                spreadRadius: 0.01.h,
                                blurRadius: 8,
                                offset: const Offset(0, 7),
                              )
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Mother language",
                                style: setFontStyle(
                                    11.sp, FontWeight.w500, secondColor),
                              ),
                              SizedBox(
                             
                                child:Container(
                        margin: EdgeInsets.only(bottom: 2.h),
                        width: 60.w,
                        height: 6.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadiusDirectional.circular(12),
                          color: const Color(0xFF8FCFE0),
                        ),
                        child: Center(
                          child: LanguagePickerDropdown(
                            
                                      initialValue: Languages.arabic,
                                      onValuePicked: (Language language) {
                                        motherLang=language.name;
                                        print(language.name);
                                      }),
                        ),
                                 ) )
                            ],
                          ),
                        ),
                      ).animate().fadeIn().slideY(begin: 12,delay: 800.ms,end: 0,duration: 1100.ms, curve: Curves.easeInOut, ),
                      SizedBox(
                        height: 3.h,
                      ),
                      
                           SizedBox(
                              height: 3.h,
                            ),
                            
                            for(int i=0;i<languages.length;i++)
                            languages[i],
                      Animate(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: 45.w,
                                  height: 6.5.h,
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
                                      setState(() {
                                        languages.add(createLanguage((languages.length)));
                                      });
                                  
                                    },
                                    style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(16)),
                                        elevation: 0,
                                        shadowColor: mainColor,
                                        foregroundColor: mainColor,
                                        backgroundColor: mainColor),
                                    child: Text(
                                      'Add',
                                      style: setFontStyle(
                                          12.sp, FontWeight.w600, Colors.white),
                                    ),
                                  ),
                                ),
                          SizedBox(width: 7.w,),

                                   Container(
                              width: 15.w,
                              height: 6.h,
                              decoration: BoxDecoration(
                                boxShadow: [
                                      BoxShadow(
                                        color: const Color(0xFF8AD4E8),
                                        spreadRadius: 0.01.h,
                                        blurRadius: 8,
                                        offset: const Offset(0, 7),
                                      )
                                    ],
                                borderRadius: BorderRadius.circular(16),
                            
                              ),
                              child: TextButton(
                                onPressed: () {
                                  setState(() {
                                    languages.removeLast();
                                    studentLanguages.removeLast();
                                  });
                              
                                },
                                style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(16)),
                                    elevation: 0,
                                    shadowColor: mainColor,
                                    
                                    foregroundColor: mainColor,
                                    backgroundColor: mainColor),
                                child: Center(
                                  child: Icon(Icons.delete,color: bodyColor,size: 3.h,))
                              ),
                            ),
                              ],
                            ),
                          ).animate().fadeIn(duration: 400.ms).slideY(begin: 12,end: 0,delay: 700.ms,duration: 1100.ms, curve: Curves.easeInOut, ),
                          SizedBox(height: 7.h,),
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
                                  Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const StundentPref()),
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
                                  'Next',
                                  style: setFontStyle(
                                      12.sp, FontWeight.w600, Colors.white),
                                ),
                              ),
                            ),
                          ).animate().fadeIn(duration: 400.ms).slideY(begin: 12,end: 0,delay: 700.ms,duration: 1100.ms, curve: Curves.easeInOut, ),

                          SizedBox(height: 2.h,),
                          Animate(
                            child: Container(
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
                          ).animate().fadeIn(duration: 400.ms).slideY(begin: 12,end: 0,delay: 700.ms,duration: 1100.ms, curve: Curves.easeInOut, ),
                          
                    ]),
                  ))
                ]))));
  }
  Widget createLanguage(int index){
    return Animate(
      child: Container(
        margin: EdgeInsets.only(bottom: 2.h),
                          width: 90.w,
                          height: 22.h,
                          decoration: BoxDecoration(
                            color: offWhite,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: lightBlue,
                                spreadRadius: 0.01.h,
                                blurRadius: 8,
                                offset: const Offset(0, 7),
                              )
                            ],
                          ),
                          child: Column(
                            children: [
                              SizedBox(height: 2.h),
                              Text(
                                "Language",
                                style: setFontStyle(
                                    11.sp, FontWeight.w500, secondColor),
                              ),
                              SizedBox(
                                child:Container(
                        margin: EdgeInsets.only(bottom: 1.h),
                        width: 60.w,
                        height: 6.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadiusDirectional.circular(12),
                          color: const Color(0xFF8FCFE0),
                        ),
                        child: LanguagePickerDropdown(
                                    initialValue: Languages.english,
                                    onValuePicked: (Language language) {
                                      if(studentLanguages.contains(language.name)){
                                        setState(() {
                                        languages.removeLast();
                                        });
                                        
                                          showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          icon: Icon(Icons.error,color: orangeColor,size: 12.w,),
          backgroundColor: bodyColor,
          surfaceTintColor: bodyColor,
          
          title:  Text('You have already added this language',style:setFontStyle(13.sp,FontWeight.w500,orangeColor),),
          
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
                                      else{
                                      studentLanguages.add(language.name);
                                      print(studentLanguages);}
                                    }),
                              ),),
                               Text(
                                "Level",
                                style: setFontStyle(
                                    11.sp, FontWeight.w500, secondColor),
                              ),
                              
                              Container(
                                width: 50.w,
                                height: 4.h,
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadiusDirectional.circular(12),
                                  color: const Color(0xFF8FCFE0),
                                ),
                                
                                child: Center(
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
                              ),
                              SizedBox(
                                height: 1.h,
                              ),
                           
                            ],
                          ),
                          
                        ),
    ).animate().fadeIn(duration: 400.ms).slideY(begin: 12,end: 0,duration: 1100.ms, curve: Curves.easeInOut, );
  }
}
