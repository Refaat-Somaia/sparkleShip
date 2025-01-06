import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'package:sizer/sizer.dart';

import 'package:sparkleship/global.dart';
import 'package:sparkleship/view/home.dart';

import '../../additional/filtersMethods.dart';

class StundentPref extends StatefulWidget {
  const StundentPref({super.key});

  @override
  State<StundentPref> createState() => _StundentPref();
}

class _StundentPref extends State<StundentPref> {

String prferedCountry='';
String selectedFinance='';

  
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
                        child: Text('Your preferences',
                            style: setFontStyle(
                                14.sp, FontWeight.bold, secondColor)),
                      ).animate().fadeIn(duration: 500.ms)
                      .slideY(begin: 0.7.h,end: 0,delay: 800.ms,duration: 1000.ms, curve: Curves.easeInOut, ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Animate(
                        child: SizedBox(
                          width: 90.w,
                          child: Center(
                            child: Text('What is the degree you are looking for?',
                            style: setFontStyle(
                                      10.sp, FontWeight.w500, secondColor),textAlign: TextAlign.center,),
                          ),
                          
                        ),
                      ).animate().fadeIn().slideY(begin: 30,end: 0,delay: 800.ms,duration: 1100.ms, curve: Curves.easeInOut, ),
                      SizedBox(
                        height: 1.h,
                      ),
                      Animate(
                        child: Container(
                          margin: EdgeInsets.only(bottom: 3.h),
                          width: 85.w,
                          height: 7.h,
                          decoration: BoxDecoration(
                            color: bodySecond,
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
                          child:
                           Center(
                             child: DropdownButton(
                                         borderRadius: BorderRadius.circular(12),
                                         items: typesOfDegree,
                                         alignment: Alignment.center,
                                         
                                         dropdownColor: bodyColor,
                                         value: typeOfdegree == '' ? null : typeOfdegree,
                                         onChanged: (value) {
                                           setState(() {
                                             typeOfdegree = value.toString();
                                           });
                                         },
                                       ),
                           ),
                        ),
                      ).animate().fadeIn(duration: 400.ms).slideY(begin: 12,end: 0,delay: 800.ms,duration: 1100.ms, curve: Curves.easeInOut, ),




  Animate(
                        child: SizedBox(
                          width: 90.w,
                          child: Center(
                            child: Text('What country would you favor most?',
                            style: setFontStyle(
                                      10.sp, FontWeight.w500, secondColor),textAlign: TextAlign.center,),
                          ),
                          
                        ),
                      ).animate().fadeIn().slideY(begin: 30,end: 0,delay: 800.ms,duration: 1100.ms, curve: Curves.easeInOut, ),
                      SizedBox(
                        height: 1.h,
                      ),
                      Animate(
                        child: Container(
                          margin: EdgeInsets.only(bottom: 3.h),
                          width: 85.w,
                          height: 7.h,
                          decoration: BoxDecoration(
                            color: bodySecond,
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
                          child:
                           Center(
                             child:   TextButton(
                                onPressed: () {
                                  showCountryPicker(
                                    context: context,
                                    showPhoneCode:
                                        false, // optional. Shows phone code before the country name.
                                    onSelect: (Country country) {
                                      setState(() {
                                        prferedCountry = country.name;
                                      });
                                    },
                                  );
                                },
                                child: Text(prferedCountry,style: setFontStyle(
                                      12.sp, FontWeight.w600, secondColor)),
                                )
                           ),
                        ),
                      ).animate().fadeIn(duration: 400.ms).slideY(begin: 12,end: 0,delay: 800.ms,duration: 1100.ms, curve: Curves.easeInOut, ),

                      



                        Animate(
                        child: SizedBox(
                          width: 90.w,
                          child: Center(
                            child: Text('What type of scholarship are you looking for?',
                            style: setFontStyle(
                                      10.sp, FontWeight.w500, secondColor),textAlign: TextAlign.center,),
                          ),
                          
                        ),
                      ).animate().fadeIn().slideY(begin: 30,end: 0,delay: 800.ms,duration: 1100.ms, curve: Curves.easeInOut, ),
                      SizedBox(
                        height: 1.h,
                      ),
                      Animate(
                        child: Container(
                          margin: EdgeInsets.only(bottom: 3.h),
                          width: 85.w,
                          height: 7.h,
                          decoration: BoxDecoration(
                            color: bodySecond,
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
                          child:
                           Center(
                             child: DropdownButton(
                                         borderRadius: BorderRadius.circular(12),
                                         items: finance,
                                         alignment: Alignment.center,
                                         
                                         dropdownColor: bodyColor,
                                         value: selectedFinance == '' ? null : selectedFinance,
                                         onChanged: (value) {
                                           setState(() {
                                             selectedFinance = value.toString();
                                           });
                                         },
                                       ),
                           ),
                        ),
                      ).animate().fadeIn(duration: 400.ms).slideY(begin: 12,end: 0,delay: 800.ms,duration: 1100.ms, curve: Curves.easeInOut, ),
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
                               
                                    Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                             Home(0),
                                      ),
                                      (route) => false,
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
                                  'Finish',
                                  style: setFontStyle(
                                      12.sp, FontWeight.w600, Colors.white),
                                ),
                              ),
                            ),
                          ).animate().fadeIn(duration: 400.ms).slideY(begin: 12,end: 0,delay: 700.ms,duration: 1100.ms, curve: Curves.easeInOut, ),
                    ]),
                  ))
                ]))));
  }
  Widget createLanguage(){
    return Animate(
      child: Container(
        margin: EdgeInsets.only(bottom: 2.h),
                      
                        ),
    ).animate().fadeIn(duration: 400.ms).slideY(begin: 12,end: 0,duration: 1100.ms, curve: Curves.easeInOut, );
  }
}
