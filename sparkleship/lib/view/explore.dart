import 'dart:async';
import 'dart:convert';
import 'dart:ui';
import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:http/http.dart' as http;
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sparkleship/additional/custom_icons_icons.dart';
import 'package:sparkleship/global.dart';
import 'package:sizer/sizer.dart';
import 'scholarshipDetails.dart';

class Explore extends StatefulWidget {
  const Explore({super.key});

  @override
  State<Explore> createState() => _Explore();
}

class _Explore extends State<Explore> with SingleTickerProviderStateMixin {
  late AnimationController controller;
  bool addComma = false;
  bool lockRequest=false;
  bool pageLoaded = false;
  bool allowScroll=false;
  List<Widget> listOfScholarships = [];
  List<bool> activeBorder=[false,false,false,false,false,false];
  final searchField = TextEditingController();
  final ScrollController scrollController = ScrollController();
  
 
// to open and close pop ups
  bool languageFilterOn = false;
  bool showSelectLang = false;
  bool showEnterGpa=false;
  bool showSelectDegree=false;
  bool showCountry=false;
 

  final gpaController=TextEditingController();

  String selectedLang = '';
  double scale = 1;
  String countrySelected = '';
  String typeOfdegree = '';
  String fieldOfStudyFilter= '';
  String selectedFinanceFilter='';



  @override
  void initState() {
    fetchScholarships();
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();

          showCountry = false;
        },
        child: Scaffold(
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

            // Positioned(
            //   left: 0,
            //   bottom: 0,
            //   // top: 30,
            //   child: Image(
            //       image: const AssetImage(
            //         'assets/images/corner-bottom.png',
            //       ),
            //       height: 13.h),
            // ),

            SingleChildScrollView(
              controller: scrollController,
                child: Center(
              child: pageLoaded
                  ? Column(
                      children: [
                        SizedBox(
                          height: 8.h,
                        ),
                        Text(
                          'Explore',
                          style:
                              setFontStyle(16.sp, FontWeight.w600, secondColor),
                        ),
                        SizedBox(
                          height: 3.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 85.w,
                              height: 6.5.h,
                              decoration: const BoxDecoration(
                                color: bodySecond,
                                borderRadius: BorderRadius.only(topLeft: Radius.circular(12),bottomLeft: Radius.circular(12)),
                              ),
                              child: PhysicalModel(
                                borderRadius: BorderRadius.circular(16),
                                color: bodySecond,
                                elevation: 0,
                                child: TextFormField(
                                  controller: searchField,
                                  textAlign: TextAlign.start,
                                  maxLength: 40,
                                  textAlignVertical: TextAlignVertical.center,
                                  style: setFontStyle(
                                      10.sp, FontWeight.w600, secondColor),
                                      
                                  decoration: InputDecoration(
                                    counterText: '',
                                    counterStyle: const TextStyle(fontSize: 0),
                                    labelText: 'Search..',
                                    labelStyle: setFontStyle(
                                        9.sp, FontWeight.w500, secondColor),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(16),
                                        borderSide: const BorderSide(
                                            color: Color.fromARGB(0, 234, 19, 19),
                                            width: 2)),
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius: BorderRadius.circular(16)),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                                   width: 10.w,
                              height: 6.5.h,
                               decoration: const BoxDecoration(
                                color: bodySecond,
                                borderRadius: BorderRadius.only(topRight: Radius.circular(12),bottomRight:Radius.circular(12) ),),
                              child: IconButton(onPressed: (){
                                fetchScholarships();

   
                                FocusManager.instance.primaryFocus?.unfocus();}, icon: const Icon(Icons.search,color: mainColor,)))
                          ],
                        ),
                        SizedBox(
                          height: 3.h,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 5.w),
                          child: Row(
                            children: [
                              createCategory(
                                  const Color(0xFFFFEEEE),
                                  const Color(0xFFFE7062),
                                  'Computer science scholarships',
                                  CustomIcons.noun_it_5208976,
                                  12.w,0),
                              SizedBox(
                                width: 4.w,
                              ),
                              createCategory(
                                  const Color(0xFFFDF1FF),
                                  const Color(0xFFBC7CC7),
                                  'Medical scholarships',
                                  CustomIcons.noun_medicine_6077717,
                                  13.w,1),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 5.w),
                          child: Row(
                            children: [
                              createCategory(
                                  const Color(0xFFF1F4FB),
                                  const Color(0xFF3C486B),
                                  'Business scholarships',
                                  Icons.attach_money,
                                  10.w,2),
                              SizedBox(
                                width: 4.w,
                              ),
                              createCategory(
                                  const Color(0xFFFFEFE7),
                                  const Color(0xFFFE7A36),
                                  'Arts scholarships',
                                  Icons.brush,
                                  10.w,3),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 5.w),
                          child: Row(
                            children: [
                              createCategory(
                                  const Color(0xFFEEFFFD),
                                  const Color(0xFF0EB29A),
                                  'Engineering scholarships',
                                  CustomIcons.group,
                                  9.w,4),
                              SizedBox(
                                width: 4.w,
                              ),
                              createCategory(
                                  const Color(0xFFEFFAFF),
                                  const Color(0xFF146C94),
                                  'Langauges scholarships',
                                  Icons.language,
                                  10.w,5),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 3.h,
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
                                      width: 62.w,
                                      child: Text(
                                        "Filters",
                                        style: setFontStyle(12.sp,
                                            FontWeight.w600, secondColor),
                                        textAlign: TextAlign.start,
                                      ),
                                    ),
                                    TextButton(
                                        onPressed: () {
                                          setState(() {
                                            fetchScholarships();
                                          });
                                        },
                                        child: Text(
                                          "Apply",
                                          style: setFontStyle(
                                              8.sp, FontWeight.w600, mainColor),
                                          textAlign: TextAlign.end,
                                        )),
                                    TextButton(
                                        onPressed: () {
                                          setState(() {
                                            selectedLang = '';
                                            gpaController.text = '';
                                            countrySelected = '';
                                            typeOfdegree = '';
                                            selectedFinanceFilter = '';
                                            fieldOfStudyFilter = '';
                                             for(int i=0;i<activeBorder.length;i++){
            activeBorder[i]=false;
          }
                                          });
                                        },
                                        child: Text(
                                          "Clear",
                                          style: setFontStyle(8.sp,
                                              FontWeight.w600, orangeColor),
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
                                    createFilter(
                                        TextButton(
                                          onPressed: () {
                                            setState(() {
                                         showDialog(
  context: context,
  builder: (context) {
    return StatefulBuilder(
      builder: (context, setState) {
        return
                                                        AlertDialog(
                                                  icon: Icon(
                                                    Icons.flag_rounded,
                                                    color: secondColor,
                                                    size: 10.w,
                                                  ),
                                                  backgroundColor: bodyColor,
                                                  surfaceTintColor: bodyColor,
                                                  title: Text(
                                                    'Select a conutry',
                                                    style: setFontStyle(
                                                        15.sp,
                                                        FontWeight.w500,
                                                        secondColor),
                                                  ),
                                                  actions: <Widget>[
                                                    SizedBox(
                                                      width: 90.w,
                                                    ),
                                                    Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadiusDirectional
                                                                .circular(12),
                                                      ),
                                                      child: Center(
                                                        child: SizedBox(
                                                          width: 60.w,
                                                          child: Center(
                                                            child: SizedBox(
                                                              width: 80.w,
                                                              child:
                                                                  ElevatedButton(
                                                                onPressed: () {
                                                                  showCountryPicker(
                                                                    context:
                                                                        context,
                                                                    showPhoneCode:
                                                                        false, // optional. Shows phone code before the country name.
                                                                    onSelect:
                                                                        (Country
                                                                            country) {
                                                                      setState(
                                                                          () {
                                                                        countrySelected =
                                                                            country.name;
                                                                      });
                                                                    },
                                                                  );
                                                                },
                                                                style: ElevatedButton.styleFrom(
                                                                    elevation:
                                                                        0,
                                                                    shadowColor:
                                                                        mainColor,
                                                                    foregroundColor:
                                                                        bodySecond,
                                                                    backgroundColor:
                                                                        bodySecond),
                                                                child: Text(
                                                                  countrySelected,
                                                                  style: const TextStyle(
                                                                      color:
                                                                          secondColor),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    TextButton(
                                                      onPressed: () =>
                                                      {setFilter(),
                                                          Navigator.pop(
                                                              context, 'OK')},
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
                                                );
    });  });
                                            });
                                          },
                                          child: Row(children: [
                                            Icon(
                                              Icons.flag_rounded,
                                              size: 8.w,
                                              color: secondColor,
                                            ),
                                            SizedBox(
                                              width: 1.w,
                                            ),
                                            Text(
                                              "Country",
                                              softWrap: true,
                                              textAlign: TextAlign.center,
                                              style: setFontStyle(7.5.sp,
                                                  FontWeight.w600, secondColor),
                                            )
                                          ]),
                                        ),
                                        (countrySelected != '')),
                                    createFilter(
                                        TextButton(
                                          onPressed: () {
                                                                        showDialog(
  context: context,
  builder: (context) {
    return StatefulBuilder(
      builder: (context, setState) {
        return
                                                  AlertDialog(
                                                icon: Icon(
                                                  Icons.language,
                                                  color: secondColor,
                                                  size: 10.w,
                                                ),
                                                backgroundColor: bodyColor,
                                                surfaceTintColor: bodyColor,
                                                title: Text(
                                                  'Select a language level',
                                                  style: setFontStyle(
                                                      15.sp,
                                                      FontWeight.w500,
                                                      secondColor),
                                                ),
                                                actions: <Widget>[
                                                  SizedBox(
                                                    width: 90.w,
                                                  ),
                                                  Center(
                                                    child: SizedBox(
                                                        width: 60.w,
                                                        child: Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadiusDirectional
                                                                    .circular(
                                                                        12),
                                                            color: bodySecond,
                                                          ),
                                                          child: DropdownButton(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        12),
                                                            items:
                                                                levelsOfLangs,
                                                            alignment: Alignment
                                                                .center,
                                                            dropdownColor:
                                                                bodyColor,
                                                            value: selectedLang ==
                                                                    ''
                                                                ? null
                                                                : selectedLang,
                                                            onChanged: (value) {
                                                              
                                                              print(value
                                                                  .toString());

                                                              setState(() {
                                                                selectedLang = value
                                                                    .toString();
                                                              });
                                                            },
                                                          ),
                                                        )),
                                                  ),
                                                  TextButton(
                                                  onPressed: () =>
                                                      {setFilter(),
                                                          Navigator.pop(
                                                              context, 'OK')},
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
                                              );
   });} );
                                          },
                                          child: Row(children: [
                                            Icon(
                                              Icons.language,
                                              size: 8.w,
                                              color: secondColor,
                                            ),
                                            SizedBox(
                                              width: 1.w,
                                            ),
                                            Text(
                                              "Language\n level",
                                              softWrap: true,
                                              textAlign: TextAlign.center,
                                              style: setFontStyle(7.5.sp,
                                                  FontWeight.w600, secondColor),
                                            )
                                          ]),
                                        ),
                                        (selectedLang != '')),
                                    createFilter(
                                        TextButton(
                                          onPressed: () {
                                            setState(() {
                                                                          showDialog(
  context: context,
  builder: (context) {
    return StatefulBuilder(
      builder: (context, setState) {
        return
                                                        AlertDialog(
                                                  icon: Icon(
                                                    Icons.star_rate_rounded,
                                                    color: secondColor,
                                                    size: 10.w,
                                                  ),
                                                  backgroundColor: bodyColor,
                                                  surfaceTintColor: bodyColor,
                                                  title: Text(
                                                    'Enter a GPA',
                                                    style: setFontStyle(
                                                        15.sp,
                                                        FontWeight.w500,
                                                        secondColor),
                                                  ),
                                                  actions: <Widget>[
                                                    Center(
                                                        child: Text(
                                                      '(Scale of 4)',
                                                      style: setFontStyle(
                                                          9.sp,
                                                          FontWeight.w500,
                                                          secondColor),
                                                    )),
                                                    SizedBox(
                                                      width: 90.w,
                                                    ),
                                                    Center(
                                                      child: Container(
                                                        width: 60.w,
                                                        decoration: BoxDecoration(
                                                            color: bodySecond,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        12)),
                                                        child: TextField(
                                                          maxLength: 4,
                                                          style: setFontStyle(
                                                              12.sp,
                                                              FontWeight.w500,
                                                              secondColor),
                                                          controller:
                                                              gpaController,
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
                                                          keyboardType:
                                                              TextInputType
                                                                  .number,
                                                          decoration:
                                                              const InputDecoration(
                                                            counterText: '',
                                                            counterStyle:
                                                                TextStyle(
                                                                    fontSize:
                                                                        0),
                                                            fillColor:
                                                                lightBlue,
                                                            focusedBorder:
                                                                InputBorder
                                                                    .none,
                                                            enabledBorder:
                                                                InputBorder
                                                                    .none,
                                                            errorBorder:
                                                                InputBorder
                                                                    .none,
                                                            disabledBorder:
                                                                InputBorder
                                                                    .none,
                                                          ),
                                                          textAlign:
                                                              TextAlign.center,
                                                        ),
                                                      ),
                                                    ),
                                                    TextButton(
                                                     onPressed: () =>
                                                      {setFilter(),
                                                          Navigator.pop(
                                                              context, 'OK')},
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
                                                );
    });}  );
                                            });
                                          },
                                          child: Row(children: [
                                            Icon(
                                              Icons.star_rate_rounded,
                                              size: 8.w,
                                              color: secondColor,
                                            ),
                                            SizedBox(
                                              width: 1.w,
                                            ),
                                            Text(
                                              "GPA",
                                              softWrap: true,
                                              textAlign: TextAlign.center,
                                              style: setFontStyle(7.5.sp,
                                                  FontWeight.w600, secondColor),
                                            )
                                          ]),
                                        ),
                                        (gpaController.text != '')),
                                    createFilter(
                                        TextButton(
                                          onPressed: () {
                                                                           showDialog(
  context: context,
  builder: (context) {
    return StatefulBuilder(
      builder: (context, setState) {
        return
                                                  AlertDialog(
                                                icon: Icon(
                                                  CustomIcons
                                                      .noun_study_3140051,
                                                  color: secondColor,
                                                  size: 10.w,
                                                ),
                                                backgroundColor: bodyColor,
                                                surfaceTintColor: bodyColor,
                                                title: Text(
                                                  'Select a department',
                                                  style: setFontStyle(
                                                      15.sp,
                                                      FontWeight.w500,
                                                      secondColor),
                                                ),
                                                actions: <Widget>[
                                                  SizedBox(
                                                    width: 90.w,
                                                  ),
                                                  Center(
                                                    child: SizedBox(
                                                        width: 60.w,
                                                        child: Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadiusDirectional
                                                                    .circular(
                                                                        12),
                                                            color: bodySecond,
                                                          ),
                                                          child: DropdownButton(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        12),
                                                            items:
                                                                feildsOfStudy,
                                                            alignment: Alignment
                                                                .center,
                                                            dropdownColor:
                                                                bodyColor,
                                                            value: fieldOfStudyFilter ==
                                                                    ''
                                                                ? null
                                                                : fieldOfStudyFilter,
                                                            onChanged: (value) {
                                                              setState(() {
                                                                fieldOfStudyFilter =
                                                                    value
                                                                        .toString();
                                                              });
                                                            },
                                                          ),
                                                        )),
                                                  ),
                                                  TextButton(
                                                   onPressed: () =>
                                                      {setFilter(),
                                                          Navigator.pop(
                                                              context, 'OK')},
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
                                              );
    });}  );
                                          },
                                          child: Row(children: [
                                            Icon(
                                              CustomIcons.noun_study_3140051,
                                              size: 9.w,
                                              color: secondColor,
                                            ),
                                            SizedBox(
                                              width: 1.w,
                                            ),
                                            Text(
                                              "Field of \nstudy",
                                              softWrap: true,
                                              textAlign: TextAlign.center,
                                              style: setFontStyle(7.5.sp,
                                                  FontWeight.w600, secondColor),
                                            )
                                          ]),
                                        ),
                                        (fieldOfStudyFilter != '')),
                                    createFilter(
                                        TextButton(
                                          onPressed: () {
                                                                           showDialog(
  context: context,
  builder: (context) {
    return StatefulBuilder(
      builder: (context, setState) {
        return
                                                  AlertDialog(
                                                icon: Icon(
                                                  Icons.monetization_on,
                                                  color: secondColor,
                                                  size: 10.w,
                                                ),
                                                backgroundColor: bodyColor,
                                                surfaceTintColor: bodyColor,
                                                title: Text(
                                                  'Select the type of finance',
                                                  style: setFontStyle(
                                                      15.sp,
                                                      FontWeight.w500,
                                                      secondColor),
                                                ),
                                                actions: <Widget>[
                                                  SizedBox(
                                                    width: 90.w,
                                                  ),
                                                  Center(
                                                    child: SizedBox(
                                                        width: 60.w,
                                                        child: Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadiusDirectional
                                                                    .circular(
                                                                        12),
                                                            color: bodySecond,
                                                          ),
                                                          child: DropdownButton(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        12),
                                                            items: finance,
                                                            alignment: Alignment
                                                                .center,
                                                            dropdownColor:
                                                                bodyColor,
                                                            value: selectedFinanceFilter ==
                                                                    ''
                                                                ? null
                                                                : selectedFinanceFilter,
                                                            onChanged: (value) {
                                                              setState(() {
                                                                selectedFinanceFilter =
                                                                    value
                                                                        .toString();
                                                              });
                                                            },
                                                          ),
                                                        )),
                                                  ),
                                                  TextButton(
                                                  onPressed: () =>
                                                      {setFilter(),
                                                          Navigator.pop(
                                                              context, 'OK')},
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
                                              );
     });}   );
                                          },
                                          child: Row(children: [
                                            Icon(
                                              Icons.monetization_on,
                                              size: 9.w,
                                              color: secondColor,
                                            ),
                                            SizedBox(
                                              width: 1.w,
                                            ),
                                            Text(
                                              "Finance",
                                              softWrap: true,
                                              textAlign: TextAlign.center,
                                              style: setFontStyle(7.5.sp,
                                                  FontWeight.w600, secondColor),
                                            )
                                          ]),
                                        ),
                                        (selectedFinanceFilter != '')),
                                    createFilter(
                                        TextButton(
                                          onPressed: () {
                                            setState(() {
                                                                        showDialog(
  context: context,
  builder: (context) {
    return StatefulBuilder(
      builder: (context, setState) {
        return
                                                        AlertDialog(
                                                  icon: Icon(
                                                    CustomIcons.noun_certificate_1018813_1,
                                                    color: secondColor,
                                                    size: 10.w,
                                                  ),
                                                  backgroundColor: bodyColor,
                                                  surfaceTintColor: bodyColor,
                                                  title: Text(
                                                    'Select a Degree',
                                                    style: setFontStyle(
                                                        15.sp,
                                                        FontWeight.w500,
                                                        secondColor),
                                                  ),
                                                  actions: <Widget>[
                                                    SizedBox(
                                                      width: 90.w,
                                                    ),
                                                    Center(
                                                      child: Container(
                                                        width: 60.w,
                                                        decoration: BoxDecoration(
                                                            color: bodySecond,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        12)),
                                                        child: Center(
                                                          child: DropdownButton(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        12),
                                                            items:
                                                                typesOfDegree,
                                                            alignment: Alignment
                                                                .center,
                                                            dropdownColor:
                                                                bodyColor,
                                                            value: typeOfdegree ==
                                                                    ''
                                                                ? null
                                                                : typeOfdegree,
                                                            onChanged: (value) {
                                                              setState(() {
                                                                typeOfdegree = value
                                                                    .toString();
                                                              });
                                                            },
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    TextButton(
                                                     onPressed: () =>
                                                      {setFilter(),
                                                          Navigator.pop(
                                                              context, 'OK')},
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
                                                );
       });}     );
                                            });
                                          },
                                          child: Row(children: [
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(top: 0.5.h),
                                              child: Icon(
                                                CustomIcons
                                                    .noun_certificate_1018813_1,
                                                size: 10.w,
                                                color: secondColor,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 1.w,
                                            ),
                                            Text(
                                              "Degree",
                                              softWrap: true,
                                              textAlign: TextAlign.center,
                                              style: setFontStyle(7.5.sp,
                                                  FontWeight.w600, secondColor),
                                            )
                                          ]),
                                        ),
                                        (typeOfdegree != '')),
                                  ]),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
   
           
                        for (int i = 0; i < listOfScholarships.length; i++)
                          listOfScholarships[i],
                      ],
                    )
                  : SizedBox(
                      width: 100.w,
                      height: 100.h,
                      child: Center(
                        child: LoadingAnimationWidget.staggeredDotsWave(
                          color: mainColor,
                          size: 20.w,
                        ),
                      ),
                    ),
            )),
          ]),
        ));
  }

  Widget createCategory(
      Color color, Color color1, name, IconData icon, double size,int index) {
    return Container(
      width: 43.w,
      height: 14.h,
      decoration: BoxDecoration(
        color: color,
        border:activeBorder[index]? Border.all(color: color1,width: 2):null,
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextButton(
        
        onPressed: () {
       
        setState(() {
          
          fieldOfStudyFilter=feildsOfStudy[index].value;
          for(int i=0;i<activeBorder.length;i++){
            activeBorder[i]=false;
          }
          activeBorder[index]=true;
          
        });
        fetchScholarships();
       
        },
        
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: color1,
              size: size,
            ),
            SizedBox(
              height: 5.h,
              width: 35.w,
              child: Text(
                name,
                style: setFontStyle(8.sp, FontWeight.w500, color1),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void setFilter(){
    setState((){

    });
  }

  Widget createFilter(Widget btn, bool activeBorder) {
    return Container(
      decoration: BoxDecoration(
          color: bodySecond,
          borderRadius: BorderRadius.circular(12),
          border:
              (activeBorder) ? Border.all(color: mainColor, width: 2) : null),
      margin: EdgeInsets.only(right: 2.w),
      child: SizedBox(width: 33.w, height: 6.h, child: btn),
    );
  }

  Widget createScholarShip(
    title,
    department,
 
    int index
  ) {


    
    return Container(
        width: 90.w,
        margin: EdgeInsets.only(bottom: 2.h),
        height: 20.h,
        decoration: BoxDecoration(
          color: bodySecond,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            SizedBox(width: 5.w,),
            Container(
              width: 25.w,
              height: 12.h,
              decoration: BoxDecoration(
                  image: const DecorationImage(
                      image: AssetImage('assets/images/scholarship.png'),
                      fit: BoxFit.cover),
                  color: mainColor,
                  borderRadius: BorderRadius.circular(12)),
            ),
            SizedBox(width: 2.w,),

            SizedBox(
              width: 50.w,
              child: Column(children: [
                SizedBox(
                  height: 4.h,
                ),
                SizedBox(
                  height: 7.h,
                  child: Text(
                    title,
                    overflow: TextOverflow.ellipsis,
                    style: setFontStyle(10.sp, FontWeight.w400, secondColor),
                    textAlign: TextAlign.center,
                  ),
                ),
                Text(
                  department,
                  style: setFontStyle(10.sp, FontWeight.w400,
                      const Color.fromARGB(255, 145, 193, 213)),
                  textAlign: TextAlign.center,
                ),
                TextButton(
                  onPressed: () async{

                    
                      Navigator.push(context, MaterialPageRoute(builder:  (context) =>  ScholarshipDetails(scholarships.elementAt(index))));
                  },
                  child: Text(
                    'View details',
                    style: setFontStyle(10.sp, FontWeight.w500, secondColor),
                    textAlign: TextAlign.center,
                  ),
                )
              ]),
            ),
            // SizedBox(
            //   width: 9.w,
            //   height: 15.h,
            //   child: Stack(
            //     children: [
            //       Positioned(
            //           top: 10.h,
            //           left: 0,
            //           child: circle(
            //             (p <= 100 && p >= 80)
            //                 ? Colors.green
            //                 : (p <= 79 && p >= 70)
            //                     ? const Color(0xFFF6CC59)
            //                     : orangeColor,
            //             9.w,
            //           )),
            //       Positioned(
            //           top: 11.h,
            //           left: 1.w,
            //           child: Container(
            //               width: 8.w,
            //               child: Text(
            //                 percentage + '%',
            //                 style:
            //                     setFontStyle(8.sp, FontWeight.w400, bodyColor),
            //               )))
            //     ],
            //   ),
            // ),
          ],
        ));
  }

  List<dynamic> scholarships = [];
  Future<void> fetchScholarships() async {

    if(!lockRequest)
{
  setState(() {
    
            lockRequest=true;
  });


    final SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      scholarships.clear();
      listOfScholarships.clear();
    });

    bool timeOut = true;
    Timer(const Duration(seconds: 20), () {
      timeOut
          ? showDialog<String>(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                icon: Icon(
                  Icons.signal_wifi_statusbar_connected_no_internet_4_rounded,
                  color: orangeColor,
                  size: 12.w,
                ),
                backgroundColor: bodyColor,
                surfaceTintColor: bodyColor,
                title: Text(
                  "Connection error",
                  style: setFontStyle(11.sp, FontWeight.w500, orangeColor),
                ),
                actions: <Widget>[
                  SizedBox(
                    width: 90.w,
                  ),
                  TextButton(
                    onPressed: () =>
                        {Navigator.pop(context, 'OK'), fetchScholarships()},
                    child: Center(
                        child: Text(
                      'Retry',
                      style: setFontStyle(10.sp, FontWeight.w600, mainColor),
                    )),
                  ),
                ],
              ),
            ) 
          : {};
             setState(() {
    
            lockRequest=false;
  });

    });
    String? token = await prefs.getString('userToken');

    String gpa = '';
    if (gpaController.text != '') {
      gpa = (gpaController.text);
    }

    String search = searchField.text;
    final url = Uri.parse(
        "http://$serverIp:3000/api/scholarships?title=$search&country=$countrySelected&fieldOfStudy=$fieldOfStudyFilter&requiredDegree=$typeOfdegree&gpa=$gpa&languageLevelLetter=$selectedLang&funding=$selectedFinanceFilter&fields=&sort=");
// final url =Uri.parse("http://192.168.1.107:8000");
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': "Bearer $token"
    };

    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {

      scholarships = jsonDecode(response.body)['scholarships'];
      Map<String, dynamic> scholarship;

      for (int i = 0; i < scholarships.length; i++) {
        setState(() {
          scholarship = scholarships.elementAt(i);

          listOfScholarships.add(createScholarShip(scholarship["title"],
              (scholarship['fieldOfStudy'] != null) ? scholarship['fieldOfStudy'] : 'Multiple',i));
        });
      }
      timeOut = false;
      setState(() {
        pageLoaded = true;
      });
       setState(() {
    
            lockRequest=false;
  });

  if(allowScroll){
          scrollController.animateTo(
        duration: 800.ms,
        curve: Curves.easeInOut,
        scrollController.position.pixels + 80.h);
        
  }
  allowScroll=true;
  

    }
  }}



 
 
}
