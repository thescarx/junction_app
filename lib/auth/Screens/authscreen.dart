import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:junc_app/auth/AuthProvider/auth.dart';
import 'package:provider/provider.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var prov = Provider.of<AuthProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign-UP'),
      ),
      body: Column(
        children: [
          TextField(
            controller: emailController,
            decoration: InputDecoration(hintText: 'Email'),
          ),
          TextField(
            controller: passwordController,
            decoration: InputDecoration(hintText: 'password'),
          ),
          TextButton.icon(
              onPressed: () async {
                await prov.signUpWithEmailAndPassword(
                    emailController.text, passwordController.text, context);
              },
              icon: Icon(Icons.sign_language_sharp),
              label: Text('SignUp'))
        ],
      ),
    );
  }
}
