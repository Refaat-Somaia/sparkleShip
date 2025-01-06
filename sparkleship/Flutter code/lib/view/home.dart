import 'dart:async';
import 'dart:convert';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:sparkleship/additional/custom_icons_icons.dart';
import 'package:sparkleship/view/advisor/advisors.dart';
import 'package:sparkleship/view/student/account.dart';
import 'package:sparkleship/view/explore.dart';
import 'package:http/http.dart' as http;

import 'package:sparkleship/view/groups/groups.dart';
import 'package:sparkleship/view/scholarshipDetails.dart';
import '../additional/adds.dart';
import '../global.dart';
import 'groups/viewNewGroup.dart';

class Home extends StatefulWidget {
   Home(this.activePageIndex,{super.key});
  late int activePageIndex;
  @override
  State<Home> createState() => _Home(activePageIndex);
}

 


class _Home extends State<Home> {
  String userName = '';
  static int index=0;
  late int activePageIndex;
  _Home(this.activePageIndex);
  bool canPop=false;

  List<Widget> listOfPage=[const Home1(),const Explore(),const Groups(),const Advisors()];




  @override
  Widget build(BuildContext context) {
    return PopScope(
       canPop: canPop,
  onPopInvoked: (bool didPop) async {
    if (didPop) {
      return;
    }
       final NavigatorState navigator = Navigator.of(context);
    if(activePageIndex!=0){
      navigator.pushAndRemoveUntil(
     
      MaterialPageRoute(
        builder: (BuildContext context) =>Home(0),
      ),
      (route) => false,
    );
    }
    else{
      SystemNavigator.pop();
    }
   
  },
      child: GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        backgroundColor: bodyColor,

        bottomNavigationBar: Padding(
          padding: EdgeInsets.all(1.h),
          child: GNav(
            
              gap: 2.w,
              padding: EdgeInsets.all(2.5.w),
              backgroundColor: bodyColor,
              selectedIndex: activePageIndex,
              tabs: [
                GButton(
                  icon: Icons.house_rounded,
                  iconSize: 3.5.h,
                  text: "Home",
                        textStyle: setFontStyle(10.sp, FontWeight.w500, mainColor),
                  iconColor: secondColor,
                  textColor: bodyColor,
                  backgroundColor: bodySecond,
                  haptic: true,
                  iconActiveColor: mainColor,
                  
                   onPressed: (){
                    setState(() {
                      activePageIndex=0;
                    });
               
                  },
                ),
                GButton(
                  icon: Icons.search_rounded,
                  text: "Explore",
                  iconSize: 3.5.h,
                        textStyle: setFontStyle(10.sp, FontWeight.w500, mainColor),
                  iconColor: secondColor,
                  textColor: bodyColor,
                  backgroundColor: bodySecond,
                  haptic: true,
                  iconActiveColor: mainColor,
                  
                  
           
                  onPressed: (){
                    setState(() {
                      activePageIndex=1;
                    });
                  },
        
                 
                ),
                GButton(
                  icon: Icons.group,
                  text: "Groups",
                  iconSize: 3.5.h,
                          textStyle: setFontStyle(10.sp, FontWeight.w500, mainColor),
                  iconColor: secondColor,
                  textColor: bodyColor,
                  backgroundColor: bodySecond,
                  haptic: true,
                  iconActiveColor: mainColor,
                  
                  
                         onPressed: (){
                    setState(() {
                      activePageIndex=2;
                    });
                  },
        
             
                ),
                GButton(
                  icon: Icons.manage_accounts_sharp,
                  text: "Advisors",
                  iconSize: 3.5.h,
                  textStyle: setFontStyle(10.sp, FontWeight.w500, mainColor),
                  iconColor: secondColor,
                  textColor: bodyColor,
                  backgroundColor: bodySecond,
                  haptic: true,
                  iconActiveColor: mainColor,
                      onPressed: (){
                    setState(() {
                      activePageIndex=3;
                    });
                  },
                ),
              ],
              onTabChange: (index) {}),
              
  ),
  body: listOfPage[activePageIndex],
  ))
  );
  
  }
  void setIndex(int x){
    setState(() {
    index=x;
    });
  }
  }
  
  class Home1 extends StatefulWidget {
  const Home1({super.key});

  @override
  State<Home1> createState() => _Home1();
}

        class _Home1 extends State<Home1> {



           late  Adds adds;


             void initState() {
    super.initState();
           fetchScholarships();
           getName();
           getGroups();
           adds=Adds(context);





  }
  bool isAccountSet=false;


 getName()async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      
 userName=   prefs.getString('userFirstName').toString();
    });
    if(prefs.getString('userAge')!=null&&prefs.getString('userAge')!=''){
      setState(() {
        isAccountSet=true;
      });
    }
  
  }



  bool pageLoaded=false;
  String userName = '';
  int indexOfSlide=0;
  List<Widget> listOfScholarships=[];

   @override
  Widget build(BuildContext context) {
    // serverIp="192.168.218.145";
    return  GestureDetector(
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
                      height: 12.h),
                ),
                  
                // Positioned(
      
      
                SingleChildScrollView(
                  child:pageLoaded? Column(mainAxisAlignment: MainAxisAlignment.center,
                
                   children: [
                      
                    SizedBox(height: 4.h),
                  
                    Row(
                      children: [
                        SizedBox(
                          width: 5.w,
                        ),
                        SizedBox(
                          width: 65.w,
                          child: Text(
                            'Hello, $userName',
                            style:
                                setFontStyle(15.sp, FontWeight.w600, mainColor),
                          ),
                        ),
                        Container(
                          width: 12.w,
                          height: 12.w,
                          decoration: const BoxDecoration(
                            color: bodySecond,
                            shape: BoxShape.circle,
                          ),
                          child: Stack(
                            children: [
                              IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  CustomIcons.bell_1,
                                  color: mainColor,
                                  size: 3.5.h,
                                ),
                              ),
                              Positioned(child: circle(orangeColor, 1.5.h))
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 2.w,
                        ),
                        Container(
                          width: 12.w,
                          height: 12.w,
                          decoration: const BoxDecoration(
                            color: bodySecond,
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                            onPressed: () {
                            Navigator.push(context, CupertinoPageRoute(builder: 
                            (context)=> const Account()));
                            },
                            icon: Icon(
                              Icons.account_circle_rounded,
                              color: mainColor,
                              size: 4.h,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                      SizedBox(
                          
                       
                    width: double.infinity,
                    height: 18.h,
                    child: Swiper(
                        viewportFraction: 0.85,
        scale: 0.9,
        
          itemBuilder: (context, index) {
          
          
            return adds.slidersFilled(context)[index];
          },
          indicatorLayout: PageIndicatorLayout.COLOR,
          
          autoplay: true,
          autoplayDelay: 5000,
          itemCount: adds.slidersFilled(context).length,
        ),
        
                  ),
                  
                  
                    SizedBox(
                      height: 1.h,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 5.w),
                      child: SizedBox(
                        width: double.infinity,
                        height: 14.h,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  width: 72.w,
                                  child: Text(
                                    "Categories",
                                    style: setFontStyle(
                                        11.sp, FontWeight.w600, secondColor),
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                                TextButton(
                                    onPressed: () {
                                    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => Home(1),
        ),
        (route) => false,
      );
                                    
                            
                                    },
                                    child: Text(
                                      "Show all",
                                      style: setFontStyle(8.sp, FontWeight.w600,
                                          const Color(0xFF7DA5B7)),
                                      textAlign: TextAlign.end,
                                    )),
                              ],
                            ),
                            SizedBox(
                              height: 0.5.h,
                            ),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(children: [
                                createCategory(
                                    const Color(0xFFE9605A),
                                    'Computer\nscience',
                                    CustomIcons.noun_it_5208976,
                                    5.h),
                                createCategory(
                                    const Color(0xFFBC7CC7),
                                    'Medical',
                                    CustomIcons.noun_medicine_6077717,
                                    5.h),
                                createCategory(const Color(0xFF0EB29A),
                                    'Engineering', CustomIcons.group, 3.5.h),
                                createCategory(const Color(0xFFFE7A36), 'Arts',
                                    Icons.brush, 3.5.h),
                                createCategory(const Color(0xFF3C486B),
                                    'Business', Icons.attach_money, 3.5.h),
                              ]),
                            )
                          ],
                        ),
                      ),
                    ),
                  
                    Padding(
                      padding: EdgeInsets.only(left: 4.w),
                      child: SizedBox(
                        width: double.infinity,
                        height: 32.h,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  width: 72.w,
                                  child: Text(
                                    "Recommended for you",
                                    style: setFontStyle(
                                        11.sp, FontWeight.w600, secondColor),
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                                TextButton(
                                    onPressed: () {
                                      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => Home(1),
        ),
        (route) => false,
      );
                                    },
                                    child: Text(
                                      "Show all",
                                      style: setFontStyle(8.sp, FontWeight.w600,
                                          const Color(0xFF7DA5B7)),
                                      textAlign: TextAlign.end,
                                    )),
                              ],
                            ),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(children: [
                          
                                  for(int i=0;i<listOfScholarships.length;i++)
                              listOfScholarships[i],
                              // createScholarShip("Title", "department"),
                              // createScholarShip("Title", "department"),
                              // createScholarShip("Title", "department"),
      
                              ]),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 4.w),
                      child: SizedBox(
                        width: double.infinity,
                        height: 34.h,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  width: 72.w,
                                  child: Text(
                                    "Find groups",
                                    style: setFontStyle(
                                        11.sp, FontWeight.w600, secondColor),
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                                TextButton(
                                    onPressed: () {
                                      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => Home(2),
        ),
        (route) => false,
      );
                                    },
                                    child: Text(
                                      "Show all",
                                      style: setFontStyle(8.sp, FontWeight.w600,
                                          const Color(0xFF7DA5B7)),
                                      textAlign: TextAlign.end,
                                    )),
                              ],
                            ),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(children: 
                                listOfGroups
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    
               
                    Padding(
                      padding: EdgeInsets.only(left: 4.w),
                      child: SizedBox(
                        width: double.infinity,
                        height: 38.h,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  width: 72.w,
                                  child: Text(
                                    "Find advisors",
                                    style: setFontStyle(
                                        11.sp, FontWeight.w600, secondColor),
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                                TextButton(
                                    onPressed: () {
                                       Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => Home(3),
        ),
        (route) => false,
      );
                                    },
                                    child: Text(
                                      "Show all",
                                      style: setFontStyle(8.sp, FontWeight.w600,
                                          const Color(0xFF7DA5B7)),
                                      textAlign: TextAlign.end,
                                    )),
                              ],
                            ),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(children: [
                                createAdvisor('gfshsd', '4.5'),
                                createAdvisor('name', '4.5'),
                                createAdvisor('name', '4.5'),
                              ]),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ]):SizedBox(width: 100.w,height: 100.h,child: 
                      Center(
                        child: LoadingAnimationWidget.staggeredDotsWave(
                              color: mainColor,
                              size: 20.w,),
                      ),
                ),
                )
              ],
            ),
          )
        ),
    
      );
      
  }

  Widget createCategory(Color color, String title, IconData icon, double size) {
    return Container(
      decoration: BoxDecoration(
          color: bodySecond, borderRadius: BorderRadius.circular(12)),
      margin: EdgeInsets.only(right: 2.w),
      child: SizedBox(
        width: 34.w,
        height: 6.h,
        child: TextButton(
          onPressed: () {},
          child: Row(children: [
            Icon(
              icon,
              size: size,
              color: color,
            ),
            SizedBox(
              width: 1.w,
            ),
            Flexible(
                child: Text(
              title,
              softWrap: true,
              textAlign: TextAlign.center,
              style: setFontStyle(7.5.sp, FontWeight.w600, color),
            ))
          ]),
        ),
      ),
    );
  }

  Widget createScholarShip(String title,String department,int index) {
    return Container(
      margin: EdgeInsets.only(right: 3.w),
      width: 55.w,
      height: 26.h,
      decoration: BoxDecoration(
        color: bodySecond,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Container(
            height: 11.h,
              decoration:  const BoxDecoration(
                
                image: DecorationImage(image: AssetImage('assets/images/scholarship.png'),fit: BoxFit.cover),
                  color: mainColor,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(12),topRight:Radius.circular(12)), ),
          ),
          SizedBox(
            height: 5.5.h,
            child: Center(
              child:
                  Text(
                title,
                style: setFontStyle(10.sp, FontWeight.normal,
                    const Color.fromARGB(255, 51, 113, 142)),
                    textAlign: TextAlign.center,
              ),
            ),
          ),
          SizedBox(
            height: 2.3.h,
            child: Text(
              department,
              style:
                  setFontStyle(9.sp, FontWeight.normal, const Color(0xFF6A9EB5)),
            ),
          ),
          TextButton(
            onPressed: () {
             
              Navigator.push(context, MaterialPageRoute(builder:  (context) =>  ScholarshipDetails(scholarshipsList.elementAt(index))));
            },
            child: Text(
              'Show details',
              style: setFontStyle(9.sp, FontWeight.w600, secondColor),
            ),
          )
        ],
      ),
    );
  }

 AssetImage  imageOfGroup(String name)  {return 
      AssetImage(name=="Canada"? 'assets/images/canada.png':(name=="Computer science")?
                     "assets/images/computer science.png": (name=="Medical")?"assets/images/medical.png" 
                     :(name=="News")?"assets/images/news.png": "assets/images/europe.png");}


      Widget createGroup(String name,String depatrment,String count,String description,int id){
        return  Container(
            margin: EdgeInsets.symmetric(horizontal: 1.w),
                    width: 40.w,
                    height: 25.h,
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
                            depatrment,style: setFontStyle(9.sp, FontWeight.w400, const Color(0xFF6A9EB5)),textAlign: TextAlign.center,
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

  Widget createAdvisor(String name, String rate,) {
    

    return Container(
      margin: EdgeInsets.only(right: 3.w),
      width: 40.w,
      height: 23.h,
      decoration: BoxDecoration(
        color: bodySecond,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          SizedBox(height: 2.h,),
          Container(
              width: 11.h,
              height: 8.h,
              decoration: const BoxDecoration(
                  shape: BoxShape.circle),
                  child: Image.asset('assets/images/user.png',fit: BoxFit.contain,),),
          SizedBox(
            height: 6.h,
            child: Center(
             
                  child: Text(
                name,
                style: setFontStyle(10.sp, FontWeight.normal,
                    const Color.fromARGB(255, 51, 113, 142)),textAlign: TextAlign.center,
              ),
            ),
          ),
          SizedBox(
            height: 3.h,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  rate,
                  style: setFontStyle(
                      10.sp, FontWeight.normal, const Color(0xFF6A9EB5)),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 0.5.h),
                  child: const Icon(
                    Icons.star_rate_rounded,
                    color: Color(0xFFF36F56),
                  ),
                )
              ],
            ),
          ),
         
       
        ],
      ),
    );


  }
   List<dynamic> scholarshipsList=[];
   
Future<void> fetchScholarships() async {
final SharedPreferences prefs = await SharedPreferences.getInstance();
setState(() {
  scholarshipsList.clear();
  listOfScholarships.clear();
  
});
    bool timeOut=true;
    Timer(const Duration(seconds: 20), () {timeOut? showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          icon: Icon(Icons.signal_wifi_statusbar_connected_no_internet_4_rounded,color: orangeColor,size: 12.w,),
          backgroundColor: bodyColor,
          surfaceTintColor: bodyColor,
          
          
          title:  Text("Connection error",style:setFontStyle(10.sp,FontWeight.w500,orangeColor),),
          
          actions: <Widget>[
            SizedBox(width: 90.w,),
           
               
        
            TextButton(
              onPressed: () => {Navigator.pop(context, 'OK'),fetchScholarships()},
              child: Center(child: Text('Retry',style: setFontStyle(11.sp, FontWeight.w600, mainColor),)),
            ),
          ],
        ),
      ):{}; });


      String? token= prefs.getString('userToken');
      print('token : $token');

    var url;
        final headers = {
      'Content-Type': 'application/json',
      'Authorization': "Bearer $token"
    };
    if(prefs.getString('userFieldOfStudy')!=''){
      url=Uri.parse("http://$serverIp:3000/api/scholarships?fieldOfStudy=${prefs.getString('userFieldOfStudy')}");
      final response = await http.get(url, headers: headers);
      print(scholarshipsList = jsonDecode(response.body)['scholarships']);
    }
    if(scholarshipsList.isEmpty) {
      url = Uri.parse(getScholarshipsHome);
    } else {
      url=Uri.parse("http://$serverIp:3000/api/scholarships?fieldOfStudy=${prefs.getString('userFieldOfStudy')}");
    }

      // url=Uri.parse("http://192.168.1.107:8000");
    


    final response = await http.get(url, headers: headers);
    // final response = await http.get(url,);

    if (response.statusCode == 200) {
      print('requset sent successfully');

        scholarshipsList = jsonDecode(response.body)['scholarships'];

        Map<String, dynamic> scholarship;

      for(int i=0;i<scholarshipsList.length;i++){
        setState(() {
        scholarship=scholarshipsList.elementAt(i);
         listOfScholarships.add(createScholarShip(scholarship["title"]!=null?scholarship["title"]: "title",
          scholarship['fieldOfStudy']!=null?scholarship['fieldOfStudy']: "Multiple",i));
        });
      }

       timeOut=false;
       setState(() {
       pageLoaded=true;
       });
    } 


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
              listOfGroups.add(createGroup(group["name"] ?? "name"
         , group['fieldOfStudy'] ?? "Field of study",
         group['memberCount'] ?? "0",
         group['description'] ?? "description",2));
            }
      });
      }
      
      
    }
      }


}
