import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


import 'package:splash_screen_view/SplashScreenView.dart';
import 'package:sportsbuzz/Authentication/LoginPage.dart';
import 'package:sportsbuzz/DashBoard.dart';

import '../Authentication/SharedPrrefrences.dart';
import '../main.dart';


var email;
class SplashScreen extends StatefulWidget {

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  AppMain()async{
    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
     email=sharedPreferences.getString('email');
    var role=sharedPreferences.getString('role');
    print(email);
    print(role);
    GetUserValue(role.toString(), email.toString());

  }
  bool IsuserLogedIn=false;
  @override
  void initState() {
    AppMain();

    // TODO: implement initState

    super.initState();
  }

  Widget build(BuildContext context) {
    Widget example2 = SplashScreenView(

      duration: 5000,
      imageSize: 400,
      imageSrc: "assets/images/logo.jpg",

      textType: TextType.ColorizeAnimationText,

      backgroundColor: Colors.white, navigateRoute:email==null?LoginPage():DashBoard(),
    );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Splash screen Demo',
      theme: ThemeData(



      ),
      home: example2,
    );
  }
}