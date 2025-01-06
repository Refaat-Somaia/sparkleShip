

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sparkleship/global.dart';

import 'package:sizer/sizer.dart';
import 'package:sparkleship/screens/wlcome.dart';
import 'package:sparkleship/view/student/studentInfo.dart';

import '../home.dart';

class Account extends StatefulWidget {
  const Account({super.key});

  @override
  State<Account> createState() => _Account();
}

class _Account extends State<Account> {

  void initState() {
    super.initState();
    fillInfo();

  }


  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();
  final fnameCtrl = TextEditingController();
  final lnameCtrl = TextEditingController();
  final genderCtrl = TextEditingController();

  final confirmPassCtrl = TextEditingController();
  final numCtrl = TextEditingController();
  bool enableEdit = false;
  bool pageLoaded=false;

  // File? _imgFile;

  //     void takeSnapshot() async {
  //       final ImagePicker picker = ImagePicker();
  //       final XFile? img = await picker.pickImage(
  //         source: ImageSource.gallery, // alternatively, use ImageSource.gallery
  //         maxWidth: 400,
  //       );
  //       if (img == null) return;
  //       setState(() {
  //         _imgFile = File(img.path); // convert it to a Dart:io file
  //       });}

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
              GestureDetector(
                onTap: () {
                  FocusManager.instance.primaryFocus?.unfocus();
                },
                child: SingleChildScrollView(
                  child: SizedBox(
                    width: double.infinity,
                    child: pageLoaded? Column(
                      children: [
                        SizedBox(
                          height: 7.h,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 5.w,
                            ),
                            IconButton(
                                onPressed: () {

                                  Navigator.pop(context);
                                  setState(() {
                                    
                                  });
                                },
                                icon: Icon(
                                  Icons.arrow_back_ios_new,
                                  color: secondColor,
                                  size: 8.w,
                                )),
                            SizedBox(
                              width: 13.w,
                            ),
                            SizedBox(
                              width: 60.w,
                              child: Text(
                                'My account',
                                style: setFontStyle(
                                    16.sp, FontWeight.w600, secondColor),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        createInput("First name", fnameCtrl),
                        createInput("Last name", lnameCtrl),
                        createInput("Email", emailCtrl),
                        createInput("Update password", passCtrl),
                        createInput("Phone number", numCtrl),
                        createInput("Gender", genderCtrl),
                        SizedBox(
                          height: 2.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    setState(() => enableEdit = true);
                                  },
                                  icon: Icon(Icons.edit_outlined,
                                      color: const Color(0xFF0EB29A),
                                      size: 10.w),
                                  style: IconButton.styleFrom(
                                      backgroundColor: bodySecond),
                                ),
                                SizedBox(
                                  height: 0.5.h,
                                ),
                                Text("Edit",
                                    style: setFontStyle(9.sp, FontWeight.w500,
                                        const Color(0xFF0EB29A)))
                              ],
                            ),
                            SizedBox(
                              width: 9.w,
                            ),
                            Column(
                              children: [
                                IconButton(
                                  onPressed: () {

                                    if (enableEdit) {
                                      confirmPassCtrl.text='';
                                      bool emaiValid = RegExp(
                                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                          .hasMatch(emailCtrl.text);
                                      bool passValid = true;
                                      if (passCtrl.text.length > 1) {
                                        passValid = passCtrl.text.length > 5;
                                      }
                                      bool nameValid =
                                          fnameCtrl.text.length > 2 &&
                                              lnameCtrl.text.length > 2;

                                      showDialog<String>(
                                        context: context,
                                        builder: (BuildContext context) =>
                                            AlertDialog(
                                          backgroundColor: bodyColor,
                                          surfaceTintColor: bodyColor,
                                          actions: <Widget>[
                                            SizedBox(
                                              width: 95.w,
                                              height: 5.h,
                                            ),
                                            Center(
                                              child: Column(
                                                children: [
                                                  Icon(
                                                    (!nameValid ||
                                                            !emaiValid ||
                                                            !passValid)
                                                        ? Icons.error
                                                        : Icons.lock,
                                                    color: (!nameValid ||
                                                            !emaiValid ||
                                                            !passValid)
                                                        ? orangeColor
                                                        : mainColor,
                                                    size: 10.w,
                                                  ),
                                                  Text(
                                                    (!emaiValid)
                                                        ? 'Enter a valid email'
                                                        : (!passValid)
                                                            ? 'Password should be more than 6 characters'
                                                            : (!nameValid)
                                                                ? 'Enter your full name'
                                                                : "Enter your password to confirm",
                                                    style: setFontStyle(
                                                        11.sp,
                                                        FontWeight.w500,
                                                        (!nameValid ||
                                                                !emaiValid ||
                                                                !passValid)
                                                            ? orangeColor
                                                            : mainColor),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                  SizedBox(
                                                    height: 1.h,
                                                  ),
                                                  if (nameValid &&
                                                      emaiValid &&
                                                      passValid)
                                                    createInput(
                                                        "", confirmPassCtrl)
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: 2.h,
                                            ),
                                            TextButton(
                                              onPressed: () async {
                                                final SharedPreferences prefs =
                                                    await SharedPreferences
                                                        .getInstance();
                                            

                                                if (confirmPassCtrl.text ==
                                                    prefs
                                                        .getString(
                                                            'userPassword')
                                                        .toString()) {
                                                  await prefs.setString(
                                                      'userFirstName',
                                                      fnameCtrl.text);
                                                  await prefs.setString(
                                                      'userLastName',
                                                      lnameCtrl.text);
                                                  await prefs.setString(
                                                      'userEmail',
                                                      emailCtrl.text);
                                                      passCtrl.text.length>1?
                                                  await prefs.setString(
                                                      'userPassword',
                                                      passCtrl.text):{};
                                                  await prefs.setString(
                                                      'userPhone',
                                                      numCtrl.text);
                                                  fillInfo();
                                                  Navigator.pop(context, 'OK');
                                              



                                                  showDialog<String>(
                                                    context: context,
                                                    builder: (BuildContext
                                                            context) =>
                                                        AlertDialog(
                                                      backgroundColor:
                                                          bodyColor,
                                                      surfaceTintColor:
                                                          bodyColor,
                                                      title: Text(
                                                        '',
                                                        style: setFontStyle(
                                                            11.sp,
                                                            FontWeight.w500,
                                                            orangeColor),
                                                      ),
                                                      actions: <Widget>[
                                                        SizedBox(
                                                          width: 90.w,
                                                        ),
                                                        Image.asset('assets/images/success.png',height: 40.h,),
                                                        Text(
                                                          'Your account was updated succefully!',
                                                          style: setFontStyle(
                                                              10.sp,
                                                              FontWeight.w600,
                                                              secondColor),
                                                          textAlign:
                                                              TextAlign.center,
                                                        ),
                                                        TextButton(
                                                          onPressed: () =>
                                                              Navigator.pop(
                                                                  context,
                                                                  'OK'),
                                                          child: Center(
                                                              child: Text(
                                                            'OK',
                                                            style: setFontStyle(
                                                                10.sp,
                                                                FontWeight.w600,
                                                                mainColor),
                                                          )),
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                } else {
                                                  showDialog<String>(
                                                    context: context,
                                                    builder: (BuildContext
                                                            context) =>
                                                        AlertDialog(
                                                      icon: Icon(
                                                        Icons.error,
                                                        color: orangeColor,
                                                        size: 12.w,
                                                      ),
                                                      backgroundColor:
                                                          bodyColor,
                                                      surfaceTintColor:
                                                          bodyColor,
                                                      title: Text(
                                                        'Incorrect password',
                                                        style: setFontStyle(
                                                            11.sp,
                                                            FontWeight.w500,
                                                            orangeColor),
                                                      ),
                                                      actions: <Widget>[
                                                        SizedBox(
                                                          width: 90.w,
                                                        ),
                                                        TextButton(
                                                          onPressed: () =>
                                                              Navigator.pop(
                                                                  context,
                                                                  'OK'),
                                                          child: Center(
                                                              child: Text(
                                                            'OK',
                                                            style: setFontStyle(
                                                                10.sp,
                                                                FontWeight.w600,
                                                                mainColor),
                                                          )),
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                }
                                              },
                                              child: Center(
                                                  child: Text(
                                                (nameValid &&
                                                        emaiValid &&
                                                        passValid)
                                                    ? 'Confirm'
                                                    : 'ok',
                                                style: setFontStyle(10.sp,
                                                    FontWeight.w600, mainColor),
                                              )),
                                            ),
                                          ],
                                        ),
                                      );
                                    }
                                  },
                                  icon: Icon(Icons.save,
                                      color:
                                          (enableEdit) ? mainColor : lightBlue,
                                      size: 10.w),
                                  style: IconButton.styleFrom(
                                      backgroundColor: bodySecond),
                                ),
                                SizedBox(
                                  height: 0.5.h,
                                ),
                                Text(
                                  'Save',
                                  style: setFontStyle(9.sp, FontWeight.w500,
                                      (enableEdit) ? mainColor : lightBlue),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 9.w,
                            ),
                            Column(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                StudentInfo1("Edit my file")));
                                  },
                                  icon: Icon(Icons.file_copy,
                                      color: mainColor, size: 10.w),
                                  style: IconButton.styleFrom(
                                      backgroundColor: bodySecond),
                                ),
                                SizedBox(
                                  height: 0.5.h,
                                ),
                                Text("My file",
                                    style: setFontStyle(
                                        9.sp, FontWeight.w500, mainColor))
                              ],
                            ),
                            SizedBox(
                              width: 9.w,
                            ),
                            Column(
                              children: [
                                IconButton(
                                  onPressed: () async {
                                    final SharedPreferences prefs =
                                        await SharedPreferences.getInstance();

                                    await prefs.setString('userFirstName', '');
                                    await prefs.setString('userLastName', '');
                                    await prefs.setString('userEmail', '');
                                    await prefs.setString('userPassword', '');
                                    await prefs.setString('userPhone', '');
                                    await prefs.setString('userGender', '');
                                    await prefs.setString('userNationality', '');
                                   await prefs.setString('userResidence', '');
                                   await prefs.setString('userTypeOfDegree', '');
                                   await prefs.setString('userFieldOfStudy', '');
                                   await prefs.setString('userLevelOfEnglish', '');
                                   await prefs.setString('userHoursOfExperience', '');
                                   await prefs.setString('userHoursOfvolunteering', '');
                                   await prefs.setString('userHighSchoolDeg', '');
                                   await prefs.setString('usergpaController', '');
                                   await prefs.setString('userCollegeDeg', '');
                                   await prefs.setString('userAge', '');
                                   await prefs.setString('userLangLevel','');

                                    Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            const Welcome(),
                                      ),
                                      (route) => false,
                                    );
                                  },
                                  icon: Icon(Icons.logout,
                                      color: orangeColor, size: 10.w),
                                  style: IconButton.styleFrom(
                                      backgroundColor: bodySecond),
                                ),
                                SizedBox(
                                  height: 0.5.h,
                                ),
                                Text("Log out",
                                    style: setFontStyle(
                                        9.sp, FontWeight.w500, orangeColor))
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 3.h,
                        ),
                      ],
                    ):SizedBox(
                      height: 100.h,
                      child: Center(child:  LoadingAnimationWidget.staggeredDotsWave(
                            color: mainColor,
                            size: 25.w,
                          ),),
                    ),
                  ),
                ),
              ),
            ])));
  }

  Widget createInput(String text, final controller) {
    return Animate(
      child: Container(
          margin: EdgeInsets.only(
              bottom: (controller != confirmPassCtrl) ? 2.7.h : 0),
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
              enabled: (controller == genderCtrl) ? false : enableEdit,
              textAlign: TextAlign.start,
              obscureText:
                  controller == passCtrl || controller == confirmPassCtrl
                      ? true
                      : false,
              enableSuggestions:
                  controller == passCtrl || controller == confirmPassCtrl
                      ? false
                      : true,
              autocorrect:
                  controller == passCtrl || controller == confirmPassCtrl
                      ? false
                      : true,
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
                    return "Passwords are than 6 characters";
                  }
                  return null;
                }
              },
              maxLength: 40,
              textAlignVertical: TextAlignVertical.center,
              style: setFontStyle(10.sp, FontWeight.w600,
                  (!enableEdit) ? lightBlue : secondColor),
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
    );
  }

  fillInfo() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      emailCtrl.text = prefs.getString('userEmail').toString();
      fnameCtrl.text = prefs.getString('userFirstName').toString();
      lnameCtrl.text = prefs.getString('userLastName').toString();
      numCtrl.text = prefs.getString('userPhone').toString();
      genderCtrl.text = prefs.getString('userGender').toString();
      pageLoaded=true;
    });
  }
}
