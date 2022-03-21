import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sportsbuzz/Authentication/LoginPage.dart';
import 'package:sportsbuzz/Authentication/Organizer.dart';
import 'package:sportsbuzz/DashBoard.dart';
import 'package:sportsbuzz/Organizers/AddPlayers.dart';
import 'package:sportsbuzz/SplashScreen/SplashScreen.dart';
import 'package:sportsbuzz/User%20Managment.dart';
import 'User Managment.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();


  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',

      home: SplashScreen()//UserManagement().handleAuth()
  ));
}




