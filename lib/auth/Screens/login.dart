import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:junc_app/auth/AuthProvider/auth.dart';
import 'package:junc_app/auth/Screens/authscreen.dart';
import 'package:provider/provider.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class Login extends StatefulWidget {
  static const String idScreen = "Login";
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isLoading = false;

  _signIn(String email, String password) async {
    var prov = Provider.of<AuthProvider>(context, listen: false);

    setState(() {
      isLoading = true;
    });
    try {
      await prov.signIn(email, password, context);
    } catch (e) {
      EasyLoading.showError(
          'Something has occured, please verify the information you taped');
    }

    setState(() {
      isLoading = false;
    });
  }

  bool showpass = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var prov = Provider.of<AuthProvider>(context, listen: false);
    return Scaffold(
        appBar: AppBar(),
        body: Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  style: TextStyle(
                    fontSize: 13,
                    fontFamily: "Tajawal",
                    fontWeight: FontWeight.w400,
                  ),
                  "E-mail",
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Color(0xffE4E9F2), width: 1.5),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                            color: Color(0xffE4E9F2), width: 1.5),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: const BorderSide(
                            color: Color(0xffE4E9F2), width: 1.5),
                      ),
                      hintText: "xyz123@gmail.com",
                      hintStyle: const TextStyle(
                        color: Color(0xff8F9BB3),
                        fontSize: 15,
                        fontFamily: "Tajawal",
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                Text(
                  style: TextStyle(
                    fontSize: 13,
                    fontFamily: "Tajawal",
                    fontWeight: FontWeight.w400,
                  ),
                  "Password",
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: 56,
                    child: TextField(
                      controller: passwordController,
                      obscureText: showpass,
                      enableSuggestions: false,
                      autocorrect: false,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              showpass = !showpass;
                            });
                          },
                          child: Icon(
                            showpass ? Icons.visibility : Icons.visibility_off,
                            color: const Color(0xff8F9BB3),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: Color(0xffE4E9F2), width: 1.5),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                              color: Color(0xffE4E9F2), width: 1.5),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: const BorderSide(
                              color: Color(0xffE4E9F2), width: 1.5),
                        ),
                        hintText: ". . . . . . . .",
                        hintStyle: const TextStyle(
                          color: Color(0xff8F9BB3),
                          fontSize: 18,
                          fontFamily: "Tajawal",
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                isLoading
                    ? CircularProgressIndicator()
                    : Center(
                        child: InkWell(
                          onTap: () async {
                            await _signIn(
                                emailController.text, passwordController.text);
                          },
                          child: Container(
                              width: 318,
                              height: 60,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                color: const Color(0xffA80D2B),
                              ),
                              child: const Center(
                                child: Text(
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: "Tajawal",
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xffffffff),
                                  ),
                                  "Login",
                                ),
                              )),
                        ),
                      ),
                Row(
                  children: [
                    Text("You don't have an account ? "),
                    TextButton(
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (_) => AuthScreen()));
                        },
                        child: Text('Join us'))
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
