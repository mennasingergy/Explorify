import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterPage extends StatefulWidget {
  final VoidCallback showLoginPage;
  const RegisterPage({Key? key, required this.showLoginPage}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmpasswordController = TextEditingController();

  Future signUp() async {
    if (passwordConfirmed()) {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
    } else {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
                backgroundColor: Color.fromARGB(255, 182, 142, 86),
                title: Text("Incorrect Password!"),
                content: Text(
                    "The password you entered is incorrect. Please try again"),
                actions: [
                  FloatingActionButton(
                      backgroundColor: Color.fromARGB(207, 188, 106, 29),
                      child: Text("OK"),
                      onPressed: () {
                        Navigator.pop(context);
                      })
                ]);
          });

      // showDialog(
      // context: context,
      // builder: (context) {
      //   return AlertDialog(
      //     content: Text(e.message.toString()),
      //   );
      // });
    }
  }

  bool passwordConfirmed() {
    if (_passwordController.text.trim() ==
        _confirmpasswordController.text.trim()) {
      return true;
    }
    return false;
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
            Text("Register below!", style: GoogleFonts.bebasNeue(fontSize: 54)),
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
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white24,
                    border: Border.all(color: Colors.white12),
                    borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: TextField(
                      controller: _confirmpasswordController,
                      obscureText: true,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Confirm Password')),
                ),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: GestureDetector(
                onTap: signUp,
                child: Container(
                  padding: EdgeInsets.all(25.0),
                  decoration: BoxDecoration(
                      color: Color.fromARGB(209, 237, 139, 10),
                      borderRadius: BorderRadius.circular(12)),
                  child: Center(
                      child: Text('Sign Up',
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
              Text('I am a member!',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold)),
              GestureDetector(
                onTap: widget.showLoginPage,
                child: Text(' Login now',
                    style: TextStyle(
                        color: Colors.blue, fontWeight: FontWeight.bold)),
              )
            ])
          ]),
        ),
      )),
    );
  }
}
