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

  bool showpass = false;
  DateTime? assuranceExp;
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController birthdateController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
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
          SizedBox(
            height: 80,
            child: TextField(
              readOnly: true,
              controller: birthdateController,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: Color(0xffE4E9F2), width: 1.5),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide:
                      const BorderSide(color: Color(0xffE4E9F2), width: 1.5),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide:
                      const BorderSide(color: Color(0xffE4E9F2), width: 1.5),
                ),
                hintText: "DD/MM/YYYY",
                hintStyle: const TextStyle(
                  color: Color(0xff8F9BB3),
                  fontSize: 15,
                  fontFamily: "Tajawal",
                  fontWeight: FontWeight.w700,
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
          const Text(
            style: TextStyle(
              fontSize: 13,
              fontFamily: "Tajawal",
              fontWeight: FontWeight.w400,
            ),
            "Mot de passe",
          ),
          SizedBox(
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
                  borderSide:
                      const BorderSide(color: Color(0xffE4E9F2), width: 1.5),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide:
                      const BorderSide(color: Color(0xffE4E9F2), width: 1.5),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide:
                      const BorderSide(color: Color(0xffE4E9F2), width: 1.5),
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
          isLoading
              ? CircularProgressIndicator()
              : TextButton.icon(
                  onPressed: () async {
                    await _signUp(nameController.text, birthdateController.text,
                        emailController.text, passwordController.text, context);
                  },
                  icon: const Icon(Icons.sign_language_sharp),
                  label: const Text('SignUp'))
        ],
      ),
    );
  }
}
