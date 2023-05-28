import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future passwordReset() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: _emailController.text.trim());
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
                backgroundColor: Color.fromARGB(255, 182, 142, 86),
                title: Text("Reset Password!"),
                content: Text("Password reset link sent! Check your email"),
                actions: [
                  FloatingActionButton(
                      backgroundColor: Color.fromARGB(207, 188, 106, 29),
                      child: Text("OK"),
                      onPressed: () {
                        Navigator.pop(context);
                      })
                ]);
          });
    } on FirebaseAuthException catch (e) {
      print(e);
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
                backgroundColor: Color.fromARGB(255, 182, 142, 86),
                title: Text("Incorrect Email"),
                content: Text(e.message.toString()),
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Color.fromARGB(210, 214, 132, 17), elevation: 0),
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Text(
            "Enter your email so we can send you a reset password link:",
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(height: 20),
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
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(12)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(226, 239, 137, 48)),
                          borderRadius: BorderRadius.circular(12)),
                      border: InputBorder.none,
                      hintText: 'Email',
                      fillColor: Colors.grey[200],
                      filled: true)),
            ),
          ),
        ),
        SizedBox(height: 20),
        MaterialButton(
            onPressed: passwordReset,
            child: Text("Reset Password"),
            color: Colors.orangeAccent)
      ]),
    );
  }
}
