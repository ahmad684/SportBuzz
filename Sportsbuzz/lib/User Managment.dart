// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:sportsbuzz/Authentication/Admin.dart';
// import 'package:sportsbuzz/Authentication/LoginPage.dart';
// import 'package:sportsbuzz/Authentication/Organizer.dart';
// import 'package:sportsbuzz/DashBoard.dart';
// var user =FirebaseAuth.instance.currentUser;
// class UserManagement{
//   Widget handleAuth(){
//
//     return StreamBuilder<DocumentSnapshot>(
//         stream: FirebaseFirestore.instance.collection('User').doc(user!.uid).snapshots(),
//         builder: (BuildContext context,AsyncSnapshot<DocumentSnapshot> snapshots){
//           if(snapshots.hasError){
//             return Text('errpe: ${snapshots.error}');
//           }
//           switch(snapshots.connectionState){
//             case ConnectionState.
//
//           }
//
//         });
//   }
//   AuthorizeAccess(BuildContext context){
// final user =FirebaseAuth.instance.currentUser;
// FirebaseFirestore.instance.collection('User').where('ID',isEqualTo: user!.uid).get().
// then((doc){
//   if(doc.docs[0].exists){
// if(doc.docs[0]['Role']=='Admin'){
//   Navigator.push(context, MaterialPageRoute(builder: (context)=>AdminPAge()));
//
// }
//
//
// else{
//   print('Not Authorizes');
//   print(doc.docs[0]['Role']);
// }
//   }
// });
//
//
//   }
//   SignOut(){
//     FirebaseAuth.instance.signOut();
//   }
// }
