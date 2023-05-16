// ignore_for_file: non_constant_identifier_names, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:notesapp/app/componet/crud.dart';
import '../constant/customtextforms.dart';
import '../constant/linkapi.dart';
import '../homepage.dart';
import 'login.dart';

class SignUpScreen extends StatefulWidget {
  static const routeName = 'SignUpScreen';

  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  GlobalKey<FormState> formstate = GlobalKey();
  final Crud _crud = Crud();
  bool islodaing = false;
  TextEditingController email = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController password = TextEditingController();

  SignUp() async {
    islodaing = true;
    setState(() {});
    var response = await _crud.postRequest(linkSignUp, {
      'username': name.text,
      'email': email.text,
      'password': password.text
    });
    islodaing = false;
    setState(() {});
    if (response['status'] == "Success") {
      Navigator.pushNamedAndRemoveUntil(
          context, HomePage.routeName, (route) => false);
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: islodaing == true
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView(
              children: [
                Form(
                    key: formstate,
                    child: SingleChildScrollView(
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
                            hintlabel: "Enter your name",
                            label: "User Name",
                            controller: name,
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          TextForms(
                            hintlabel: "Enter your email",
                            label: "Email",
                            controller: email,
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          TextForms(
                            hintlabel: "Enter your Password",
                            label: "Password",
                            controller: password,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          ElevatedButton(
                              onPressed: () async {
                                await SignUp();
                              },
                              child: const Text("SignUp")),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("Already Have Account ?"),
                              TextButton(
                                  onPressed: () {
                                    Navigator.pushNamed(
                                        context, LoginScreen.routeName);
                                  },
                                  child: const Text("Login"))
                            ],
                          )
                        ],
                      ),
                    ))
              ],
            ),
    );
  }
}
