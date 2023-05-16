// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:notesapp/app/auth/signup.dart';
import 'package:notesapp/app/componet/crud.dart';
import 'package:notesapp/app/homepage.dart';
import 'package:notesapp/main.dart';

import '../constant/customtextforms.dart';
import '../constant/linkapi.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = "loginScreen";

  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GlobalKey<FormState> formstate = GlobalKey();
  final Crud _crud = Crud();
  TextEditingController email = TextEditingController();

  TextEditingController password = TextEditingController();

  bool isloading = false;

  // ignore: non_constant_identifier_names
  Login() async {
    isloading = true;
    setState(() {});

    var response = await _crud.postRequest(
        linkLogin, {'email': email.text, 'password': password.text});

    isloading = false;
    setState(() {});

    if (response['status'] == "Success") {
      sharedPref.setString("id", response['data']['id'].toString());
      sharedPref.setString("username", response['data']['username']);
      sharedPref.setString("email", response['data']['email']);
      Navigator.pushNamedAndRemoveUntil(
          context, HomePage.routeName, (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isloading == true
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView(
              children: [
                Form(
                    key: formstate,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 50),
                          child: SizedBox(
                              height: 200,
                              width: 200,
                              child: Image.asset("assets/images/note.png")),
                        ),
                        const SizedBox(height: 70),
                        TextForms(
                          hintlabel: "Enter your Email",
                          label: "Email",
                          controller: email,
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        TextForms(
                          hintlabel: "Enter your password",
                          label: "password",
                          controller: password,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        ElevatedButton(
                            onPressed: () async {
                              await Login();
                            },
                            child: const Text("Login")),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Don't Have Account ?"),
                            TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(
                                      context, SignUpScreen.routeName);
                                },
                                child: const Text("Sign Up"))
                          ],
                        )
                      ],
                    ))
              ],
            ),
    );
  }
}
