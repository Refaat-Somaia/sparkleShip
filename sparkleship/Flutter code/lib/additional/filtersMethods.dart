import 'package:language_picker/language_picker.dart';
import 'package:language_picker/languages.dart';
import 'package:sizer/sizer.dart'; 
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:sparkleship/global.dart';

 
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


  




 