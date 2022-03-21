import 'package:flutter/material.dart';
class AdminPAge extends StatefulWidget {
  const AdminPAge({Key? key}) : super(key: key);

  @override
  State<AdminPAge> createState() => _AdminPAgeState();
}

class _AdminPAgeState extends State<AdminPAge> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin'),

      ),
      body: Container(
        color: Colors.red,
      ),
    );
  }
}
