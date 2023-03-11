import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/svg.dart';
import 'package:junc_app/auth/AuthProvider/auth.dart';
import 'package:provider/provider.dart';

class AuthScreen extends StatefulWidget {
  static const String idScreen = "AuthScreen";
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool isLoading = false;
  _signUp(String fullName, String birthdate, String email, String password,
      BuildContext context) async {
    var prov = Provider.of<AuthProvider>(context, listen: false);

    setState(() {
      isLoading = true;
    });
    try {
      await prov.signUpWithEmailAndPassword(
          nameController.text,
          birthdateController.text,
          emailController.text,
          passwordController.text,
          context);
    } catch (e) {
      EasyLoading.showError('Some error has occured');
    }
    setState(() {
      isLoading = false;
    });
  }

  bool showpass = true;
  bool showpass2 = true;
  DateTime? assuranceExp;
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController birthdateController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordCController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/logo.svg',
              width: 125,
              height: 142,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 20, 100, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Register',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    'create your account in Kyochat to reply with professional emails',
                    style: TextStyle(color: Color.fromARGB(255, 60, 60, 60)),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: TextField(
                controller: nameController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                        color: Color.fromARGB(255, 154, 155, 157), width: 1.5),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: const BorderSide(
                        color: Color.fromARGB(255, 154, 155, 157), width: 1.5),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: const BorderSide(
                        color: Color.fromARGB(255, 154, 155, 157), width: 1.5),
                  ),
                  hintText: "Full Name",
                  prefixIcon: const Icon(
                    Icons.person_2_outlined,
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
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: TextField(
                controller: emailController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                        color: Color.fromARGB(255, 154, 155, 157), width: 1.5),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: const BorderSide(
                        color: Color.fromARGB(255, 154, 155, 157), width: 1.5),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: const BorderSide(
                        color: Color.fromARGB(255, 154, 155, 157), width: 1.5),
                  ),
                  hintText: "Email address",
                  prefixIcon: const Icon(
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
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: TextField(
                readOnly: true,
                controller: birthdateController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                        color: Color.fromARGB(255, 154, 155, 157), width: 1.5),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: const BorderSide(
                        color: Color.fromARGB(255, 154, 155, 157), width: 1.5),
                  ),
                  prefixIcon: const Icon(
                    Icons.calendar_month_outlined,
                    color: Color.fromARGB(255, 113, 111, 111),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: const BorderSide(
                        color: Color.fromARGB(255, 154, 155, 157), width: 1.5),
                  ),
                  hintText: "Birthdate",
                  hintStyle: const TextStyle(
                    fontSize: 15,
                  ),
                ),
                onTap: () async {
                  assuranceExp = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1950),
                    lastDate: DateTime(222222),
                  );
                  if (assuranceExp != null) {
                    setState(() {
                      birthdateController.text =
                          "${assuranceExp!.day}-${assuranceExp!.month}-${assuranceExp!.year}";
                    });
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Color.fromARGB(255, 114, 88, 219),
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
                    hintText: "Password",
                    prefixIcon: const Icon(
                      Icons.lock_outline_rounded,
                      color: Color.fromARGB(255, 113, 111, 111),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: SizedBox(
                height: 56,
                child: TextField(
                  controller: passwordCController,
                  obscureText: showpass2,
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
                            showpass2 = !showpass2;
                          });
                        },
                        child: Text(
                          showpass2 ? 'SHOW' : 'HIDE',
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Color.fromARGB(255, 114, 88, 219),
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
                    hintText: "Confirm your password",
                    prefixIcon: const Icon(
                      Icons.lock_outline_rounded,
                      color: Color.fromARGB(255, 113, 111, 111),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  Flexible(
                    child: TextButton(
                        onPressed: () {},
                        child: const Text(
                          'By signing up you agree to our term of use and privacy notice',
                          style: TextStyle(
                              color: Color.fromARGB(255, 114, 88, 219)),
                        )),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
            isLoading
                ? const CircularProgressIndicator(
                    color : const Color.fromARGB(255, 114, 88, 219))
                : InkWell(
                    onTap: () async {
                      await _signUp(
                          nameController.text,
                          birthdateController.text,
                          emailController.text,
                          passwordController.text,
                          context);
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
                            "Register",
                          ),
                        )),
                  ),
            if(!isLoading)Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("You don't have an account ? "),
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'Login',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Color.fromARGB(255, 114, 88, 219)),
                      ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
