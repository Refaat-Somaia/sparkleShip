import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:sparkleship/global.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:http/http.dart' as http;

import 'wlcome.dart';

class Intro extends StatefulWidget {
  const Intro({super.key});

  @override
  State<Intro> createState() => _IntroFirst();
}

class _IntroFirst extends State<Intro>
{

@override
void initState(){
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [
  SystemUiOverlay.bottom
]);  
  super.initState();
  Timer(const Duration(milliseconds: 1000),() {
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
       
          backgroundColor: Colors.transparent,
          surfaceTintColor:  Colors.transparent,
          

          
          actions: <Widget>[
            SizedBox(width: 70.w,height: 5.h,),
            Center(
              child: Column(
                children: [
                  Icon(Icons.swipe_left,size: 12.w,color: bodyColor,),

               
        SizedBox(height: 2.h,),

                    Text("Swipe",style:setFontStyle(14.sp,FontWeight.w500,bodyColor),),

                ],
              ),
            ),
               
        SizedBox(height: 2.h,)
          ],
        ),
      ); 
   });

}

  



  List<String> images = [
    'assets/images/intro-1.png',
    'assets/images/intro-2.png',
    'assets/images/intro-3.png',
    'assets/images/intro-4.png'
  ];
  String btnText='Skip';
  List<String> messages = [
    'We gathered all the information and details about scholarships in one place for a simple and easy searching process!',
    'Chat with other students on groups and share your knowledge and experience with them',
    'Contact expert advisors to consulate them and get answers for your any questions you have',
    'Get detailed comparison between your acadamic profile and the requirements of the scholarships you want!'
  ];

  int index = 0;

  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      backgroundColor: bodyColor,
        body: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Stack(children: [
              PageView.builder(
                  itemCount: 4,
                  pageSnapping: true,
                  onPageChanged: (page) {
                    
                    setState(() {
                      index = page;
                      if(page==3) {
                        btnText='Next';
                      }
                    });
                  },
                  itemBuilder: (context, pagePosition) {
                    return Container(
                        margin: const EdgeInsets.all(10),
                        child: Padding(
                          padding: EdgeInsets.all(2.h),
                          child: Column(children: [
                            SizedBox(height: 12.h),
                            Animate(
                              child: Image.asset(
                                images[pagePosition],
                                height: 35.h,
                              ),
                            ).animate().slideY(duration: 700.ms,begin: 0.3,end: 0).fadeIn(duration: 500.ms),
                            SizedBox(
                              height: 4.h,
                            ),
                            Animate(
                              child: Text(
                                messages[pagePosition],
                                textAlign: TextAlign.center,
                                style: setFontStyle(
                                    12.sp, FontWeight.w500, secondColor),
                              ).animate(delay: 500.ms ).slideY(duration: 400.ms,begin: 0.2,end: 0,curve: Curves.easeInOut)
                              .fadeIn(duration: 200.ms,curve: Curves.easeInOut),
                            ),
                          ]),
                        ));
                  }),
              Positioned(
                top: 79.h,
               
                child: Row(
                  children: [
                    SizedBox(width: 10.w),
                    circle(index == 0 ? mainColor : const Color(0xFFD3E0EA),2.h),
                    SizedBox(width: 2.5.w),
                    circle(index == 1 ? mainColor : const Color(0xFFD3E0EA),2.h),
                    SizedBox(width: 2.5.w),
                    circle(index == 2 ? mainColor : const Color(0xFFD3E0EA),2.h),
                      SizedBox(width: 2.5.w),
                    circle(index == 3 ? mainColor : const Color(0xFFD3E0EA),2.h),
                    SizedBox(width: 27.w),
                    Container(
                      width: 30.w,
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
    //                     onPressed: () { Navigator.push(
    // context,
    // MaterialPageRoute(builder: (context) => const Welcome()),
    //               );},
    onPressed: (){

      Navigator.push(context, CupertinoPageRoute(builder:(context) => const Welcome()));
    },
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16)),
                            elevation: 0,
                            shadowColor: mainColor,
                            foregroundColor: mainColor,
                            backgroundColor: mainColor),
                        child: Text(
                          btnText
                          ,
                          style: setFontStyle(
                              11.sp, FontWeight.w600, Colors.white),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Animate(
                child: Positioned(
                  right: 0,
                  // top: 30,
                  child: Image(
                      image: const AssetImage(
                        'assets/images/corner-intro-top.png',
                      ),
                      height: 15.h),
                ),
              ).fadeIn(),
              Animate(
                child: Positioned(
                  left: 0,
                  bottom: 0,
                  // top: 30,
                  child: Image(
                      image: const AssetImage(
                        'assets/images/corner-intro-bottom.png',
                      ),
                      height: 15.h),
                ),
              ).fadeIn(),
            ])));
  }
// getProfile() async {
// print(getToken());
// var token = await getToken();
// http.post(
//       "$url",
//       headers: {
//         "Content-Type": "application/json",
//         'Authorization': 'Bearer $token',
//       },
//       encoding: Encoding.getByName("utf-8"),
//     ).then((response) {
//       print(datafromurl);
//       if (response.statusCode == 200) {
//          print(json.decode(response.body));
//       }
//     });
// }


  Future<http.Response> fetchAlbum() async {
  final response = await http.post(Uri.parse(registerUrl),headers: {
    'Content-Type':'application/json',
    'Authorization':"Bearer $token"
  },
  
  body: jsonEncode({
    'name':'Refat Somia',
    'email':'hb3t@gmail.com',
    'password':"password",
    'age': 21,
    "gender": "male",
    "nationality": "Jordanian",
    "status": "bachelor's student",
    "fieldOfStudy": "computer science",
    "hourseOfExperience": 1500,
    "languageLevelLetter": "C2"
  }),);
    print('${response.body}');
  if(response.statusCode ==200){
    print('${response.body}');
    
  }

return await http.post(Uri.parse(registerUrl),headers: {
    'Content-Type':'application/json',
    'Authorization':"Bearer $token"
  },
  
  body: jsonEncode({
    'name':'Refat Somia',
    'email':'hb2003t@gmail.com',
    'password':"password",
    'age': 21,
    "gender": "male",
    "nationality": "Jordanian",
    "status": "bachelor's student",
    "fieldOfStudy": "computer science",
    "hourseOfExperience": 1500,
    "languageLevelLetter": "C2"
  }),);

  


}

Future<void> postData() async {
  final url = Uri.parse(registerUrl); //Repclace Your Endpoint
  final headers = {'Content-Type': 'application/json',
                   'Authorization':"Bearer $token"};
  final body = jsonEncode({
    'name':'Refat Somia',
    'email':'hb2003t@gmail.com',
    'password':"password",
    'age': 21,
    "gender": "male",
    "nationality": "Jordanian",
    "status": "bachelor's student",
    "fieldOfStudy": "computer science",
    "hourseOfExperience": 1500,
    "languageLevelLetter": "C2"});

  final response = await http.post(url, headers: headers, body: body);

  if (response.statusCode == 200) {
    print('Data Sending Success.');
  } else {
    print('Hata: ${response.statusCode}');
  }
}
}
