import 'dart:async';
import 'dart:io';

import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sparkleship/additional/custom_icons_icons.dart';
import 'package:sparkleship/global.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:sizer/sizer.dart';
import 'package:sparkleship/view/home.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../../model/Message.dart';

class ViewGroup extends StatefulWidget {
  final String groupName;
  late AssetImage img;

  ViewGroup(this.groupName,this.img, {super.key});

  @override
  State<ViewGroup> createState() => _ViewGroup(groupName,img);
}

class _ViewGroup extends State<ViewGroup> {
  final String groupName;
  late AssetImage img;

  IO.Socket socket = IO.io('http://$serverIp:8800', <String, dynamic>{
    'transports': ['websocket'],
    'autoConnect': false,
  });
  final TextEditingController message = TextEditingController();

  _ViewGroup(
    this.groupName,
    this.img
  );

  @override
  void initState() {
    wallpapers.add(addWallpaperToList('assets/images/bg-white.png'));
    wallpapers.add(addWallpaperToList('assets/images/bg-black.png'));
    wallpapers.add(addWallpaperToList('assets/images/bg-pink.png'));
    wallpapers.add(addWallpaperToList('assets/images/bg-cyan.png'));
    wallpapers.add(addWallpaperToList('assets/images/bg-yellow.png'));
    wallpapers.add(addWallpaperToList('assets/images/bg-orange.png'));
    wallpapers.add(addWallpaperToList('assets/images/bg-grad1.png'));
    wallpapers.add(addWallpaperToList('assets/images/bg-grad2.png'));
    wallpapers.add(addWallpaperToList('assets/images/bg-grad3.png'));
    wallpapers.add(addWallpaperToList('assets/images/bg-grad4.png'));
    groupMembers.add(createMember("Refaat Somaia"));
    groupMembers.add(createMember("Ahmad Alhomsi"));



senderMessages[-2] = DateChip(
      date: DateTime.now(),
      color: lightBlue,
    );
    super.initState();
    senderMessages[-1] = SizedBox(
      height: 10.h,
    );
    
    connect();
    loadSettings();

  }

  @override
  void dispose() {
    socket.dispose();
    super.dispose();
  }

  bool isConnected = false;
  final ScrollController _controller = ScrollController();
  List<Widget> groupMembers=[];
  bool soundOn=true;
  bool showMyName=true;
  final messageBarCtrl=TextEditingController();
  

  void loadSettings()async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if(prefs.getBool('soundOn')!=null) {
      print(prefs.getBool('soundOn'));
      soundOn=prefs.getBool('soundOn')!;
    }
     if(prefs.getBool('showMyName')!=null) {
 
      soundOn=prefs.getBool('showMyName')!;
    }
  }

 void connect() async {
                         Message m =Message(); 
  
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    socket.connect();
    socket.onConnect((data) => {
      

          socket.on(
              '$groupName/sender',
              (data) => {
                    if (data.toString().isNotEmpty)
                      {
                        if (data.toString().split(":")[1] !=
                            prefs.getString("userFirstName"))
                          {
                            m.sender=data.toString().split(":")[1],
                            m.date='${data.toString().split(":")[3]}:${data.toString().split(":")[4]}',
                            m.message=data.toString().split(":")[2],
                            receive(m),
                          }
                      }
                  }),
        });
    if (socket.connected) {
      setState(() {
        isConnected = true;
      });
    }
  }

  void receive(Message message) {
    if (!mounted) {
      return;
    }
    if(soundOn){
     final a= AssetsAudioPlayer.newPlayer().open(
 Audio( 'assets/audios/multi-pop-3-188166.mp3'),
 
 );
 }
    
    setState(() {
      
      senderMessages.remove(-1);
      count++;
      int id = count;

      senderMessages[id] = TextButton(
          style: TextButton.styleFrom(
            minimumSize: Size.zero,
            padding: EdgeInsets.zero,
          ),
          onPressed: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          onLongPress: () {
            messageOptions(id, message.message);
          },
          child: messageBubble(message.message, 
          message.date,false,
          message.sender));
      senderMessages[-1] = SizedBox(
        height: 8.h,
      );
    });
    goToScreenBottom();
      
  }

  Map<int, Widget> senderMessages = {};
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
          backgroundColor: bodyColor,
          appBar: AppBar(
            title: Text(
              groupName,
              style: setFontStyle(12.sp, FontWeight.bold, mainColor),
            ),
            backgroundColor: bodyColor,
            centerTitle: true,
            actions: [
              Container(
                height: 7.h,
                decoration:  BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: img,
                        fit: BoxFit.contain)),
                child: dropDown(),
              ),
            ],
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back_ios_rounded,
                  color: secondColor,
                  size: 7.w,
                )),
            toolbarHeight: 7.h,
          ),
          body: Stack(children: [
            Container(
              height: 100.h,
               decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(bgImage), fit: BoxFit.cover),
              ),
            ),
            SizedBox(
             
              height: 84.4.h,
              width: 100.w,
              child: SizedBox(
                height: 74.h,
                child: ListView(
                  controller: _controller,
                  children: senderMessages.values.toList(),
                ),
              ),
            ),
            SizedBox(
              width: 100.w,
              child: messageBar(),
            ),
          ])),
    );
  }

  Widget messageBar() {

        bool x=true;

    return MessageBar(
      
      textFieldTextStyle: setFontStyle(10.sp, FontWeight.normal, secondColor),
      messageBarHintText: 'Type here...',
      messageBarColor:bodySecond,
    
      onTextChanged: (p0) {
        if (_controller.position.maxScrollExtent !=
            _controller.position.pixels&&x) {

          _controller.animateTo(
              duration: 700.ms,
              curve: Curves.easeInOut,
              _controller.position.maxScrollExtent + 60.h);
                x=false;
              Timer(const Duration(milliseconds: 1000), () { 
                x=true;
              });
        }
      },

      sendButtonColor: mainColor,
      
      
      messageBarHintStyle: setFontStyle(8.sp, FontWeight.normal, secondColor.withOpacity(0.5)),
      onSend: (msg) async {
        final SharedPreferences prefs = await SharedPreferences.getInstance();

        if (socket.connected) {
          setState(() {
            isConnected = true;
          });
        } else {
          setState(() {
            isConnected = false;
          });
        }
        count++;
        int id = count;

        setState(() {
          senderMessages.remove(-1);
          senderMessages[id] = TextButton(
              style: TextButton.styleFrom(
                minimumSize: Size.zero,
                padding: EdgeInsets.zero,
              ),
              onPressed: () {
                
                FocusManager.instance.primaryFocus?.unfocus();
              },
              onLongPress: () {
                messageOptions(id, msg);
              },
              
              child: messageBubble(msg,  DateTime.now()
                  .toString()
                  .split(" ")[1]
                  .split('.')[0]
                  .substring(0, 5),true));
          senderMessages[-1] = SizedBox(
            height: 8.h,
          );
        });

        // FocusManager.instance.primaryFocus?.unfocus();

        socket.emit('/$groupName', "${prefs.getString("userId")}:${showMyName? prefs.getString('userFirstName'):'anonymous'}:$msg:${DateTime.now()
                  .toString()
                  .split(" ")[1]
                  .split('.')[0]
                  .substring(0, 5)}:$groupName,");

        goToScreenBottom();
          if(soundOn){
     final a= AssetsAudioPlayer.newPlayer().open(
 Audio( 'assets/audios/multi-pop-2-188167.mp3'),
 
 );
 }
      },
      actions: [
        InkWell(
          child: const Icon(
            Icons.add,
            color: secondColor,
            size: 24,
          ),
          onTap: () {},
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8, right: 8),
          child: InkWell(
            child: const Icon(
              Icons.image_rounded,
              color: secondColor,
              size: 24,
            ),
            onTap: () {
              senderMessages.remove(-1);
              sendImage();
           
            },
          ),
        ),
      ],
    );
  }

  Widget addWallpaperToList(String path) {
    return Container(
      margin: EdgeInsets.only(bottom: 2.h),
      width: 40.w,
      height: 40.w,
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage(path), fit: BoxFit.cover),
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextButton(
        onPressed: () async {
          setState(() {
            bgImage = path;
          });
          final SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString("groupsBg", path);

          Navigator.pop(context, 'OK');
        },
        child: const Text(''),
      ),
    );
  }

  List<Widget> wallpapers = [];


  Widget messageBubble(String msg,String date,bool isSender,[String? sender]){
    Color color= isSender?bodyColor:Colors.black;
    Color bgColor= isSender?mainColor:Color.fromARGB(255, 238, 238, 238);
    return Animate(
      child: Container(
        margin: EdgeInsets.only(bottom: 0.5.h),
        width: 100.w,
        child: Row(
          mainAxisAlignment: isSender?MainAxisAlignment.end:
          MainAxisAlignment.start,
          children: [
            Stack(
              children: [
        
                Container(
                  decoration: BoxDecoration(
                    color:!isSender? bgColor: isConnected
                  ? bgColor
                  : orangeColor,
                    borderRadius: BorderRadius.circular(18)
                  ),
                  padding: EdgeInsets.only(top: isSender? 12:20,left: 12,right: 12,bottom: 25),
                  margin: EdgeInsets.only(left: 2.w,right: 2.w),
                  constraints: BoxConstraints(maxWidth: 70.w,minWidth: 20.w),
                  child: Text(msg,style: setFontStyle(10.sp, FontWeight.normal, color),),
                ),
                      if(!isSender)   Positioned(
                    left:0,
                    top: 0,
      
                    child: Container(
                      
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18)
                    ),
                    margin: const EdgeInsets.only(right: 15,left: 17,top: 3),
                    child:     Text(
               sender!,
                style: setFontStyle(showMyName? 8.sp:6.sp, FontWeight.bold, Color(0xFF54BAB9)),
              ),
                                  ),
                  ),
                  Positioned(
                    right:isSender? 0:null,
                    left: isSender? null:0,
                    bottom: 0,
      
                    child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20)
                    ),
                    margin: EdgeInsets.only(bottom: 0.5.h,right: 15,left: 17),
                    child:     Text(
               date,
                style: setFontStyle(7.sp, FontWeight.bold, color.withOpacity(isSender?0.5: 0.3)),
              ),
                                  ),
                  ),
              ],
            ),
            
      
      
      
        ],),
      ),
    ).fadeIn().slide(
          curve: Curves.easeInOut,
        );
  }

 

  Widget dropDown() {
    return DropdownButtonHideUnderline(
      child: DropdownButton(
        icon: const Icon(
          CustomIcons.kebab_vertical,
          color: secondColor,
        ),
        iconSize: 7.w,
        borderRadius: BorderRadius.circular(12),
        items: chatOptions,
        alignment: Alignment.center,
        dropdownColor: bodyColor,
        onChanged: (value)async {
          if (value == 'wallpaper') {
            showDialog(
              context: context,
              builder: (context) {
                return StatefulBuilder(
                  builder: (context, setState) {
                    return AlertDialog(
                      title: Center(
                          child: Text(
                        'Wallpaper',
                        style: setFontStyle(12.sp, FontWeight.bold, mainColor),
                      )),
                      backgroundColor: offWhite,
                      surfaceTintColor: offWhite,
                      actions: <Widget>[
                        SizedBox(
                            height: 60.h,
                            width: 90.w,
                            child: GridView(
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      mainAxisSpacing: 2.w,
                                      crossAxisSpacing: 2.w),
                              children: wallpapers,
                            ))
                      ],
                    );
                  },
                );
              },
            );
          } else if (value == 'clear') {
            setState(() {
              senderMessages.removeWhere((key, value) => key!=-2);
              count = 0;
            });
          }
          else if (value == 'leave') {
            print(groupName);
            SharedPreferences prefs=await SharedPreferences.getInstance(); 
            for(int i=0;i<5;i++){
              print(prefs.getString("userGroups,$i").toString());
              if(prefs.getString("userGroups,$i").toString()==groupName){
                prefs.setString("userGroups,$i", "");
      Navigator.pushAndRemoveUntil(
      context,
      CupertinoPageRoute(
        builder: (BuildContext context) =>Home(2),
      ),
      (route) => false,
    );
          break;
              }
            }
            
            }
         else if(value=='members'){
            showDialog<String>(
      context: context,
      
      builder: (BuildContext context) => AlertDialog(
        backgroundColor: bodyColor,
        surfaceTintColor: bodyColor,
          title: Center(
                          child: Text(
                        'Group members',
                        style: setFontStyle(12.sp, FontWeight.bold, mainColor),
                      )),
        actions: <Widget>[
      
            Center(
              child: SizedBox(
                width: 90.w,
              ),
            ),
        
        SizedBox(
                            height: 60.h,
                            width: 90.w,
                            child: ListView(
                            
                          
                              children: groupMembers,
                            ),
                            
        ),
        Center(child: Text('Count: ${groupMembers.length}',style: setFontStyle(8.sp, FontWeight.bold, mainColor),))

        ]
      )
            );

          }
          else if(value=='settings'){
            showDialog(
              context: context,
              builder: (context) {
                return StatefulBuilder(
                  builder: (context, setState) {
                    return AlertDialog(
                      title: Center(
                          child: Text(
                        'Settings',
                        style: setFontStyle(12.sp, FontWeight.bold, mainColor),
                      )),
                      backgroundColor: bodyColor,
                      surfaceTintColor: bodyColor,
                      actions: <Widget>[
                        SizedBox(
                            height: 60.h,
                            width: 90.w,
                            child: Column(children: [
                              Text("Message sound",style: setFontStyle(10.sp, FontWeight.bold, secondColor),),
                              SizedBox(height: 1.h,),
                              Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                border: const Border(
                                  bottom:
                                      BorderSide(width: 4, color: mainColor),
                                ),
                              ),
                              child: ToggleSwitch(
                                minWidth: 20.w,
                                minHeight: 3.h,
                                cornerRadius: 2.h,
                                initialLabelIndex: soundOn?0:1,
                                inactiveBgColor: const Color(0xFFF6F6F6),
                                inactiveFgColor: secondColor,
                                totalSwitches: 2,
                                labels: const ['On', 'Off'],
                                customTextStyles: [
                                  setFontStyle(
                                      8.sp, FontWeight.w600, secondColor)
                                ],
                                activeBgColors: const [
                                  [lightBlue],
                                  [lightBlue]
                                ],
                                animationDuration: 200,
                                animate: true,
                                onToggle: (index)async {
   final SharedPreferences prefs = await SharedPreferences.getInstance();

                                  if (index == 0) {
                                    soundOn = true;

                                  } else {
                                    soundOn=false;
                                  }
                                  print(soundOn);
                                    prefs.setBool('soundOn',soundOn);

                                },
                              ),
                            ),
                            SizedBox(height: 3.h,),
                              Text("Show my name to others",style: setFontStyle(10.sp, FontWeight.bold, secondColor),),
                              SizedBox(height: 1.h,),
                              Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                border: const Border(
                                  bottom:
                                      BorderSide(width: 4, color: mainColor),
                                ),
                              ),
                              child: ToggleSwitch(
                                minWidth: 20.w,
                                minHeight: 3.h,
                                cornerRadius: 2.h,
                                initialLabelIndex: showMyName?0:1,
                                inactiveBgColor: const Color(0xFFF6F6F6),
                                inactiveFgColor: secondColor,
                                totalSwitches: 2,
                                labels: const ['On', 'Off'],
                                customTextStyles: [
                                  setFontStyle(
                                      8.sp, FontWeight.w600, secondColor)
                                ],
                                activeBgColors: const [
                                  [lightBlue],
                                  [lightBlue]
                                ],
                                animationDuration: 200,
                                animate: true,
                                onToggle: (index)async {
   final SharedPreferences prefs = await SharedPreferences.getInstance();

                                  if (index == 0) {
                                    showMyName=true;
                                    prefs.setBool('showMyName', true);
                                   
                                  } else {
                                     showMyName=false;
                                    prefs.setBool('showMyName', false);
                                  }
                           

                                },
                              ),
                            ),
                            ],)

                        ),
                      ],
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }

  Future<dynamic> messageOptions(int id, [String? msg]) {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        actions: <Widget>[
          Center(
            child: SizedBox(
              width: 90.w,
              child: Column(
                children: [
                  TextButton(
                      onPressed: () {
                        setState(() {
                          senderMessages.remove(id);
                        });
                            final a= AssetsAudioPlayer.newPlayer().open(
 Audio( 'assets/audios/multi-pop-1-188166.mp3'),
 
 );

                        Navigator.pop(context, "OK");
                      },
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Delete",
                              style: setFontStyle(
                                  12.sp, FontWeight.bold, orangeColor),
                            ),
                            SizedBox(
                              width: 2.w,
                            ),
                            const Icon(
                              Icons.delete_rounded,
                              color: orangeColor,
                            )
                          ],
                        ),
                      )),
                  msg != null
                      ? TextButton(
                          onPressed: () async {
                            ClipboardData data = ClipboardData(text: msg);
                            await Clipboard.setData(data);
                            Navigator.pop(context, "OK");
                          },
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Copy",
                                  style: setFontStyle(
                                      12.sp, FontWeight.bold, mainColor),
                                ),
                                SizedBox(
                                  width: 2.w,
                                ),
                                const Icon(
                                  Icons.copy,
                                  color: mainColor,
                                )
                              ],
                            ),
                          ))
                      : const SizedBox()
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void sendImage() async {
    File? _imgFile;

    final ImagePicker picker = ImagePicker();
    final XFile? img = await picker.pickImage(
      source: ImageSource.gallery, // alternatively, use ImageSource.gallery
    );
    if (img == null) return;
    setState(() {
      _imgFile = File(img.path); // convert it to a Dart:io file
      // socket.emit('/test', _imgFile.);
      count++;
      int id =count ;
      senderMessages[id] = TextButton(
          style: TextButton.styleFrom(
            minimumSize: Size.zero,
            padding: EdgeInsets.zero,
          ),
          onPressed: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          onLongPress: () {
            messageOptions(id);
          },
          child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
            BubbleNormalImage(
              id: '$id',
              image: Image.file(_imgFile!),
              color:isConnected? mainColor :orangeColor,
              tail: true,
              sent: true,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  DateTime.now()
                      .toString()
                      .split(" ")[1]
                      .split('.')[0]
                      .substring(0, 5),
                  style: setFontStyle(8.sp, FontWeight.normal, lightBlue),
                ),
                SizedBox(
                  width: 2.w,
                ),
              ],
            )
          ]));
                 senderMessages[-1] = SizedBox(
            height: 8.h,
          );

    });
    goToScreenBottom();
     if(soundOn){
     final a= AssetsAudioPlayer.newPlayer().open(
 Audio( 'assets/audios/multi-pop-3-188166.mp3'),
 
 );
 }
  }

  void goToScreenBottom() {
    if(_controller.position.pixels>0) {
      _controller.animateTo(
        duration: 700.ms,
        curve: Curves.easeInOut,
        _controller.position.maxScrollExtent + 70.h);
    }
  }









   Widget createMember(String userName) {
    
   
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 1.h),
      decoration:  BoxDecoration(
          color: bodySecond,
          borderRadius:BorderRadius.circular(12)
          ),
      child: Row(
        children: [
          Container(
            width: 50.w,
            padding: EdgeInsets.all(4.w),
            child: Text(
                userName,style:  setFontStyle(9.sp, FontWeight.w500, secondColor)),
          ),
          Container(
            width: 12.w,
            height: 12.w,
            margin: EdgeInsets.all(1.w),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
            image: DecorationImage(image: AssetImage(
              'assets/images/user.png',
              
            ))
            ),
            
          ),
        ],
      ),
    );
  }

}
