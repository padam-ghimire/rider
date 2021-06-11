import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:rider/AlLScreens/LoginScreen.dart';
import 'package:rider/AlLScreens/MainScreen.dart';
import 'package:rider/AlLScreens/RegisterScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}
DatabaseReference userRefs= FirebaseDatabase.instance.reference().child('users');

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Taxi Manch',
      theme: ThemeData(
        fontFamily: "Signatra",
        primarySwatch: Colors.blue,
      ),
      initialRoute: LoginScreen.screenId,
      routes: {
        RegisterScreen.screenId: (context) => RegisterScreen(),
        LoginScreen.screenId : (context) => LoginScreen(),
        MainScreen.screenId : (context) => MainScreen(),
      },
      debugShowCheckedModeBanner: false,
    );

  }


}
