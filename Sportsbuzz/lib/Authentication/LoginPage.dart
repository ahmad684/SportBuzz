import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sportsbuzz/Authentication/Admin.dart';
import 'package:sportsbuzz/Authentication/Organizer.dart';
import 'package:sportsbuzz/Authentication/SignUpPage.dart';
import 'package:sportsbuzz/DashBoard.dart';
import 'package:sportsbuzz/Drawer.dart';


import 'SharedPrrefrences.dart';
FirebaseAuth auth = FirebaseAuth.instance;
class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var _role;

  var _formKey = GlobalKey<FormState>();
  TextEditingController email=TextEditingController();
  TextEditingController password=TextEditingController();

 @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Form(
        key: _formKey,
        child: ListView(
          children: [

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(




                child: Column(
                  children: [
                    Icon(Icons.person,color: Colors.red,size: 120,),
                    Center(
                      child: Text(
                        'Login Here',style: TextStyle(fontSize: 50,fontWeight: FontWeight.bold,color: Colors.red),
                      ),
                    ),
                  ],
                ),
                color: Colors.white,
                height: 200
                ,
              ),
            ),

            Padding(
              padding: EdgeInsets.all(12),
              child: TextFormField(
                  controller: email,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter Email Address',

                      labelText: 'Email:',
                     ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'This field is required';
                    }
                    if (!RegExp(
                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                    ).hasMatch(value)) {
                      return "a valid email like abc122@gmail.com";
                    }
                  }),
            ),
            Padding(
              padding: EdgeInsets.all(12),
              child: TextFormField(
                  controller: password,
                  obscureText: true,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Password',


                      labelText: 'Password:',
                     ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Field is required';
                    }
                    if (value.length < 6) {
                      return 'Password must be of 6 digits';
                    }
                    return null;
                  }),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(30, 12, 30, 12),
              child: ElevatedButton(onPressed: ()async{

                _signIn(email.text, password.text);



              },

                  style: ButtonStyle(
fixedSize: MaterialStateProperty.all(Size.fromHeight(50)),
                    backgroundColor: MaterialStateProperty.all(Colors.green)
                  )
                  ,child:
                  const Text('Login')

              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
               Text('Don\'t have an account?',style: TextStyle(fontSize: 18,color: Colors.red),),
               GestureDetector(
                   onTap: (){
                     Navigator.pushReplacement(
                         context,
                         MaterialPageRoute(
                             builder: (context) =>
                                 SignUp()));
                   },
                   child: Text('SignUp',style: TextStyle(fontSize: 18,color: Colors.green),)),

              ],
            )


          ],
        ),
      ),
    );
  }
  void _signIn(String email, String password) async {
   SharedPreferences preferences=await SharedPreferences.getInstance();
    try {

      await auth
          .signInWithEmailAndPassword(
          email: email.trim(), password: password.trim())
          .then((task) {
        // go to home screen
        if (task.additionalUserInfo != null) {
          var user=auth.currentUser;
          setState(() {

            preferences.setString('email', email);



            FirebaseFirestore.instance.collection('User').where('ID',isEqualTo: user!.uid).get().then((doc){
              if(doc.docs[0]["Role"]=='Admin'){

               setState(() {
                 preferences.setString('role', doc.docs[0]["Role"]);
                 GetUserValue(doc.docs[0]["Role"], email);
                 AdminVisibilty(true,true);
               });
               Navigator.push(context, MaterialPageRoute(builder: (context)=>DashBoard()));

              }
              else if(doc.docs[0]["Role"]=='Organizer'){
               setState(() {
                 preferences.setString('role', doc.docs[0]["Role"]);
                 GetUserValue(doc.docs[0]["Role"], email);
                 OrganizerVisibilty(true,false);
               });

               Navigator.push(context, MaterialPageRoute(builder: (context)=>DashBoard()));
              }
              else if(doc.docs[0]["Role"]=='Spectator'){
                setState(() {
                  preferences.setString('role', doc.docs[0]["Role"]);
                  GetUserValue(doc.docs[0]["Role"], email);
                  SpecVisibilty(true,false);
                });
                Navigator.push(context, MaterialPageRoute(builder: (context)=>DashBoard()));

              }

            });




           });

        }
      });
    } catch (e) {
      switch (e.toString()) {
        case '[firebase_auth/user-not-found] There is no user record corresponding to this identifier. The user may have been deleted.':
          _showMyDialog('User not Registered', 'Please SignUp first .',
              'If you are registered! Please Enter Correct email');
          break;
        case '[firebase_auth/wrong-password] The password is invalid or the user does not have a password.':
          _showMyDialog('Incorrect Password!', 'Please enter correct password',
              'or you can chose forgotten password option');
          break;
        case '[firebase_auth/network-request-failed] A network error (such as timeout, interrupted connection or unreachable host) has occurred.':
          _showMyDialog('No Internet Connection',
              'Please connect your device to internet', '');
          break;
        case '[firebase_auth/too-many-requests] We have blocked all requests from this device due to unusual activity. Try again later.':
          _showMyDialog(
              'Request Blocked',
              'We are detect unusual Activity from this device',
              'Try again later');
          break;
        case '[firebase_auth/too-many-requests] We have blocked all requests from this device due to unusual activity. Try again later. is not yet implemented':
          _showMyDialog(
              'Request Blocked',
              'We are detect unusual Activity from this device.',
              'Try again later!');
          break;
        case '[firebase_auth/user-disabled] The user account has been disabled by an administrator.':
          _showMyDialog('User Blocked', 'Your Blocked by Admin',
              'Please Contact to Admin');
          break;
        default:
          print('Case $e is not yet implemented');
      }
      print('The error is $e');
    }
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

}
