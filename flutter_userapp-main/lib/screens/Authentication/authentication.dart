import 'package:flutter/material.dart';
import 'package:flutter_userapp/screens/Authentication/login.dart';
import 'package:flutter_userapp/screens/Authentication/register.dart';

//autenticacion
class Authentication extends StatefulWidget {
  @override
  _AuthenticationState createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {
  bool isToggle = false;
  void toggleScreen() {
    setState(() {
      isToggle = !isToggle;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isToggle) {
      return Register(toggleScreen: toggleScreen);
    } else {
      return Login(toggleScreen: toggleScreen);
    }
  }
}
