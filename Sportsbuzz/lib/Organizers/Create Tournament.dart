import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/services.dart';

import 'package:flutter/cupertino.dart';

import 'package:intl/intl.dart';
import 'package:sportsbuzz/Authentication/Organizer.dart';
import 'package:sportsbuzz/DashBoard.dart';
import 'package:sportsbuzz/Organizers/CreateTeams.dart';
import 'package:sportsbuzz/Organizers/Matches.dart';
import 'package:sportsbuzz/SaveData/TeamsList.dart';
import '../SaveData/SaveData.dart';
var _role1,_role2;
Set<String> teams_list={'Select Team'};
Map<String,String> Temp={};
Map<String,dynamic> Match={};
var orgID;
GetIdTournament(String idt){
  orgID=idt;


}
List<Map<String, dynamic>> Matches= [];
int matcn_no=0;
FirebaseAuth auth = FirebaseAuth.instance;
final userRef = FirebaseFirestore.instance.collection('Teams');
var _formKey = GlobalKey<FormState>();
SaveData _saveData = new SaveData();
TextEditingController title = new TextEditingController();
TextEditingController Match_title = new TextEditingController();
TextEditingController team1 = new TextEditingController();
TextEditingController team2 = new TextEditingController();
TextEditingController Details = new TextEditingController();
TextEditingController StartDate = new TextEditingController();
TextEditingController Mtach_StartDate = new TextEditingController();
TextEditingController EndDate = new TextEditingController();
TextEditingController overs = new TextEditingController();
TextEditingController city = new TextEditingController();

//Register _register = new Register();
GetTournamentID(String ID){
  orgID=ID;

}
var  id;
String btn = 'Submit', appBar = "Register as Donor";
bool T_visible = true;
bool M_visible=false;




final db = FirebaseFirestore.instance;

class CreateTournament extends StatefulWidget {
  const CreateTournament({Key? key}) : super(key: key);

  @override
  State<CreateTournament> createState() => _CreateTournamentState();
}

class _CreateTournamentState extends State<CreateTournament> {
  GetTeamNames(){

  }

  DateTime selectedDate = DateTime.now();
  final format = DateFormat("dd-MM-yyyy");
  Future getDocs() async {
    QuerySnapshot querySnapshot = await db.collection("Teams").get();
    for (int i = 0; i < querySnapshot.docs.length; i++) {
      var a = querySnapshot.docs[i]['Name'];
      teams_list.add(a);
    }
  }
  @override
  void initState() {
    print(orgID);
    teams_list.clear();
    getDocs();
    teams_list.toList();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text('Tournament'),
      ),
      body: SafeArea(
        child: Center(
          child: ListView(
            children: [
              Padding(
                  padding: const EdgeInsets.all(16.0),
                  //form
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Visibility(
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  decoration: InputDecoration(
                                      hintText: 'Enter Title',
                                      labelText: 'Title:',
                                      floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                      border: OutlineInputBorder()),

                                  controller: title,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter title';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  controller: Details,
                                  decoration: InputDecoration(
                                      hintText: 'Enter Details',
                                      labelText: 'Details:',
                                      floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                      border: OutlineInputBorder()),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Field is required';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: DateTimeField(
                                    controller: StartDate,
                                    format: format,
                                    decoration: InputDecoration(
                                        hintText: 'Ener Start Date',
                                        labelText: 'Start Date:',
                                        floatingLabelBehavior:
                                        FloatingLabelBehavior.always,
                                        border: OutlineInputBorder()),
                                    onShowPicker: (context, currentValue) {
                                      return showDatePicker(
                                          context: context,
                                          firstDate: DateTime(1950),
                                          initialDate: currentValue ?? DateTime.now(),
                                          lastDate: DateTime(2100));
                                    },
                                    validator: (value) => value == null
                                        ? 'Field Is required'
                                        : null,
                                  )),
                              Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: DateTimeField(
                                    controller: EndDate,
                                    format: format,
                                    decoration: InputDecoration(
                                        hintText: 'Enter End Date',
                                        labelText: 'End Date:',
                                        floatingLabelBehavior:
                                        FloatingLabelBehavior.always,
                                        border: OutlineInputBorder()),
                                    onShowPicker: (context, currentValue) {
                                      return showDatePicker(
                                          context: context,
                                          firstDate: DateTime(1950),
                                          initialDate: currentValue ?? DateTime.now(),
                                          lastDate: DateTime(2100));
                                    },
                                    validator: (value) => value == null
                                        ? 'Field is required'
                                        : null,
                                  )),
                              Padding(
                                padding: const EdgeInsets.all(8.0),

                                child: TextFormField(
                                  controller: overs,
                                  keyboardType: TextInputType.phone,
                                  decoration: InputDecoration(
                                      hintText: 'Enter Overs',
                                      labelText: 'Overs:',
                                      floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                      border: OutlineInputBorder()),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Field is required';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  controller: city,

                                  decoration: InputDecoration(
                                      floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                      hintText: 'Enter Address',
                                      labelText: 'Address:',
                                      border: OutlineInputBorder()),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Field is required';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ElevatedButton(
                                      onPressed: () {
                                        //reset();
                                      },
                                      style: ElevatedButton.styleFrom(
                                          primary: Colors.red),
                                      child: Text('Reset')),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  ElevatedButton(
                                      onPressed: () {
                                        if(_formKey.currentState!.validate()){

                                          setState(() {

                                            print("hello"+title.text);


                                            T_visible=false;
                                            M_visible=true;
                                          });
                                        }

                                      },
                                      style: ElevatedButton.styleFrom(
                                        primary: Colors.green,
                                      ),
                                      child: Text('Next')),
                                ],
                              ),
                            ],
                          ),
                          visible: T_visible,
                        ),
                        Visibility(
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  controller: Match_title,
                                  decoration: InputDecoration(
                                      hintText: 'Match Title',
                                      labelText: 'Title',
                                      floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                      border: OutlineInputBorder()),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Field is required';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: DropdownButtonFormField<String>(
                                    items:teams_list.map((String a) {
                                      return DropdownMenuItem(
                                          value: a,
                                          child: Text(a));

                                    }).toList(),
                                    decoration: InputDecoration(
                                        hintText: 'Select Team 1',
                                        labelText: 'Team 1',
                                        floatingLabelBehavior:
                                        FloatingLabelBehavior.always,
                                        border: OutlineInputBorder()),
                                    onChanged: (value) {
                                      setState(() {
                                        _role1=value;
                                      });
                                    },
                                    value: _role1,
                                    validator: (value) =>
                                    value == null ? 'Field is required' : null),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: DropdownButtonFormField<String>(
                                    items:teams_list.map((String a) {
                                      return DropdownMenuItem(
                                          value: a,
                                          child: Text(a));

                                    }).toList(),
                                    decoration: InputDecoration(
                                        hintText: 'Select Team 1',
                                        labelText: 'Team 1',
                                        floatingLabelBehavior:
                                        FloatingLabelBehavior.always,
                                        border: OutlineInputBorder()),
                                    onChanged: (value) {
                                      setState(() {
                                        _role2=value;
                                      });
                                    },
                                    value: _role2,
                                    validator: (value) =>
                                    value == null ? 'Field is required' : null),
                              ),



                              Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: DateTimeField(
                                    controller: Mtach_StartDate,
                                    format: format,
                                    decoration: InputDecoration(
                                        hintText: 'Ener Start Date',
                                        labelText: 'Start Date:',
                                        floatingLabelBehavior:
                                        FloatingLabelBehavior.always,
                                        border: OutlineInputBorder()),
                                    onShowPicker: (context, currentValue) {
                                      return showDatePicker(
                                          context: context,
                                          firstDate: DateTime(1950),
                                          initialDate: currentValue ?? DateTime.now(),
                                          lastDate: DateTime(2100));
                                    },
                                    validator: (value) => value == null
                                        ? 'Field Is required'
                                        : null,
                                  )),


                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ElevatedButton(
                                      onPressed: () {
                                        setState(() {
                                          M_visible=false;
                                          T_visible=true;
                                        });
                                      },
                                      style: ElevatedButton.styleFrom(
                                          primary: Colors.black),
                                      child: Text('Back')),
                                  SizedBox(width: 10,),ElevatedButton(
                                      onPressed: () {
                                        setState(() {
                                          T_visible=true;
                                          M_visible=false;

                                        });

                                        Navigator.pop(context);
                                      },

                                      style: ElevatedButton.styleFrom(
                                          primary: Colors.red),
                                      child: Text('Cancel')),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  ElevatedButton(
                                      onPressed: () {
                                        if(_formKey.currentState!.validate()){



                                        setState(() {
                                          Match['Title']=Match_title.text;
                                          Match['Team1']=_role1;
                                          Match['Team2']=_role2;
                                          Match['Date']=Mtach_StartDate.text;
                                          Matches.insert(0, Match);




                                        });


                                        }


                                      },
                                      style: ElevatedButton.styleFrom(
                                        primary: Colors.green,
                                      ),
                                      child: Text('Add Match')),
                                ],
                              ),
                              ElevatedButton(onPressed: (){
                                setState(() {


                                });
                                if(_formKey.currentState!.validate()){
                                  Map<String, dynamic> data = {
                                    'ORG_ID':orgID,
                                    'Title': title.text,
                                    'Details': Details.text,
                                    'StartDate': StartDate.text,
                                    'EndDate': EndDate.text,
                                    'Overs': overs.text,
                                    'City': city.text,
                                    'Matches':Matches,


                                  };



                                  _saveData.insertData('Tournament', data, id);

                                  _showMyDialog('Successfully', 'Created', 'ok');
                                }









                              }, child: Text("Submit"))
                            ],
                          ),
                          visible: M_visible,
                        ),
                      ],
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _showMyDialog(String title, String msg1, var msg2) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(msg1),
                Text(msg2),
              ],
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
                onPressed: () {
                  setState(() {
                   reset();
                    M_visible=false;
                    T_visible=true;


                  });
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) => DashBoard()));

                },
                style: ElevatedButton.styleFrom(
                    primary: Colors.black),
                child: Text('Back')),
          ],
        );
      },
    );
  }

  void reset() {
    setState(() {
      title.clear();
      Details.clear();
      StartDate.clear();
      EndDate.clear();
      overs.clear();
      city.clear();
      Match_title.clear();



    });
  }

}







