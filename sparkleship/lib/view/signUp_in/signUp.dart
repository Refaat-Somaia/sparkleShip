import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:sparkleship/view/signUp_in/logIn.dart';
import 'package:toggle_switch/toggle_switch.dart';
import '../../screens/askToInfo.dart';
import 'package:http/http.dart' as http;

import '../../global.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formField = GlobalKey<FormState>();
  final fnameCtrl = TextEditingController();
  final lnameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();
  final confirmPassCtrl = TextEditingController();
  final numCtrl = TextEditingController();
  var pass = "";

  bool isMale = true;
  bool isFemale = false;

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
                            height: 8.h,
                          ),
                          Animate(
                            child: Text('Create new account',
                                style: setFontStyle(
                                    16.sp, FontWeight.w600, secondColor)),
                          ).animate().fadeIn(duration: 500.ms).slideY(
                                begin: 1.h,
                                end: 0,
                                delay: 800.ms,
                                duration: 1000.ms,
                                curve: Curves.easeInOut,
                              ),
                          SizedBox(
                            height: 4.h,
                          ),
                          createInput('First name', fnameCtrl),
                          createInput('Last name', lnameCtrl),
                          createInput('Email', emailCtrl),
                          createInput('Password', passCtrl),
                          createInput('Confirm password', confirmPassCtrl),
                          createInput('Phone number', numCtrl),
                          Animate(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                border: const Border(
                                  bottom:
                                      BorderSide(width: 4, color: mainColor),
                                ),
                              ),
                              child: ToggleSwitch(
                                minWidth: 44.w,
                                minHeight: 6.h,
                                cornerRadius: 2.h,
                                initialLabelIndex: 0,
                                inactiveBgColor: const Color(0xFFF6F6F6),
                                inactiveFgColor: secondColor,
                                totalSwitches: 2,
                                labels: const ['Male', 'Female'],
                                customTextStyles: [
                                  setFontStyle(
                                      10.sp, FontWeight.w600, secondColor)
                                ],
                                activeBgColors: const [
                                  [lightBlue],
                                  [lightBlue]
                                ],
                                animationDuration: 200,
                                animate: true,
                                onToggle: (index) {
                                  if (index == 0) {
                                    isMale = true;
                                    isFemale = false;
                                  } else {
                                    isMale = false;
                                    isFemale = true;
                                  }
                                },
                              ),
                            ),
                          ).animate().fadeIn(duration: 400.ms).slideY(
                                begin: 12,
                                end: 0,
                                delay: 800.ms,
                                duration: 1100.ms,
                                curve: Curves.easeInOut,
                              ),
                          SizedBox(
                            height: 3.h,
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
                                    signUpRequeset();
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
                                  'Next',
                                  style: setFontStyle(
                                      12.sp, FontWeight.w600, Colors.white),
                                ),
                              ),
                            ),
                          ).animate().fadeIn(duration: 400.ms).slideY(
                                begin: 12,
                                end: 0,
                                delay: 800.ms,
                                duration: 1100.ms,
                                curve: Curves.easeInOut,
                              ),
                          SizedBox(
                            height: 0.5.h,
                          ),
                          Animate(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Already have an account?',
                                  style: setFontStyle(10.sp, FontWeight.w600,
                                      const Color.fromARGB(255, 149, 148, 148)),
                                ),
                                TextButton(
                                  child: Text(
                                    'Log in',
                                    style: setFontStyle(
                                        10.sp, FontWeight.w600, mainColor),
                                  ),
                                  onPressed: () {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => const LogIn()),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ).animate().fadeIn(duration: 400.ms).slideY(
                                begin: 12,
                                end: 0,
                                delay: 800.ms,
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
          margin: EdgeInsets.only(bottom: 2.5.h),
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
              obscureText:
                  (controller == passCtrl || controller == confirmPassCtrl)
                      ? true
                      : false,
              enableSuggestions:
         false,
              autocorrect:
               false,
              keyboardType: controller == numCtrl
                  ? TextInputType.number
                  : TextInputType.emailAddress,
              validator: (value) {
                if (controller == emailCtrl) {
                  bool emailValid = RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                      .hasMatch(value.toString());

                  if (value!.isEmpty) {
                    return "Please Enter your Email";
                  } else if (!emailValid) {
                    return "Please enter a valid email";
                  }
                  return null;
                } else if (controller == passCtrl) {
                  if (value!.isEmpty) {
                    return "Create password";
                  } else if (passCtrl.text.length < 6) {
                    return "Password must be more than 6 characters";
                  }
                  return null;
                } else if (controller == confirmPassCtrl) {
                  if (value != passCtrl.text) {
                    return "Passwords don't match";
                  }
                  return null;
                } else if (controller == numCtrl) {
                  bool phoneValid =
                      RegExp(r"^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$")
                          .hasMatch(value.toString());

                  if (value!.isEmpty) {
                    return "Please enter your phone number";
                  } else if (!phoneValid) {
                    return "Please enter a valid number";
                  }
                  return null;
                } else if (controller == fnameCtrl) {
                  if (fnameCtrl.text == '')
                    return "Please enter your first name";
                } else if (controller == lnameCtrl) {
                  if (lnameCtrl.text == '')
                    return "Please enter your last name";
                }
              },
              maxLength: 40,
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
                        color: Color.fromARGB(0, 255, 0, 0), width: 2)),
                border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(16)),
              ),
            ),
          )),
    ).animate().fadeIn(duration: 400.ms).slideY(
          begin: 12,
          end: 0,
          delay: 800.ms,
          duration: 1100.ms,
          curve: Curves.easeInOut,
        );
  }

  Future<void> signUpRequeset() async {
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
    print('fadsfsfds');
    String jsonOfToken = '';
    final url = Uri.parse(registerUrl); 
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': "Bearer $token"
    };
    final body = jsonEncode({
      'name': '${fnameCtrl.text.trim()} ${lnameCtrl.text.trim()}',
      'email': emailCtrl.text.trim(),
      'password': passCtrl.text.trim(),
      "gender": isMale ? 'male' : 'female',
      'phoneNumber': numCtrl.text.trim(),
    });

    final response = await http.post(url, headers: headers, body: body);
    print(response.body);


    
    if (response.statusCode==201) {
      jsonOfToken = response.body.toString();
    // if (true) {

      Map<String, dynamic> data = jsonDecode(jsonOfToken);

      if (data.containsKey("token")) {
        userToken=data["token"];
      // if (true) {
        await prefs.setString('userId', data['id']);
        await prefs.setString('userToken', data['token']);
        await prefs.setString('userFirstName', fnameCtrl.text);
        await prefs.setString('userLastName', lnameCtrl.text);
        await prefs.setString('userEmail', emailCtrl.text);
        await prefs.setString('userPassword', passCtrl.text);
        await prefs.setString('userPhone', numCtrl.text);
        await prefs.setString('userGender', isMale?'male':'female');
      timeOut=false;
      emailCtrl.clear();
      passCtrl.clear();
      confirmPassCtrl.clear();
      fnameCtrl.clear();
      lnameCtrl.clear();
      numCtrl.clear();
Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) =>const AskToInfo(),
      ),
      (route) => false,
    );
      
        
    } 
    }
  }
}
