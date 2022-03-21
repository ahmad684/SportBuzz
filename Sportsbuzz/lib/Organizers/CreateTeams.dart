import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../SaveData/SaveData.dart';
import 'Create Tournament.dart';
List<Map<String,dynamic>> PlayersList=[];
Map<String,dynamic> Player={};
int count=0;
String p1__type='player';




bool Team_visibility=true;
bool Player_visibility=false;
var OrganizerID;
GEtOrganizerID(String ID){
OrganizerID=ID;
print('My ID'+OrganizerID);
}
SaveData _saveData = new SaveData();
FirebaseAuth auth = FirebaseAuth.instance;
var _formKey = GlobalKey<FormState>();
TextEditingController Organizer = new TextEditingController();
TextEditingController name = new TextEditingController();
TextEditingController address = new TextEditingController();
TextEditingController p1 = new TextEditingController();
TextEditingController p2 = new TextEditingController();
TextEditingController p3 = new TextEditingController();
TextEditingController p4 = new TextEditingController();
TextEditingController p5 = new TextEditingController();
TextEditingController p6 = new TextEditingController();TextEditingController p8 = new TextEditingController();
TextEditingController p7 = new TextEditingController();
TextEditingController p9 = new TextEditingController();
TextEditingController p10 = new TextEditingController();
TextEditingController p11 = new TextEditingController();
TextEditingController p12 = new TextEditingController();
TextEditingController p13 = new TextEditingController();
TextEditingController p14 = new TextEditingController();
TextEditingController p15 = new TextEditingController();


class CreateTeams extends StatefulWidget {
  const CreateTeams({Key? key}) : super(key: key);

  @override

  State<CreateTeams> createState() => _CreateTeamsState();
}

class _CreateTeamsState extends State<CreateTeams> {
  @override
  void initState() {

    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        centerTitle: true,
        title: Text('Teams'),
      ),
      body:SafeArea(
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
                          child: Container(
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                        hintText: 'Enter Team Name',
                                        labelText: 'Name:',
                                        floatingLabelBehavior:
                                        FloatingLabelBehavior.always,
                                        border: OutlineInputBorder()),

                                    controller: name,
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
                                    controller: address,

                                    decoration: InputDecoration(
                                        floatingLabelBehavior:
                                        FloatingLabelBehavior.always,
                                        hintText: 'Team Address',
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

                              ],
                            ),
                          ),
                          visible: true,
                        ),
                        Container(
                          color: Colors.grey,
                            child: Center(child: Text('Add Players',style: TextStyle(fontSize: 30),))),

                        Row(children: [

                          Radio(

                              value: "Batsman", groupValue:p1__type, onChanged: (value){
                                setState(() {
                                  p1__type=value.toString();
                                  print(p1__type);
                                });

                          }),
                          Text('Batsman'),
                          Radio(value: 'Bowler', groupValue: p1__type, onChanged: (value){
                           setState(() {
                             p1__type=value.toString();
                           });

                          }),
                          Text('Bowler'),
                          Radio(value: 'AllRounder', groupValue: p1__type ,onChanged: (value){
                         setState(() {
                         p1__type=value.toString();
                         });
                        }),
                          Text('A-Rounder'),
                          Text(' *',style: TextStyle(color: Colors.red),)

                        ],),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            controller: p1,

                            decoration: InputDecoration(
                                floatingLabelBehavior:
                                FloatingLabelBehavior.always,
                                hintText: 'Player Name',
                                labelText: 'P-1',
                                border: OutlineInputBorder()),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Field is required';
                              }
                              return null;
                            },
                          ),
                        ),





                        ElevatedButton

                          (onPressed: (){
                          if(_formKey.currentState!.validate()){
                            if(count!=16) {
                              setState(() {
                                Player['P_Name'] = p1.text;
                                Player['P_Type'] = p1__type.toString();
                                print(Player);
                                PlayersList.insert(0, Player);
                                print(PlayersList);
                                count++;
                                p1.clear();
                              });
                            }else{
                              _showMyDialog('Alert', 'Maximum Player Limit Reached ', 'OK');
                              count=0;
                            }
                          }

                        },
                            style: ElevatedButton.styleFrom(
                                primary: Colors.green),
                            child: Text('Add Players')),


                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                   reset();

                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.black),
                                child: Text('Back',style: TextStyle(color: Colors.white),)),
                            SizedBox(
                              width: 10,
                            ),
                            ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                   reset();
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.red),
                                child: Text('Reset')),
                            SizedBox(
                              width: 10,
                            ),
                            ElevatedButton(
                                onPressed: () {

                                  if (_formKey.currentState!.validate()) {



                                    PlayersList.insert(0, Player);
                                    print(PlayersList);

                                    Map<String, dynamic> data = {
                                      'Organizer':OrganizerID,
                                      'Name': name.text,
                                      'Address': address.text,
                                      'Players':PlayersList
                                    };
                                    _saveData.insertData('Teams', data, id);
                                    _showMyDialog('Successfully', 'Created', 'Ok');

                                    List<String> teams=[
                                      name.text
                                    ];




                                     setState(() {
                                       teams.add(name.text);
                                       reset();
                                     });

                                    Navigator.pop(context);

                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.green,
                                ),
                                child: Text('Create')),
                          ],
                        )


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
            TextButton(
              child: const Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void reset() {
    setState(() {
      OrganizerID='';
      name.clear();
      address.clear();
     p1.clear();
     p2.clear();
     p3.clear();
     p4.clear();
     p5.clear();
     p6.clear();
     p7.clear();
     p8.clear();
     p9.clear();
     p10.clear();
     p11.clear();
     p1__type='Player';
     PlayersList.clear();
     count=0;

    });
  }

  }

