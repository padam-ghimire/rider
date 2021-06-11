import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rider/AlLScreens/LoginScreen.dart';
import 'package:rider/AlLScreens/MainScreen.dart';
import 'package:rider/main.dart';


class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);
  static const screenId = "register";

  final TextEditingController nameTextEditingController = TextEditingController();
  final TextEditingController emailTextEditingController = TextEditingController();
  final TextEditingController phoneTextEditingController = TextEditingController();
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
              SizedBox(height: 35.0),
              Image(
                image: AssetImage('images/logo.png'),
                width: 250.0,
                height: 250.0,
                alignment: Alignment.center,
              ),
              SizedBox(height: 1.0),
              Text(
                "Rider Registration",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24.0, fontFamily: "Brand-Bold"),
              ),

              Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    SizedBox(height: 1.0),
                    TextField(
                      controller: nameTextEditingController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: "Name",
                        labelStyle: TextStyle(
                            fontSize: 14.0,
                            fontFamily: ""
                        ),
                        hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 10.0
                        ),
                      ),
                      style: TextStyle(fontSize: 14.0),
                    ),
                    SizedBox(height: 1.0),
                    TextField(
                      controller: emailTextEditingController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: "Email",
                        labelStyle: TextStyle(
                            fontSize: 14.0,
                            fontFamily: ""
                        ),
                        hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 10.0
                        ),
                      ),
                      style: TextStyle(fontSize: 14.0),
                    ),
                    SizedBox(height: 1.0),
                    TextField(
                      controller: phoneTextEditingController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        labelText: "Phone",
                        labelStyle: TextStyle(
                            fontSize: 14.0,
                            fontFamily: ""
                        ),
                        hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 10.0
                        ),
                      ),
                      style: TextStyle(fontSize: 14.0),
                    ),
                    SizedBox(height: 1.0),
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

                      onPressed: () {
                        if(passwordTextEditingController.text.length <5){

                          displayMessage("Password must be atleast 5 charaters long!",context);
                        }else if(!emailTextEditingController.text.contains('@')){
                          displayMessage("Provide valid email!",context);
                        }else if(phoneTextEditingController.text.isEmpty){
                          displayMessage("Phone number is required!",context);
                        }else if(nameTextEditingController.text.isEmpty){
                          displayMessage("Name is required!",context);
                        }else{
                          registerUser(context);
                        }


                      },
                      child: Center(
                        child: Text(
                          "Register",
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
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                      context, LoginScreen.screenId, (route) => false);
                },
                child: Text(
                    "Already have account ? Login"
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  final FirebaseAuth auth = FirebaseAuth.instance;

  void registerUser(BuildContext context) async {
    try {
      final User? firebaseUser = (await auth
          .createUserWithEmailAndPassword(
          email: emailTextEditingController.text,
          password: passwordTextEditingController.text
      )).user;
      if(firebaseUser !=null){
          userRefs.child(firebaseUser.uid);
          Map userMap={
            "name" : nameTextEditingController.text.trim(),
            "email" : emailTextEditingController.text.trim(),
            "phone" : phoneTextEditingController.text.trim(),
          };
          userRefs.child(firebaseUser.uid).set(userMap);

          Navigator.pushNamedAndRemoveUntil(context, MainScreen.screenId, (route) => false);
          displayMessage("Your account has been created!", context);
      }else{
        displayMessage("New user cannot be created!", context);
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }
   displayMessage(String message,BuildContext context){

   Fluttertoast.showToast(msg: message);


  }
}
