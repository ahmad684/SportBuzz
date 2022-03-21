import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sportsbuzz/SaveData/SaveData.dart';

import '../DashBoard.dart';
SaveData _data=new SaveData();
class ManageOrganizers extends StatefulWidget {
  const ManageOrganizers({Key? key}) : super(key: key);

  @override
  State<ManageOrganizers> createState() => _ManageOrganizersState();
}

class _ManageOrganizersState extends State<ManageOrganizers> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Organizers'),
        backgroundColor: Colors.red,
      ),
      body: SafeArea(
        child: StreamBuilder(
          stream: db.collection('User').where('Role',isEqualTo: 'Organizer').snapshots(),
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
                            leading: CircleAvatar(
                              backgroundColor: Colors.red,
                              child: Text(ds['Name'].toString().substring(0,1).toUpperCase(),style: TextStyle(fontSize: 30),),
                              radius: 30,
                            ),
                            tileColor: Colors.black12,
                            title: Text(ds['Name'],
                              style: TextStyle(fontSize: 25,
                                color: Colors.black,
                              ),),
                            subtitle: Text(ds['Email']),
                            trailing: IconButton(
                              onPressed: (){
                                _data.deleteData('User', ds.id);

                              }, icon: Icon(Icons.delete),
                            ),
                            //subtitle: Text(ds['Details'],style: TextStyle(fontSize: 20,color: Colors.black),),


                          ),




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
