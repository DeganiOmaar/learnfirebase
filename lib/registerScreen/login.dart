// ignore_for_file: unused_local_variable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:learnfirebase/registerScreen/register.dart';
import 'package:learnfirebase/shared/customtfield.dart';
import 'package:learnfirebase/shared/registerbutton.dart';
import 'package:learnfirebase/userscreen.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLoading = false;
  login() async {
    setState(() {
      isLoading = true;
    });
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
      if (!mounted) return;
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const UserScreen()));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        QuickAlert.show(
          context: context,
          type: QuickAlertType.error,
          title: 'Oops...',
          text: 'user not found!',
        );
      } else if (e.code == 'wrong-password') {
        QuickAlert.show(
          context: context,
          type: QuickAlertType.error,
          title: 'Oops...',
          text: 'wrong password!',
        );
      } else {
        QuickAlert.show(
          context: context,
          type: QuickAlertType.error,
          title: 'Oops...',
          text: 'Check Your Email or Password!',
        );
      }
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 25.0),
          child: Form(
            key: formstate,
            child: ListView(
              children: [
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Welcome Back!',
                  style: TextStyle(
                      fontSize: 30,
                      color: Colors.black87,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 3,
                ),
                const Text(
                  'Login to your account now',
                  style: TextStyle(fontSize: 18, color: Colors.black45),
                ),
                const SizedBox(
                  height: 40,
                ),
                CustomTfield(
                  isPassword: false,
                  text: 'Email',
                  icon: Icons.email_outlined,
                  myController: emailController,
                  validator: (email) {
                    return email!.contains(RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+"))
                        ? null
                        : "Enter a valid email";
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTfield(
                  isPassword: true,
                  text: 'Password',
                  icon: Icons.visibility_off_outlined,
                  myController: passwordController,
                  validator: (value) {
                    return value!.isEmpty ? "Check Password" : null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () {},
                      child: const Text(
                        'Forget Password?',
                        style: TextStyle(color: Colors.black87, fontSize: 16),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (formstate.currentState!.validate()) {
                        await login();
                      } else {
                        QuickAlert.show(
                          context: context,
                          type: QuickAlertType.error,
                          title: 'Error',
                          text: 'Enter Your Email & Password',
                        );
                      }
                    },
                    style: ButtonStyle(
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.indigo),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)))),
                    child: isLoading
                        ? LoadingAnimationWidget.staggeredDotsWave(
                            color: Colors.white,
                            size: 50,
                          )
                        : const Text(
                            'Login',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const SizedBox(
                  child: Row(
                    children: [
                      Expanded(
                          child: Divider(
                        thickness: 0.7,
                      )),
                      Text(
                        "     OR     ",
                        style: TextStyle(color: Colors.black45),
                      ),
                      Expanded(
                          child: Divider(
                        thickness: 0.7,
                      )),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const RegisterButton(
                    text: 'Google', link: 'assets/icons/google.svg'),
                const SizedBox(
                  height: 20,
                ),
                const RegisterButton(
                    text: 'Google', link: 'assets/icons/facebook.svg'),
                const SizedBox(
                  height: 20,
                ),
                const RegisterButton(
                    text: 'Google', link: 'assets/icons/apple.svg'),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Do not have an account? ',
                      style: TextStyle(fontSize: 16, color: Colors.black54),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Register(),
                          ),
                        );
                        emailController.clear();
                        passwordController.clear();
                      },
                      child: const Text(
                        'Register',
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            fontSize: 16,
                            color: Colors.indigo,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
