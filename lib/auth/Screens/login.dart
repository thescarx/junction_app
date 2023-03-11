import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:junc_app/auth/AuthProvider/auth.dart';
import 'package:junc_app/auth/Screens/authscreen.dart';
import 'package:provider/provider.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'forgetpassword.dart';

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
  bool isChecked = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var prov = Provider.of<AuthProvider>(context, listen: false);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: Scaffold(
          backgroundColor: Colors.white,
          body: Column(
            children: [
              SvgPicture.asset(
                'assets/logo.svg',
                width: 125,
                height: 142,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 20, 180, 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Login',
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Login with your account',
                      style: TextStyle(color: Color.fromARGB(255, 60, 60, 60)),
                    )
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                child: TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: Color.fromARGB(255, 154, 155, 157),
                          width: 1.5),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: const BorderSide(
                          color: Color.fromARGB(255, 154, 155, 157),
                          width: 1.5),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      borderSide: const BorderSide(
                          color: Color.fromARGB(255, 154, 155, 157),
                          width: 1.5),
                    ),
                    hintText: "xyz123@gmail.com",
                    prefixIcon: Icon(
                      Icons.email_outlined,
                      color: Color.fromARGB(255, 113, 111, 111),
                    ),
                    hintStyle: const TextStyle(
                      color: Color(0xff8F9BB3),
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
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
                      suffixIcon: Padding(
                        padding: const EdgeInsets.only(right: 5),
                        child: TextButton(
                          onPressed: () {
                            setState(() {
                              showpass = !showpass;
                            });
                          },
                          child: Text(
                            !showpass ? 'SHOW' : 'HIDE',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: const Color.fromARGB(255, 114, 88, 219),
                            ),
                          ),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Color.fromARGB(255, 154, 155, 157),
                            width: 1.5),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(
                            color: Color.fromARGB(255, 154, 155, 157),
                            width: 1.5),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: const BorderSide(
                            color: Color.fromARGB(255, 154, 155, 157),
                            width: 1.5),
                      ),
                      hintText: ". . . . . . . .",
                      prefixIcon: Icon(
                        Icons.lock_outline_rounded,
                        color: Color.fromARGB(255, 113, 111, 111),
                      ),
                      hintStyle: const TextStyle(
                        color: Color(0xff8F9BB3),
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Checkbox(
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          checkColor: Colors.white,
                          // fillColor: MaterialStateProperty.resolveWith(getColor),
                          value: isChecked,
                          onChanged: (bool? value) {
                            setState(() {
                              isChecked = value!;
                            });
                          },
                        ),
                        const Text(
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Color(0xff8F9BB3)),
                          "Remember me",
                        ),
                      ],
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => const ForgetPass(),
                        ));
                      },
                      child: const Text(
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Color(0xffA80D2B)),
                        "Forgot your password ?",
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 70,
              ),
              isLoading
                  ? const CircularProgressIndicator()
                  : Align(
                      alignment: Alignment.bottomCenter,
                      child: Center(
                        child: InkWell(
                          onTap: () async {
                            await _signIn(
                                emailController.text, passwordController.text);
                          },
                          child: Container(
                              width: size.width * 0.9,
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: const Color.fromARGB(255, 114, 88, 219),
                              ),
                              child: const Center(
                                child: Text(
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xffffffff),
                                  ),
                                  "Login",
                                ),
                              )),
                        ),
                      ),
                    ),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("You don't have an account ? "),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const AuthScreen()));
                        },
                        child: const Text(
                          'Join us',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: const Color.fromARGB(255, 114, 88, 219)),
                        ))
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
