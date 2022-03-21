import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sportsbuzz/ADMIN/ManageOrganzer.dart';
import 'package:sportsbuzz/Authentication/Admin.dart';
import 'package:sportsbuzz/Authentication/LoginPage.dart';
import 'package:sportsbuzz/Authentication/Organizer.dart';
import 'package:sportsbuzz/Authentication/Spectator.dart';
import 'package:sportsbuzz/Drawer.dart';
import 'package:sportsbuzz/Organizers/Teams.dart';
import 'package:sportsbuzz/Servises/ManageSpectators.dart';
import 'package:sportsbuzz/User%20Managment.dart';

import 'Organizers/Create Tournament.dart';
import 'Organizers/CreateTeams.dart';
import 'Organizers/ManageTornament.dart';
import 'Organizers/Matches.dart';
final db=FirebaseFirestore.instance;
var u_r="";
var email_u='';
bool delete=true;
GetUserValue(String a,String b){
  u_r=a;
  email_u=b;

}
bool Admin=false;
bool organizer=false;bool

spectator=false;
AdminVisibilty(bool sdmin,bool del){
  delete=del;
  Admin=sdmin;
  print('Admin');


}SpecVisibilty(bool Admin,bool del){
  spectator=Admin;
  delete=del;
  print('Spectator');

}OrganizerVisibilty(bool Admin,bool del){
  delete=del;

  organizer=Admin;
  print('Organizer');

}
class DashBoard extends StatefulWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  var query = db.collection('Tournament').snapshots();
  var query1 = db.collection('Teams').snapshots();
@override
  void initState() {
  if(u_r=='Admin'){
    setState(() {
      Admin=true;
      delete=true;
    });
  }if(u_r=='Organizer'){
    setState(() {
      delete=false;
      organizer=true;
    });
  }if(u_r=='Spectator'){
    setState(() {
      delete=false;
      spectator=true;
    });
  }
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text('DashBoard'),

      ),
      drawer: Drawer(


        child: ListView(
          children: [
            UserAccountsDrawerHeader(
                decoration: BoxDecoration(
                    color: Colors.red
                ),

                currentAccountPicture: CircleAvatar(
                  backgroundColor: Colors.white,
                ),
                accountName: Text(u_r),
                accountEmail: Text(email_u)),
            Visibility(
              child: Column(
                children: [
                  InkWell(
                      onTap: () {
                    setState(() {
                      GEtOrganizerID(email_u);
                    });
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>CreateTeams()));

                      },
                      child: ListTile(
                          title: Text('Create Teams',
                            style: TextStyle(color: Colors.red, fontSize: 16),),
                          leading: Icon(
                            Icons.fiber_new,
                            color: Colors.red,
                          ))),
                  InkWell(
                      onTap: () {
                        setState(() {
                          GetTournamentID(email_u);
                        });

                        Navigator.push(context, MaterialPageRoute(
                            builder: (context) => CreateTournament()));
                      },
                      child: ListTile(
                          title: Text('Create Tournament',
                            style: TextStyle(color: Colors.red, fontSize: 16),),
                          leading: Icon(
                            Icons.fiber_new,
                            color: Colors.red,
                          ))),
                  InkWell(
                      onTap: () {
                        setState(() {
                          GetTemaID(email_u);
                        });

                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Teams()));
                      },
                      child: ListTile(

                          title: Text('Manage Teams',
                            style: TextStyle(color: Colors.red, fontSize: 16),),
                          leading: Icon(
                            Icons.add,
                            color: Colors.red,
                          ))),
                  InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context) => Managetournament()));
                      },
                      child: ListTile(
                          title: Text('Manage Tournament',
                            style: TextStyle(color: Colors.red, fontSize: 16),),
                          leading: Icon(
                            Icons.add,
                            color: Colors.red,
                          ))),
                  InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>Teams()));

                      },
                      child: ListTile(
                          title: Text('Manage Spectators',
                            style: TextStyle(color: Colors.red, fontSize: 16),),
                          leading: Icon(
                            Icons.manage_accounts,
                            color: Colors.red,
                          ))),

                  InkWell(
                      onTap: () {
                        setState(() {
                          spectator=false;
                          organizer=false;
                          Admin=false;
                          SignOut();
                        });
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginPage()));

                      },
                      child: ListTile(
                          title: Text('LogOut',
                            style: TextStyle(color: Colors.red, fontSize: 16),),
                          leading: Icon(
                            Icons.logout,
                            color: Colors.red,
                          ))),

                ],
              ),
              visible: organizer,
            ),
            //Admin
            Visibility(
              child: Column(
                children: [



                  InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>ManageOrganizers()));

                      },
                      child: ListTile(
                          title: Text('Manage Organizer',
                            style: TextStyle(color: Colors.red, fontSize: 16),),
                          leading: Icon(
                            Icons.manage_accounts,
                            color: Colors.red,
                          ))),
                  InkWell(
                      onTap: () {

                      },
                      child: ListTile(
                          title: Text('FeedBack',
                            style: TextStyle(color: Colors.red, fontSize: 16),),
                          leading: Icon(
                            Icons.live_tv,
                            color: Colors.red,
                          ))),
                  InkWell(
                      onTap: () {
                        setState(() {
                          spectator=false;
                          organizer=false;
                          Admin=false;
                          SignOut()
                          ;
                        });
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginPage()));
                      },
                      child: ListTile(
                          title: Text('LogOut',
                            style: TextStyle(color: Colors.red, fontSize: 16),),
                          leading: Icon(
                            Icons.logout,
                            color: Colors.red,
                          ))),

                ],
              ),
              visible: Admin,
            ),
            //Spectator
            Visibility(
              child: Column(
                children: [




                  InkWell(
                      onTap: () {

                        setState(() {
                          SignOut();
                          spectator=false;
                          organizer=false;
                          Admin=false;
                        });
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginPage()));
                      },
                      child: ListTile(
                          title: Text('LogOut',
                            style: TextStyle(color: Colors.red, fontSize: 16),),
                          leading: Icon(
                            Icons.logout,
                            color: Colors.red,
                          ))),

                ],
              ),
              visible: spectator,
            ),

          ],
        ),
      ),
      body:SafeArea(
        child: StreamBuilder(
          stream: db.collection('Tournament').snapshots(),
          builder: (BuildContext context,
              AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }
            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot ds = snapshot.data!.docs[index];
                  return Column(
                    children: [

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(

                          shape: RoundedRectangleBorder(


                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          elevation: 1,
                          color: Colors.white,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ListTile(
                                tileColor: Colors.black12,
                                title: Center(child: Text(ds['Title'],
                                  style: TextStyle(fontSize: 25,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),)),
                                trailing: Visibility(
                                  child: IconButton(onPressed: (){


                                  }, icon: Icon(Icons.delete)),
                                  visible: delete,
                                ),
                                //subtitle: Text(ds['Details'],style: TextStyle(fontSize: 20,color: Colors.black),),


                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Text('Overs', style: TextStyle(
                                        fontSize: 20, color: Colors.black54),),
                                    SizedBox(width: 170,),
                                    Text(ds['Overs'], style: TextStyle(
                                        fontSize: 20, color: Colors.green),),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Text('Start Date:', style: TextStyle(
                                        fontSize: 20, color: Colors.black54),),
                                    SizedBox(width: 90,),
                                    Text(ds['StartDate'], style: TextStyle(
                                        fontSize: 20, color: Colors.red),),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Text('End Date:', style: TextStyle(
                                        fontSize: 20, color: Colors.black54),),
                                    SizedBox(width: 100,),
                                    Text(ds['EndDate'], style: TextStyle(
                                        fontSize: 20, color: Colors.red),),
                                  ],
                                ),
                              ),


                              ButtonBar(
                                children: [
                                  ElevatedButton(onPressed: () {
                                    setState(() {
                                      setState(() {
                                        MatchVisibilty(false);
                                      });
                                      List11=[...ds["Matches"]];


                                    });
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>Scheduald()));

                                  },
                                      style: ElevatedButton.styleFrom(
                                        primary: Colors.green,

                                        shape: RoundedRectangleBorder(


                                          borderRadius: BorderRadius.circular(15.0),
                                        ),
                                      ),
                                      child: Text('Open'))
                                ],
                              )

                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                });
          },
        ),
      ),
    );
  }
  SignOut()async{
  SharedPreferences preferences=await SharedPreferences.getInstance();
  preferences.remove('email');
  }
}
