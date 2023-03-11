import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../AuthProvider/auth.dart';
import 'authscreen.dart';

class EmailConnection extends StatefulWidget {
  const EmailConnection({Key? key}) : super(key: key);

  @override
  State<EmailConnection> createState() => _EmailConnectionState();
}

class _EmailConnectionState extends State<EmailConnection> {


  bool showpass = true;
  bool isLoading = false;
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
          body: SingleChildScrollView(
            child: Column(
              children: [
                SvgPicture.asset(
                  'assets/logo.svg',
                  width: 125,
                  height: 142,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 50, 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'connect your email',
                        style:
                        TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Please add you email information to send and receive emails.',
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
                      hintText: "Email address",
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
                              showpass ? 'SHOW' : 'HIDE',
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
                        hintText: "Email password",
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
                        // await _signIn(
                        //     emailController.text, passwordController.text);
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
                              "Confirm",
                            ),
                          )),
                    ),
                  ),
                ),

              ],
            ),
          ),
        ));
  }
}
