import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:junc_app/auth/AuthProvider/auth.dart';
import 'package:junc_app/auth/Screens/authscreen.dart';
import 'package:junc_app/auth/Screens/emailverification.dart';
import 'package:junc_app/auth/Screens/login.dart';
import 'package:junc_app/home/home.dart';
import 'package:provider/provider.dart';

import 'home/profil.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseAuth auth = FirebaseAuth.instance;
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => AuthProvider()),
  ], child: const MyApp()));
}
CollectionReference users = FirebaseFirestore.instance.collection('users');
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        builder: EasyLoading.init(),
        routes: {
          Login.idScreen: (context) => const Login(),
          AuthScreen.idScreen: (context) => const AuthScreen(),
          HomeUser.idScreen: (context) => const HomeUser(),
          EmailVerification.idScreen: (context) => const EmailVerification(),
          Profil.idScreen: (context) => const Profil(),
        },
        theme: ThemeData(
          fontFamily: 'Montserrat',
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue,
        ),
        home: FirebaseAuth.instance.currentUser == null
            ? const Login()
            : FirebaseAuth.instance.currentUser!.emailVerified
                ? const HomeUser()
                : const EmailVerification());
  }
}
