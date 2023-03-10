import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
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
        title: const Text('Sign-UP'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            style: TextStyle(
              fontSize: 13,
              fontFamily: "Tajawal",
              fontWeight: FontWeight.w400,
            ),
            "Full Name",
          ),
          TextField(
            controller: nameController,
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
              hintText: "xyz123@gmail.com",
              hintStyle: const TextStyle(
                color: Color(0xff8F9BB3),
                fontSize: 15,
                fontFamily: "Tajawal",
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const Text(
            style: TextStyle(
              fontSize: 13,
              fontFamily: "Tajawal",
              fontWeight: FontWeight.w400,
            ),
            "E-mail",
          ),
          TextField(
            controller: emailController,
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
              hintText: "xyz123@gmail.com",
              hintStyle: const TextStyle(
                color: Color(0xff8F9BB3),
                fontSize: 15,
                fontFamily: "Tajawal",
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const Text(
            style: TextStyle(
              fontSize: 13,
              fontFamily: "Tajawal",
              fontWeight: FontWeight.w400,
            ),
            "Birth Date",
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
