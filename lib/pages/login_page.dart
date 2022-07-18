import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nit_anpr_app/firebase_auth.dart';
import 'package:nit_anpr_app/pages/home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool passwordVisible = false;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();

  String? validateEmail({required String email}) {
    RegExp emailRegExp = RegExp(
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");

    if (email.isEmpty) {
      return 'Email can\'t be empty';
    } else if (!emailRegExp.hasMatch(email)) {
      return 'Enter a correct email';
    }

    return null;
  }

  String? validatePassword({required String password}) {
    if (password.isEmpty) {
      return 'Password can\'t be empty';
    } else if (password.length < 6) {
      return 'Enter a password with length at least 6';
    }

    return null;
  }

  // void checkUser() {
  //   if (FireAuth.getUser() != null) {
  //     // Navigator.pushAndRemoveUntil(
  //     //     context,
  //     //     MaterialPageRoute(builder: (context) => HomePage()),
  //     //     (route) => false);
  //     Navigator.push(
  //         context, MaterialPageRoute(builder: (context) => HomePage()));
  //   }
  // }

  // @override
  // void initState() {
  //   super.initState();
  //   checkUser();
  // }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          decoration: const BoxDecoration(color: Colors.white),
          child: SafeArea(
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 100,
                      ),
                      Image.asset("./assets/images/fingerprint.png"),
                      const Text("Login",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                          )),
                      Column(
                        children: [
                          TextFormField(
                            validator: (value) {
                              return validateEmail(email: value ?? "");
                            },
                            controller: _emailTextController,
                            decoration: const InputDecoration(
                              hintText: "Enter your email id",
                              label: Text("Email"),
                            ),
                          ),
                          TextFormField(
                            validator: (value) {
                              return validatePassword(password: value ?? "");
                            },
                            controller: _passwordTextController,
                            obscureText: !passwordVisible,
                            decoration: InputDecoration(
                                hintText: "Enter your Password",
                                label: const Text("password"),
                                suffixIcon: InkWell(
                                  child: Icon(passwordVisible
                                      ? Icons.visibility_off
                                      : Icons.visibility),
                                  onTap: () {
                                    setState(() {
                                      passwordVisible = !passwordVisible;
                                    });
                                  },
                                )),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: ElevatedButton(
                            onPressed: () async {
                              if (_formKey.currentState != null &&
                                  _formKey.currentState!.validate()) {
                                // print(_emailTextController.text);
                                // print(_passwordTextController.text);

                                try {
                                  User? user =
                                      await FireAuth.signInUsingEmailPassword(
                                          email: _emailTextController.text,
                                          password:
                                              _passwordTextController.text,
                                          context: context);

                                  if (user != null) {
                                    Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => HomePage()),
                                        (route) => false);
                                  }
                                } catch (e) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text(e.toString())));
                                }
                              }
                            },
                            child: const Text(
                              "Submit",
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                                primary: const Color(0xff6C63FF))),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
