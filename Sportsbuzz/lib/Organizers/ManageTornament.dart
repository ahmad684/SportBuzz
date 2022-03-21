import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../DashBoard.dart';
import 'Matches.dart';

class Managetournament extends StatefulWidget {
  const Managetournament({Key? key}) : super(key: key);

  @override
  State<Managetournament> createState() => _ManagetournamentState();
}

class _ManagetournamentState extends State<Managetournament> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Tournaments'),
        backgroundColor: Colors.red,
      ),
      body: SafeArea(
        child: StreamBuilder(
          stream: db.collection('Tournament').where('ORG_ID',isEqualTo: email_u).snapshots(),
          builder: (BuildContext context,
              AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }
            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot ds = snapshot.data!.docs[index];
                  return Padding(
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
                            trailing: IconButton(onPressed: (){


                            }, icon: Icon(Icons.delete)),
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
                                    MatchVisibilty(true);
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
                  );
                });
          },
        ),
      ),
    );
  }
}
