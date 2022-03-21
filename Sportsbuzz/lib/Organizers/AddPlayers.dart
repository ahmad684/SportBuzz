import 'package:flutter/material.dart';

import '../Authentication/Organizer.dart';
import '../DashBoard.dart';
var ListP=[];

class AddPlayers extends StatefulWidget {
  const AddPlayers({Key? key}) : super(key: key);

  @override
  State<AddPlayers> createState() => _AddPlayersState();
}

class _AddPlayersState extends State<AddPlayers> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),


    );
  }

}
