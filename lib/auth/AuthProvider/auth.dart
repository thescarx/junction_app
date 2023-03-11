import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:junc_app/Models/user.dart';
import 'package:junc_app/home/home.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../Screens/emailverification.dart';
import '../Screens/login.dart';

class AuthProvider extends ChangeNotifier {
  appUser? user;
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  Future<void> signUpWithEmailAndPassword(String fullName, String birthdate,
      String email, String password, BuildContext context) async {
    if (email.isEmpty || password.isEmpty) {
      Fluttertoast.showToast(msg: 'You need to fill all the required fields');
    } else {
      try {
        final credential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
          email: email,
          password: password,
        )
            .then((value) {
          registerUser(value.user!.uid, email, fullName, birthdate);

          value.user!.sendEmailVerification();
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => EmailVerification()));
        });
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          print('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          print('The account already exists for that email.');
        }
      } catch (e) {
        print(e);
      }
    }
  }

  Future<void> getUserData(String uid) async {
    firestore.collection('users').doc(uid).snapshots().listen((event) {
      user = appUser(
          uid: event['uid'],
          fullName: event['fullName'],
          email: event['email'],
          pic: event['pic'],
          birthdate: event['birthdate']);
    });
  }

  Future<void> registerUser(
      String uid, String email, String fullName, String birthdate) async {
    if (email.isEmpty || fullName.isEmpty || birthdate.isEmpty) {
      Fluttertoast.showToast(
          msg:
              'Please, fill all the required fields in order to complete the registration');
    } else {
      try {
        firestore.collection('users').doc(uid).set({
          'uid': uid,
          'fullName': fullName,
          'email': email,
          'birthdate': birthdate,
          'pic': ''
        });
      } catch (e) {
        rethrow;
      }
    }
  }

  Future<void> signIn(
      String email, String password, BuildContext context) async {
    if (email.isEmpty || password.isEmpty) {
      Fluttertoast.showToast(msg: 'You need to fill all the required fields');
    } else {
      try {
        final credential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);
        if (credential.user!.emailVerified) {
          // ignore: use_build_context_synchronously
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (_) => HomeUser()));
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          print('No user found for that email.');
        } else if (e.code == 'wrong-password') {
          print('Wrong password provided for that user.');
        }
      }
    }
  }
}
