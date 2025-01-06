import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sparkleship/screens/intro.dart';
import 'package:sparkleship/view/home.dart';
import '../global.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_animate/flutter_animate.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.bottom]);
    super.initState();

    loadGroupBg();
    checkLoggedIn();
  }

  void loadGroupBg() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString('groupsBg') != null) {
      setState(() {
        bgImage = prefs.getString('groupsBg')!;
      });
    }
  }

  bool loadImges = false;

  void checkLoggedIn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    Future.delayed(const Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (_) => Sizer(builder: (context, orientation, screenType) {
                String? s = prefs.getString('userEmail');
                if (s != null && s != '') {
                  userToken = prefs.getString('userToken').toString();
                  return Home(0);
                } else {
                  return const Intro();
                }
              })));
    });
  }

  @override
  Widget build(BuildContext context) {
    const Image(
      image: AssetImage(
        'assets/images/corner-welcome-top.png',
      ),
      height: 0,
    );
    const Image(
      image: AssetImage(
        'assets/images/corner-welcome-left.png',
      ),
      height: 0,
    );
    const Image(
        image: AssetImage(
          'assets/images/corner-intro-top.png',
        ),
        height: 0);
    const Image(
        image: AssetImage(
          'assets/images/corner-intro-bottom.png',
        ),
        height: 0);
    const Image(
        image: AssetImage(
          'assets/images/corner-bottom.png',
        ),
        height: 0);
    const Image(
        image: AssetImage(
          'assets/images/corner-top.png',
        ),
        height: 0);
    return Scaffold(
      body: Container(
        color: bodyColor,
        child: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Animate(
                child: Image(
                        image: const AssetImage('assets/images/logo.png'),
                        height: 25.h)
                    .animate()
                    .fade(duration: 600.ms, delay: 300.ms)
                    .scale(
                        begin: const Offset(1.4, 1.4),
                        end: const Offset(1.2, 1.2),
                        delay: 200.ms)),
          ]),
        ),
      ),
    );
  }
}
