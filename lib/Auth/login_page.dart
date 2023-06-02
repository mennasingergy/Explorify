// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'forgot_pw_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LoginPage extends StatefulWidget {
  final VoidCallback showRegisterPage;
  const LoginPage({Key? key, required this.showRegisterPage}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
//text controllers

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

//signIn method

  Future signIn() async {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(
              child: CircularProgressIndicator(color: Colors.amber));
        });

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim());
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        wrongEmailMesage();
      } else if (e.code == 'wrong-password') {
        wrongPasswordMesage();
      }
    }
  }

  void wrongEmailMesage() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              backgroundColor: Color.fromARGB(255, 182, 142, 86),
              title: Text("Incorrect Email"),
              actions: [
                FloatingActionButton(
                    backgroundColor: Color.fromARGB(207, 188, 106, 29),
                    child: Text("OK"),
                    onPressed: () {
                      Navigator.pop(context);
                    })
              ]);
        });
  }

  void wrongPasswordMesage() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              backgroundColor: Color.fromARGB(255, 182, 142, 86),
              title: Text("Incorrect Password"),
              actions: [
                FloatingActionButton(
                    backgroundColor: Color.fromARGB(207, 188, 106, 29),
                    child: Text("OK"),
                    onPressed: () {
                      Navigator.pop(context);
                    })
              ]);
        });
  }

  void showController(BuildContext myContext) async {
    {
      Navigator.of(myContext).pushNamed('/categoriesRoute');
    }
    try {
      final userCredential = await FirebaseAuth.instance.signInAnonymously();
    } on FirebaseAuthException catch (e) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
                backgroundColor: Color.fromARGB(255, 182, 142, 86),
                title: Text(e.code),
                actions: [
                  FloatingActionButton(
                      backgroundColor: Color.fromARGB(207, 188, 106, 29),
                      child: Text("OK"),
                      onPressed: () {
                        Navigator.pop(context);
                      })
                ]);
          });
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(210, 214, 132, 17),
      body: SafeArea(
          child: Center(
        child: SingleChildScrollView(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Icon(Icons.explore_rounded, size: 100),
            SizedBox(height: 75),
            Text("Welcome Back!", style: GoogleFonts.bebasNeue(fontSize: 54)),
            SizedBox(height: 50), //for space between widgets
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white24,
                    border: Border.all(color: Colors.white12),
                    borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                          border: InputBorder.none, hintText: 'Email')),
                ),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white24,
                    border: Border.all(color: Colors.white12),
                    borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: TextField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                          border: InputBorder.none, hintText: 'Password')),
                ),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.only(right: 25.0),
              child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return ForgotPasswordPage();
                    }));
                  },
                  child: Text("Forgot password?  ",
                      style: TextStyle(
                          color: Colors.blue, fontWeight: FontWeight.bold)),
                )
              ]),
            ),

            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: GestureDetector(
                onTap: signIn,
                child: Container(
                  padding: EdgeInsets.all(25.0),
                  decoration: BoxDecoration(
                      color: Color.fromARGB(209, 237, 139, 10),
                      borderRadius: BorderRadius.circular(12)),
                  child: Center(
                      child: Text('Sign In',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ))),
                ),
              ),
            ),
            SizedBox(height: 25),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text('Not a member?',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold)),
              GestureDetector(
                onTap: widget.showRegisterPage,
                child: Text(' Register now',
                    style: TextStyle(
                        color: Colors.blue, fontWeight: FontWeight.bold)),
              )
            ]),
            SizedBox(height: 20),
            GestureDetector(
              onTap: () => showController(context),
              child: Text(' Continue as a guest',
                  style: TextStyle(
                      color: Colors.blue, fontWeight: FontWeight.bold)),
            )
          ]),
        ),
      )),
    );
  }
}