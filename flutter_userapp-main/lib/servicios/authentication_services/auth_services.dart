// ignore_for_file: unused_import

import 'dart:async';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:uuid/uuid.dart';

class AuthServices with ChangeNotifier {
  bool _isLoading = false;
  late String _errorMessage;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  File? file;
  UploadTask? task;
  Future register(
    String email,
    String password,
  ) async {
    try {
      setLoading(true);
      UserCredential authResult =
          await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = authResult.user;
      setLoading(false);
      return user;
    } on SocketException {
      setLoading(false);
      setMessage("No hay conexion a internet");
    } catch (e) {
      setLoading(false);
      print(e);
      //setMessage(e.message.toString());
    }
    notifyListeners();
  }

  Future login(String email, String password) async {
    setLoading(true);
    try {
      UserCredential authResult = await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = authResult.user;
      setLoading(false);
      return user;
    } on SocketException {
      setLoading(false);

      setMessage("No hay conexion a internet");
    } catch (e) {
      setLoading(false);
      print(e);
      //setMessage(null);
    }
    notifyListeners();
  }

  Future logout() async {
    await firebaseAuth.signOut();
  }

  void setLoading(val) {
    _isLoading = val;
    notifyListeners();
  }

  void setMessage(message) {
    _errorMessage = message;
    notifyListeners();
  }

  Stream<User?> get user => firebaseAuth.authStateChanges();
}


