import 'package:explorify/Auth/login_page.dart';
import 'package:explorify/Intro/tabscontroller_screen.dart';
import 'package:flutter/material.dart';

import '../Intro/register_page.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  //initially show the login page
  bool showLoginPage = true;
  bool showTabController = false;

  void toggleScreens() {
    setState(() {
      showLoginPage = !showLoginPage;
      showTabController = !showTabController;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return LoginPage(showRegisterPage: toggleScreens);
    }
    return RegisterPage(showLoginPage: toggleScreens);
  }
}