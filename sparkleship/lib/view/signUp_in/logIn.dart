import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:sparkleship/view/home.dart';
import '../../global.dart';
import 'package:http/http.dart' as http;

import 'signUp.dart';

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogIn();
}

class _LogIn extends State<LogIn> {
  final _formField = GlobalKey<FormState>();

  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();

  var pass = "";

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        backgroundColor: bodyColor,
        body: SizedBox(
          width: double.infinity,
          height: double.infinity,
          
          child: Stack(
            children: [
              Positioned(
                right: 0,
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
                    height: 13.h),
              ),
              SingleChildScrollView(
                  child: SizedBox(
                width: double.infinity,
                child: Form(
                    key: _formField,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 20.h,
                          ),
                          Animate(
                            child: Image(
                              image:
                                  const AssetImage('assets/images/logIn.png'),
                              height: 30.h,
                            ),
                          ).animate().fadeIn(duration: 500.ms).slideY(
                                begin: -5,
                                end: 0,
                                delay: 100.ms,
                                duration: 1400.ms,
                                curve: Curves.easeInOut,
                              ),
                          SizedBox(height: 2.h),
                          Animate(
                            child: Text(
                              'Welcome back!',
                              style: setFontStyle(
                                  16.sp, FontWeight.w500, secondColor),
                            ),
                          )
                              .animate()
                              .fadeIn(
                                delay: 1200.ms,
                                duration: 1300.ms,
                                curve: Curves.easeInOut,
                              )
                              .slideY(
                                begin: 12,
                                end: 0,
                                delay: 600.ms,
                                duration: 1300.ms,
                                curve: Curves.easeInOut,
                              ),
                          SizedBox(height: 2.h),
                          createInput('Email', emailCtrl),
                          createInput('Password', passCtrl),
                          SizedBox(
                            height: 1.h,
                          ),
                          Animate(
                            child: Container(
                              width: 75.w,
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
                                  if (_formField.currentState!.validate()) {

                                    logInRequeset();
                                    
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(16)),
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
                          ).animate().fadeIn(duration: 400.ms).slideY(
                                begin: 12,
                                end: 0,
                                delay: 100.ms,
                                duration: 1100.ms,
                                curve: Curves.easeInOut,
                              ),
                          SizedBox(
                            height: 1.h,
                          ),
                          Animate(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Don't have an account?",
                                  style: setFontStyle(10.sp, FontWeight.w600,
                                      const Color.fromARGB(255, 149, 148, 148)),
                                ),
                                TextButton(
                                  child: Text(
                                    'Sign up',
                                    style: setFontStyle(
                                        10.sp, FontWeight.w600, mainColor),
                                  ),
                                  onPressed: () {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => const SignUp()),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ).animate().fadeIn(duration: 400.ms).slideY(
                                begin: 12,
                                end: 0,
                                delay: 100.ms,
                                duration: 1100.ms,
                                curve: Curves.easeInOut,
                              ),
                          Animate(
                            child: TextButton(
                              child: Text(
                                'Reset password',
                                style: setFontStyle(
                                    10.sp, FontWeight.w600, mainColor),
                              ),
                              onPressed: () {},
                            ),
                          ).animate().fadeIn(duration: 400.ms).slideY(
                                begin: 12,
                                end: 0,
                                delay: 100.ms,
                                duration: 1100.ms,
                                curve: Curves.easeInOut,
                              )
                        ])),
              )),
            ],
          ),
        ),
      ),
    );
  }

  Widget createInput(String text, final controller) {
    return Animate(
      child: Container(
          margin: EdgeInsets.only(bottom: 2.h),
          width: 90.w,
          height: 6.5.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: const Border(
              bottom: BorderSide(width: 4, color: mainColor),
            ),
          ),
          child: PhysicalModel(
            borderRadius: BorderRadius.circular(16),
            color: const Color(0xFFF6F6F6),
            elevation: 0,
            child: TextFormField(
              textAlign: TextAlign.start,
              obscureText: controller == passCtrl ? true : false,
              enableSuggestions: controller == passCtrl ? false : true,
              autocorrect: controller == passCtrl ? false : true,
              validator: (value) {
                if (controller == emailCtrl) {
                  bool emailValid = RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                      .hasMatch(value.toString());

                  if (value!.isEmpty) {
                    return "Please enter your email";
                  } else if (!emailValid) {
                    return "Please enter a valid email";
                  }
                  return null;
                } else if (controller == passCtrl) {
                  if (value!.isEmpty) {
                    return "Please enter your password";
                  } else if (passCtrl.text.length < 6) {
                    return "Passwords are greater than 6 characters";
                  }
                  return null;
                }
              },
              maxLength: 35,
              textAlignVertical: TextAlignVertical.center,
              style: setFontStyle(10.sp, FontWeight.w600, secondColor),
              controller: controller,
              decoration: InputDecoration(
                
                counterText: '',
                counterStyle: const TextStyle(fontSize: 0),
                labelText: text,
                errorStyle: setFontStyle(
                    9.sp, FontWeight.w600, const Color(0xFFF66B0E)),
                floatingLabelStyle:
                    setFontStyle(12.sp, FontWeight.bold, mainColor),
                labelStyle: setFontStyle(
                    9.sp, FontWeight.bold, const Color(0xFF9F9F9F)),
                filled: true,
                fillColor: const Color(0xFFF6F6F6),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(
                        color: Color.fromARGB(0, 234, 19, 19), width: 2)),
                border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(16)),
              ),
            ),
          )),
    ).animate().fadeIn(duration: 400.ms).slideY(
          begin: 12,
          end: 0,
          delay: 100.ms,
          duration: 1100.ms,
          curve: Curves.easeInOut,
        );
  }


Future<void> logInRequeset() async {
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

                    Text("Please wait...",style:setFontStyle(13.sp,FontWeight.w500,secondColor),),

                ],
              ),
            ),
               
        SizedBox(height: 3.h,)
          ],
        ),
      ); 

 

    final SharedPreferences prefs = await SharedPreferences.getInstance();
       String jsonOfTokken = '';
    final url = Uri.parse(loginUrl); //Repclace Your Endpoint
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': "Bearer $token"
    };
    final body = jsonEncode({
      'email': emailCtrl.text.trim(),
      'password': passCtrl.text.trim(),
    });

    final response = await http.post(url, headers: headers, body: body);

  

    if (response.statusCode == 200) {
      jsonOfTokken = response.body.toString();
      Map<String, dynamic> data = jsonDecode(jsonOfTokken);

      if (data.containsKey("token")) {
        userToken = data["token"];
       await  prefs.setString('userToken', data['token']);
       await  prefs.setString('userId', data['id']);
       await prefs.setString('userNationality',data['nationality']);
       await prefs.setString('userFirstName', data['name'].toString().split(" ")[0]);
        await prefs.setString('userLastName', data['name'].toString().split(" ")[1]);
        await prefs.setString('userEmail', emailCtrl.text);
        await prefs.setString('userPassword', passCtrl.text);
        await prefs.setString('userPhone', data["phoneNumber"]);
        await prefs.setString('userGender', data['gender']);

       if(data['age']!=null){
                                   await prefs.setString('userTypeOfDegree', data['degree']);
                                   await prefs.setString('userResidence', data['currentResidency']);
                                   await prefs.setString('nationality', data['nationality']);
                                   await prefs.setString('userFieldOfStudy', data["fieldOfStudy"]);
                                   await prefs.setString('userLevelOfEnglish',"levelOfEnglish");
                                    await prefs.setString('userHoursOfExperience',data["hoursOfWorkExperience"].toString());
                                   await prefs.setString('userHoursOfvolunteering', data["hoursOfVolunteeringExperience"].toString());
                                   await prefs.setString('userHighSchoolDeg', "0");
                                   await prefs.setString('usergpaController', data["gpa"]);
                                   await prefs.setString('userAge', data["age"].toString());
                                   await prefs.setString('userLangLevel',data['levelOfEnglish']);}



         Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => Home(0),
      ),
      (route) => false,
    );
      } else {
        showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          icon: Icon(Icons.error_outline,color: orangeColor,size: 12.w,),
          backgroundColor: bodyColor, 
          surfaceTintColor: bodyColor,
          
          
          title:  Text(data['msg'],style:setFontStyle(11.sp,FontWeight.w500,orangeColor),),
          
          actions: <Widget>[
            SizedBox(width: 90.w,),
           
               
        
            TextButton(
              onPressed: () => {Navigator.pop(context, 'OK'),Navigator.pop(context, 'OK')},
              child: Center(child: Text('OK',style: setFontStyle(10.sp, FontWeight.w600, mainColor),)),
            ),
          ],
        ),
      );
      }

   timeOut=false;
    
     } 
     }

  
}
