import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_userapp/screens/wrapper.dart';
import 'package:flutter_userapp/servicios/authentication_services/auth_services.dart';
import 'package:provider/provider.dart';

void main() => runApp(Userapp());

class Userapp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _init = Firebase.initializeApp();
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: FutureBuilder(
          future: _init,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return ErrorWidget();
            } else if (snapshot.hasData) {
              return MultiProvider(
                providers: [
                  ChangeNotifierProvider<AuthServices>.value(
                      value: AuthServices()),
                  StreamProvider<User?>.value(
                    value: AuthServices().user,
                    initialData: null,
                  )
                ],
                child: new MaterialApp(
                  theme: ThemeData(
                    primarySwatch: Colors.blue,
                  ),
                  debugShowCheckedModeBanner: false,
                  home: Wrapper(),
                ),
              );
            } else {
              return Loading();
            }
          },
        ),
      ),
    );
  }
}

class ErrorWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [Icon(Icons.error), Text("Algo anda mal")],
        ),
      ),
    );
  }
}

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
