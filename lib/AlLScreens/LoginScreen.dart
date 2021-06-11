import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rider/AlLScreens/MainScreen.dart';
import 'package:rider/AlLScreens/RegisterScreen.dart';
import 'package:rider/main.dart';


class LoginScreen extends StatelessWidget {

   LoginScreen({Key? key}) : super(key: key);
  static const screenId="login";

  final TextEditingController emailTextEditingController = TextEditingController();
  final TextEditingController passwordTextEditingController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(height:35.0),
              Image(
                image: AssetImage('images/logo.png'),
                width: 250.0,
                height: 250.0,
                alignment: Alignment.center,
              ),
              SizedBox(height:1.0),
             Text(
               "Rider Login",
               textAlign: TextAlign.center,
               style: TextStyle(fontSize: 24.0,fontFamily: "Brand-Bold"),
             ),

              Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    SizedBox(height:1.0),
                    TextField(
                      controller: emailTextEditingController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: "Email",
                        labelStyle: TextStyle(
                            fontSize: 14.0,
                            fontFamily:""
                        ),
                        hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 10.0
                        ),
                      ),
                      style: TextStyle(fontSize: 14.0),
                    ),
                    SizedBox(height:1.0),
                    TextField(
                      controller: passwordTextEditingController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: "Password",
                        labelStyle: TextStyle(
                            fontSize: 14.0,
                        ),
                        hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 10.0
                        ),
                      ),
                      style: TextStyle(fontSize: 14.0),
                    ),
                    SizedBox(height: 1.0,),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.yellow,
                      ),

                      onPressed: () async {

                        if(!emailTextEditingController.text.contains('@')){
                          displayMessage("Provide valid email!",context);
                          }else if(passwordTextEditingController.text.length <5) {
                          displayMessage(
                              "Password must be at least 5 charaters long!",
                              context);
                        }

                          else {
                           await loginUser(context);
                          }
                      },
                      child: Center(
                        child: Text(
                            "Login",
                          style: TextStyle(
                            fontSize: 18.0,
                            fontFamily: "Brand-Bold"
                          ),
                        ),

                      ),
                    ),
                  ],
                ),
              ),
              TextButton(
              onPressed: (){
                Navigator.pushNamedAndRemoveUntil(context, RegisterScreen.screenId, (route) => false);
              },
                child: Text(
                  "Do not have account? Sign up"
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
   final FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> loginUser(BuildContext context) async{
   //tyo user ? le garda aako error ho aaunu bhayana nita :(


       auth
          .signInWithEmailAndPassword(
          email: emailTextEditingController.text.trim(),
          password: passwordTextEditingController.text.trim()
      ).catchError((e) {
        // auth.signOut();
        displayMessage("User Email or password did not match", context);
      } ).then((UserCredential users) => {debugPrint(users.toString())});
        // Navigator.pushNamedAndRemoveUntil(
        //     context, MainScreen.screenId, (route) => false);
        // displayMessage("Signed in!", context);
//kaha xa k null
//full relaod garnu ta

  }

   displayMessage(String message,BuildContext context){
    Fluttertoast.showToast(msg: message);
   }
}
