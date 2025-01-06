
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sparkleship/global.dart';
import 'package:http/http.dart' as http;

import 'package:sizer/sizer.dart';
import 'package:sparkleship/view/groups/viewGroup.dart';
import 'package:sparkleship/view/groups/viewNewGroup.dart';


class Groups extends StatefulWidget {
  const Groups({super.key});

  @override
  State<Groups> createState() => _Groups();
}

class _Groups extends State<Groups> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserGroups();
    getGroups();
  }

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
     
        SingleChildScrollView(
          
              child: Column(
            children: [
              SizedBox(
                height: 8.h,
              ),
              Text(
                'Groups',
                style: setFontStyle(16.sp, FontWeight.w600, secondColor),
              ),
              SizedBox(
                height: 3.h,
              ),
                 Padding(
                padding: EdgeInsets.only(left: 5.w),
                child:
               Row(
                        children: [
                          SizedBox(
                            width: 72.w,
                            child: Text(
                              "My groups",
                              style: setFontStyle(
                                  12.sp, FontWeight.w600, secondColor),
                              textAlign: TextAlign.start,
                            ),
                          ),]),),
                           SizedBox(
                height: 1.h,
              ),
          
                       
                 SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                
                child: Row(
                  children: [
                  for(int i=0;i<userGroups.length;i++)
              userGroups[i],
                 
                    
                  ],
                 ),
               ),
                    SizedBox(
                height: 7.h,
              ),
                 Container(
                width: 90.w,
                height: 6.5.h,
                decoration: BoxDecoration(
                  color: bodySecond,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: PhysicalModel(
                  borderRadius: BorderRadius.circular(16),
                  color: bodySecond,
                  elevation: 0,
                  child: TextFormField(
                    textAlign: TextAlign.start,
                    maxLength: 28,
                    textAlignVertical: TextAlignVertical.center,
                    style: setFontStyle(10.sp, FontWeight.w600, secondColor),
                    decoration: InputDecoration(
                      counterText: '',
                      counterStyle: const TextStyle(fontSize: 0),
                      labelText: 'Search..',
                      labelStyle:
                          setFontStyle(9.sp, FontWeight.w500, secondColor),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: const BorderSide(
                              color: Color.fromARGB(0, 234, 19, 19), width: 2)),
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(16)),
                    ),
                  ),
                ),
              ),
             
              ]),
              
              
        ),
                      
           
             Padding(
               padding:  EdgeInsets.only(top: 60.h,left: 3.w,right: 3.w),
               child:
                     listOfGroups.isEmpty?

                      Center(
                        child: SizedBox(
                          width: 20.w,
                          child: LoadingAnimationWidget.staggeredDotsWave(
                                color: mainColor,
                                size: 20.w,),
                        ),):
                       GridView(
                gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount:listOfGroups.isEmpty? 1:2
               ,mainAxisSpacing: 2.w,crossAxisSpacing: 2.w),
               children: [
              // createGroup('name','dep'),
              
        

              for(int i=0;i<listOfGroups.length;i++)
              listOfGroups[i],


              

             
               ],),
             ),
             Padding(
               padding:  EdgeInsets.only(top: 45.h,left: 5.w,right: 5.w),
               child: Container(
                width: 100.w,
                height: 0.2.h,
                color: const Color(0xFFD3E0EA),
               ),),
           
            
            
      ])
      );
      }
      List<Widget> userGroups=[];
      getUserGroups()async{

   final SharedPreferences prefs =
                                        await SharedPreferences.getInstance();
 


                                        for(int i=0;i<5;i++){
                                          print(prefs.getString('userGroups,$i'));
                                      if(prefs.getString('userGroups,$i')!=null&&prefs.getString('userGroups,$i')!=""){
                                          setState(() {
                                            userGroups.add(createGroupUser(prefs.getString('userGroups,$i').toString(),
                                             prefs.getString("userGroups,$i,field").toString(),
                                              prefs.getString("userGroups,$i,memberCount").toString()));
                                          });

                                        }
      }
      }

      AssetImage  imageOfGroup(String name)  {return 
      AssetImage(name=="Canada"? 'assets/images/canada.png':(name=="Computer science")?
                     "assets/images/computer science.png": (name=="Medical")?"assets/images/medical.png" 
                     :(name=="News")?"assets/images/news.png": "assets/images/europe.png");}
      Widget createGroupUser(String name,String depatrment,String memberCount){
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 1.w),
                  width: 35.w,
                  height: 22.h,
                 decoration: BoxDecoration(borderRadius: BorderRadius.circular(12),
                 
                 color: bodySecond),
                 child: TextButton(
                  onPressed: (){
                    Navigator.push(context,CupertinoPageRoute(builder: (context)=>ViewGroup(name,imageOfGroup(name))));
                  },
                   child: Column(
                    children: [
                      SizedBox(height:1.h),
                      Container(height: 8.h,width: 8.h,decoration:  BoxDecoration(
                        image: DecorationImage(image:imageOfGroup(name)),
                        shape: BoxShape.circle
                      ),
                      
                      ),
                   
                      SizedBox(
                        width: 35.w,
                        height: 5.5.h,
                        child: Center(
                          child: Text(
                            name,style: setFontStyle(10.sp, FontWeight.w500, secondColor),textAlign: TextAlign.center,),
                        )),
                   
                      SizedBox(
                        width: 30.w,
                        height: 3.h,
                        child: Center(
                          child: Text(
                            depatrment,style: setFontStyle(9.sp, FontWeight.w400, const Color(0xFF6A9EB5)),textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,),
                        )),
                        Row(mainAxisAlignment: MainAxisAlignment.center,
                                 children: [
                                 Text(memberCount,style:setFontStyle(10.sp, FontWeight.w400, secondColor)),
                                 SizedBox(width: 0.5.w,)
                                 ,const Icon(Icons.supervisor_account,color: secondColor,)
                        ],)
                    ],
                   ),
                 ),
                );
      }


      Widget createGroupNew(String name,String depatrment,String count,String description,int id){
        return  Container(
            margin: EdgeInsets.symmetric(horizontal: 1.w),
                    width: 35.w,
                    height: 22.h,
                   decoration: BoxDecoration(borderRadius: BorderRadius.circular(12),
                   
                   color: bodySecond),
                   child: TextButton(
                    onPressed: (){
                    Navigator.push(context,CupertinoPageRoute(builder:
                     (context)=>ViewNewGroup(name,imageOfGroup(name),int.parse(count),depatrment,description,id)));
                    },
                     child: Column(
                      children: [
                        SizedBox(height:1.h),
                        Container(height: 8.h,width: 8.h,decoration:  BoxDecoration(
                          image: DecorationImage(image: imageOfGroup(name)),
                          shape: BoxShape.circle
                        ),
                        
                        ),
                     
                        SizedBox(
                          width: 35.w,
                          height: 5.5.h,
                          child: Center(
                            child: Text(
                              name,style: setFontStyle(10.sp, FontWeight.w500, secondColor),),
                          )),
                     
                        SizedBox(
                          width: 30.w,
                          height: 3.h,
                          child: Center(
                            child: Text(
                              depatrment,style: setFontStyle(9.sp, FontWeight.w400, const Color(0xFF6A9EB5)),
                              overflow: TextOverflow.ellipsis,),
                          )),
                          Row(mainAxisAlignment: MainAxisAlignment.center,
                                   children: [
                                   Text(count.toString(),style:setFontStyle(10.sp, FontWeight.w400, secondColor)),
                                   SizedBox(width: 0.5.w,)
                                   ,const Icon(Icons.supervisor_account,color: secondColor,)
                          ],)
                      ],
                     ),
                   ),
                  
        );
      }






      List<Widget> listOfGroups=[];

      void getGroups()async{
final SharedPreferences prefs = await SharedPreferences.getInstance();

        setState(() {
  listOfGroups.clear();
  
});

final url=Uri.parse('http://$serverIp:3000/api/groups');
      String? token= await prefs.getString('userToken');

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': "Bearer $token"
    };

    final response=await http.get(url,headers: headers);
    if(response.statusCode==200){
      List<dynamic> groupsList=[];
      groupsList = jsonDecode(response.body)["groups"];

            Map<String, dynamic> group;
            
        bool isJoined=false;

      for(int i=0;i<groupsList.length;i++){
        isJoined=false;
        group=groupsList.elementAt(i);

                 for(int j=0;j<5;j++){
            if(prefs.getString("userGroups,$j").toString()==group['name'].toString()) {
              isJoined=true;
            }}
        setState(() {

          if(!isJoined){
              listOfGroups.add(createGroupNew(group["name"] !=null?group["name"]: "name"
         , group['fieldOfStudy'] ?? "Field of study",
         group['memberCount'] ?? "0",
         group['description'] ?? "description",2));
            }
      });
      }
      
      
    }
      }
      }


      