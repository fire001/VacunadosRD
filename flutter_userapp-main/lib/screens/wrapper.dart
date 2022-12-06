import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_userapp/screens/Authentication/authentication.dart';
import 'package:flutter_userapp/screens/qrscreen.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);

    if (user != null) {
      return Qrscreen();
    } else {
      return Authentication();
  }
  }
}
