
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';





String serverIp='192.168.1.107';
String loginUrl='http://$serverIp:3000/api/auth/login';
String registerUrl='http://$serverIp:3000/api/auth/register';
String getScholarships='http://$serverIp:3000/api/scholarships';
String getScholarshipsHome='http://$serverIp:3000/api/scholarships?page=1&limit=5';
String userToken='';
String token="eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySUQiOiI2NWZmZjlkOTk3YWE5YTRhNjQyYzRiODIiLCJuYW1lIjoiYWhtYWQgYWxob21zaSIsImlhdCI6MTcxMTI4MzMzNCwiZXhwIjoxNzEzODc1MzM0fQ.eV8l7QA1eWGBVZbh4isuDPlAmbYd8ejfG_ePXp7YXbY";
String bgImage = 'assets/images/bg-white.png';



const bodyColor=Color.fromARGB(255, 255, 255, 255);
const bodySecond=Color.fromARGB(255, 246, 248, 252);
const offWhite =Color(0xFFF6F6F6);
const mainColor=Color(0xFF19A7CE);
const secondColor=Color(0xFF146C94);
const lightBlue=Color(0xFF8AD4E8);
const orangeColor=Color(0xFFF66B0E);


TextStyle setFontStyle(double size,FontWeight fontWeight,Color color){
  return TextStyle(fontFamily:'magnet',fontSize: size,fontWeight: fontWeight,color:color );
} 


//     lists used in pages 

List<DropdownMenuItem> typesOfDegree = [
    DropdownMenuItem(
        value: "bachelors",
        child: Text(
          "Bachelors",
          style: setFontStyle(10.sp, FontWeight.bold, secondColor),
        )),
    DropdownMenuItem(
        value: "masters",
        child: Text(
          "Masters",
          style: setFontStyle(10.sp, FontWeight.bold, secondColor),
        )),
    DropdownMenuItem(
        value: "phd",
        child: Text(
          "PHD",
          style: setFontStyle(10.sp, FontWeight.bold, secondColor),
        )),

  ];
 
 

  List<DropdownMenuItem> levelsOfLangs = [
    DropdownMenuItem(
        value: "A1",
        child: Text(
          "A1",
          style: setFontStyle(9.sp, FontWeight.bold, secondColor),
        )),
    DropdownMenuItem(
        value: "A2",
        child: Text(
          "A2",
          style: setFontStyle(9.sp, FontWeight.bold, secondColor),
        )),
    DropdownMenuItem(
        value: "B1",
        child: Text(
          "B1",
          style: setFontStyle(9.sp, FontWeight.bold, secondColor),
        )),
    DropdownMenuItem(
        value: "B2",
        child: Text(
          "B2",
          style: setFontStyle(9.sp, FontWeight.bold, secondColor),
        )),
    DropdownMenuItem(
        value: "C1",
        child: Text(
          "C1",
          style: setFontStyle(9.sp, FontWeight.bold, secondColor),
        )),
    DropdownMenuItem(
        value: "C2",
        child: Text(
          "C2",
          style: setFontStyle(9.sp, FontWeight.bold, secondColor),
        )),
  ];

  List<DropdownMenuItem> chatOptions = [
    DropdownMenuItem(

        value: "members",
        child: Row(
          children: [
            const Icon(Icons.group,color: secondColor,),
            Text(
              "Members",
              style: setFontStyle(9.sp, FontWeight.bold, secondColor),
            ),
          ],
        )),
    DropdownMenuItem(

        value: "wallpaper",
        child: Row(
          children: [
            const Icon(Icons.brush,color: secondColor,),
            Text(
              "Wallpaper",
              style: setFontStyle(9.sp, FontWeight.bold, secondColor),
            ),
          ],
        )),
          
      DropdownMenuItem(

        value: "clear",
        child: Row(
          children: [
            const Icon(Icons.delete_outline_outlined,color: secondColor,),
            Text(
              "Clear chat",
              style: setFontStyle(9.sp, FontWeight.bold, secondColor),
            ),
            
          ],
        )),
         DropdownMenuItem(

        value: "settings",
        child: Row(
          children: [
            const Icon(Icons.settings,color: secondColor,),
            Text(
              "Settings",
              style: setFontStyle(9.sp, FontWeight.bold, secondColor),
            ),
          ],
        )),
           DropdownMenuItem(

        value: "leave",
        child: Row(
          children: [
            const Icon(Icons.logout_outlined,color: orangeColor,),
            Text(
              "Leave group",
              style: setFontStyle(9.sp, FontWeight.bold, orangeColor),
            ),
            
          ],
        )),
  ];


  List<DropdownMenuItem> feildsOfStudy = [
    
    DropdownMenuItem(
        value: "Computer Science",
        child: Text(
          "Computer Science",
          style: setFontStyle(9.sp, FontWeight.bold, secondColor),
        )),
        DropdownMenuItem(
        value: "Medical",
        child: Text(
          "Medical",
          style: setFontStyle(9.sp, FontWeight.bold, secondColor),
        )),
        DropdownMenuItem(
        value: "Business",
        child: Text(
          "Business",
          style: setFontStyle(9.sp, FontWeight.bold, secondColor),
        )),
         DropdownMenuItem(
        value: "Arts",
        child: Text(
          "Arts",
          style: setFontStyle(9.sp, FontWeight.bold, secondColor),
        )),
         DropdownMenuItem(
        value: "Engineering",
        child: Text(
          "Engineering",
          style: setFontStyle(9.sp, FontWeight.bold, secondColor),
        )),
        DropdownMenuItem(
        value: "Languages",
        child: Text(
          "Languages",
          style: setFontStyle(9.sp, FontWeight.bold, secondColor),
        )),
        DropdownMenuItem(
        value: "Sciences",
        child: Text(
          "Sciences",
          style: setFontStyle(9.sp, FontWeight.bold, secondColor),
        )),
   
    
         
          
  ];

  
  List<DropdownMenuItem> finance = [
    DropdownMenuItem(
        value: "fully-funded",
        child: Text(
          "fully funded",
          style: setFontStyle(9.sp, FontWeight.bold, secondColor),
        )),
    DropdownMenuItem(
        value: "partially-funded",
        child: Text(
          "partially funded",
          style: setFontStyle(9.sp, FontWeight.bold, secondColor),
        )),


  ];
  


Widget circle(Color color,double radius){
  return Container(
      width: radius,
      height: radius,
      decoration:  BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
      );
}






