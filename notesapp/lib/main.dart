import 'package:flutter/material.dart';
import 'package:notesapp/app/auth/signup.dart';
import 'package:notesapp/app/homepage.dart';
import 'package:notesapp/app/notes/add.dart';
import 'package:notesapp/tttest.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app/auth/login.dart';
import 'app/notes/edit.dart';

late SharedPreferences  sharedPref ;
void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedPref = await SharedPreferences.getInstance();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My Notes',
      theme: ThemeData(

        primarySwatch: Colors.brown,
      ),

      initialRoute: sharedPref.getString('id')==null? LoginScreen.routeName : HomePage.routeName ,
      routes: {
        '/' : (context)=>const LoginScreen(),
        LoginScreen.routeName: (context)=>const LoginScreen(),
        SignUpScreen.routeName: (context)=>const SignUpScreen(),
        HomePage.routeName :(context)=> HomePage(),
        AddNote.routeName : (context)=>const AddNote(),
        // ignore: equal_keys_in_map
        EditNote.routeName : (context)=>const EditNote(),

  },
    );
  }
}


