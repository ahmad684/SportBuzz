import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sportsbuzz/Authentication/LoginPage.dart';
import 'package:sportsbuzz/SaveData/SaveData.dart';
import 'package:email_auth/email_auth.dart';
SaveData _saveData=new SaveData();
bool form=true;
bool  otp=false;
bool submitValid=false;
class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
 final auth= FirebaseAuth.instance;
  var _formKey = GlobalKey<FormState>();
  TextEditingController name=TextEditingController();
  TextEditingController role=TextEditingController();

  TextEditingController email=TextEditingController();
  TextEditingController _otp=TextEditingController();
  TextEditingController password=TextEditingController();
  var _role;
  late EmailAuth _emailAuth;
  @override
  void initState() {
    super.initState();
    // Initialize the package
    _emailAuth = new EmailAuth(
      sessionName: "Sample session",
    );

    /// Configuring the remote server

  }
 void verify() {
   bool res=_emailAuth.validateOtp(
       recipientMail: email.value.text,
       userOtp: _otp.value.text);
   if(res){
     if(_formKey.currentState!.validate()){

       print(name.text);
       print(email.text);
       print(_role);
       Map<String,dynamic> data={
         'Role':_role.toString(),
         'Name':name.text.trim(),

         'Email':email.text.trim(),


       };
       auth.createUserWithEmailAndPassword(email: email.text.trim(), password: password.text.trim()).
       catchError((e) {
         switch (e.toString()) {
           case '[firebase_auth/email-already-in-use] The email address is already in use by another account.':
             _showMyDialog(
                 'User Already Registered',
                 'Please check your email address carefully',
                 'If your are not registered then contact  to admin');
             break;
           case '[firebase_auth/network-request-failed] A network error (such as timeout, interrupted connection or unreachable host) has occurred.':
             _showMyDialog(
                 'No Internet Connection',
                 'Please connect your device to internet',
                 '');
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
             _showMyDialog(
                 'User Blocked',
                 'Your Blocked by Admin',
                 'Please Contact to Admin');
             break;
           default:
             print(
                 'Case $e is not yet implemented');
         }
       }).then((authResult){
         if(authResult.user!.uid.isNotEmpty){
           setState(() {
             form=true;
             otp=false;
           });
           var user=auth.currentUser;
           data['ID']=user!.uid;
           print(user.uid);
           _saveData.insertData('User', data,user.uid);
           _showMyDialog('Registration Successfully',
               'You are registered as Successfully',
               'Thank for joining us');
           Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginPage()));
         }
       });
     }

   }
   else{
     _showMyDialog('Alert', 'Enter Valid OTP' , 'OK');
   }
 }

 /// a void funtion to send the OTP to the user
 /// Can also be converted into a Boolean function and render accordingly for providers
 void sendOtp() async {
   bool result = await _emailAuth.sendOtp(
       recipientMail: email.value.text, otpLength: 5);
   if (result) {
     setState(() {
       submitValid = true;
     });
   }
 }
 @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('SignUp'),

      backgroundColor: Colors.red,),

      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            Visibility(
              child: Column(
                children: [
                  Center(child: Padding(

                    padding: const EdgeInsets.all(8.0),
                    child: Text('Register Here',style: TextStyle(fontSize: 18),),
                  )),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DropdownButtonFormField(
                        items: [
                          DropdownMenuItem(
                            child: Text("Spectator"),
                            value: 'Spectator',
                          ),
                          DropdownMenuItem(
                            child: Text("Organizer"),
                            value: 'Organizer',
                          ),


                        ],
                        decoration: InputDecoration(
                            hintText: 'Select  Role',
                            labelText: 'Role:',
                            floatingLabelBehavior:
                            FloatingLabelBehavior.always,
                            border: OutlineInputBorder()),
                        onChanged: (value) {
                          setState(() {
                            _role=value;
                          });
                        },
                        value: _role,
                        validator: (value) =>
                        value == null ? 'Field is required' : null),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: name,
                      decoration: InputDecoration(
                        hintText: 'Name',
                        border: OutlineInputBorder(),
                      ),
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
                    child: ElevatedButton(onPressed: (){
                      setState(() {
                        if(_formKey.currentState!.validate()){
                          setState(() {
                            sendOtp();
                            form=false;
                            otp=true;
                          });


                        }else{

                          Map<String,dynamic> data={
                            'Role':_role.toString(),
                            'Name':name.text.trim(),

                            'Email':email.text.trim(),


                          };
                          auth.createUserWithEmailAndPassword(email: email.text.trim(), password: password.text.trim()).
                          catchError((e) {
                            switch (e.toString()) {
                              case '[firebase_auth/email-already-in-use] The email address is already in use by another account.':
                                _showMyDialog(
                                    'User Already Registered',
                                    'Please check your email address carefully',
                                    'If your are not registered then contact  to admin');
                                break;
                              case '[firebase_auth/network-request-failed] A network error (such as timeout, interrupted connection or unreachable host) has occurred.':
                                _showMyDialog(
                                    'No Internet Connection',
                                    'Please connect your device to internet',
                                    '');
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
                                _showMyDialog(
                                    'User Blocked',
                                    'Your Blocked by Admin',
                                    'Please Contact to Admin');
                                break;
                               case '[firebase_auth/weak-password] Password should be at least 6 characters is not yet implemented':
                                _showMyDialog(
                                    'User Blocked',
                                    'Your Blocked by Admin',
                                    'Please Contact to Admin');
                                break;
                              default:
                                print(
                                    'Case $e is not yet implemented');
                            }
                          }).then((authResult){
                            if(authResult.user!.uid.isNotEmpty){

                              var user=auth.currentUser;
                              data['ID']=user!.uid;
                              print(user.uid);

                              _showMyDialog(
                                  'Registration Successfully',
                                  'Now you are registered as Spectator',
                                  'Thank for joining us');
                            }
                          });
                        }

                      });


                    },

                        style: ButtonStyle(
                            fixedSize: MaterialStateProperty.all(Size.fromHeight(50))
                        )
                        ,child:
                        const Text('SignUp')

                    ),
                  ),
                ],
              ),
              visible: form,
            ),
            Visibility(
              child: Column(
                children: [
                  Center(child: Padding(

                    padding: const EdgeInsets.all(8.0),
                    child: Text('An OTP is sende on you r Email please verify your Email',style: TextStyle(fontSize: 18),),
                  )),

                  Padding(
                    padding: EdgeInsets.all(12),
                    child: TextFormField(
                        controller: _otp,
keyboardType: TextInputType.phone,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'enter OTP',



                          labelText: 'OTP',
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Field is required';
                          }

                          return null;
                        }),
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(30, 12, 30, 12),
                        child: ElevatedButton(onPressed: (){
                          sendOtp();

                        },

                            style: ButtonStyle(
                                fixedSize: MaterialStateProperty.all(Size.fromHeight(50))
                              ,backgroundColor: MaterialStateProperty.all(Colors.red)
                                    ,
                            )
                            ,child:
                            const Text('Re Send OTP')

                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(30, 12, 30, 12),
                        child: ElevatedButton(onPressed: (){

                         verify();
                        },

                            style: ButtonStyle(
                                fixedSize: MaterialStateProperty.all(Size.fromHeight(50)),
                                backgroundColor: MaterialStateProperty.all(Colors.green)
                            )
                            ,child:
                            const Text('Verify')

                        ),
                      ),
                    ],
                  )


                ],
              ),
              visible: otp,
            )





          ],
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
             Navigator.pop(context);
             },
           ),
         ],
       );
     },
   );
 }
}
