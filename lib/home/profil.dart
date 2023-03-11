import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:junc_app/auth/AuthProvider/auth.dart';
import 'package:provider/provider.dart';

class Profil extends StatefulWidget {
  static const String idScreen = "profil";

  const Profil({super.key});

  @override
  State<Profil> createState() => _ProfilState();
}

class _ProfilState extends State<Profil> {
  FilePickerResult? result;
  File? toDisplay;
  TextEditingController email = TextEditingController();
  TextEditingController date = TextEditingController();
  TextEditingController name = TextEditingController();
  DateTime? assuranceExp;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var prov = Provider.of<AuthProvider>(context, listen: false);
    email.text = prov.user!.email!;
    name.text = prov.user!.fullName!;
    date.text = prov.user!.birthdate!;
  }

  @override
  Widget build(BuildContext context) {
    var prov = Provider.of<AuthProvider>(context, listen: false);
    var size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: const Center(
            child: Text(
              'My Profil',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () async {
                      result = await FilePicker.platform.pickFiles(
                        allowMultiple: false,
                        type: FileType.custom,
                        allowedExtensions: ['jpg', 'pdf', 'png'],
                      );
                      setState(() {
                        if (result != null) {
                          result?.files.first.name;
                          toDisplay = File(result!.files.first.path!);
                        }
                      });
                    },
                    child: result == null
                        ? SizedBox(
                            height: 100,
                            width: 100,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: prov.user!.pic!.isEmpty
                                  ? Image.asset('assets/user-avatar.png')
                                  : Image.network(prov.user!.pic!),
                            ))
                        : SizedBox(
                            height: 100,
                            width: 100,
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: Image.file(toDisplay!))),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        prov.user!.fullName!,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(prov.user!.email!),
                      Text('Joined on : ${prov.user!.joinedDate!}')
                    ],
                  ),
                ],
              ),
              const Divider(
                height: 20,
                color: Color.fromARGB(255, 132, 131, 131),
              ),
              const Text(
                "Modify your information",
                style: TextStyle(
                  color: Color.fromARGB(255, 132, 131, 131),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                child: TextField(
                  controller: name,
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
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                child: TextField(
                  controller: email,
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
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: TextField(
                  readOnly: true,
                  controller: date,
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
                    prefixIcon: const Icon(
                      Icons.calendar_month_outlined,
                      color: Color.fromARGB(255, 113, 111, 111),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      borderSide: const BorderSide(
                          color: Color.fromARGB(255, 154, 155, 157),
                          width: 1.5),
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
                        date.text =
                            "${assuranceExp!.day}-${assuranceExp!.month}-${assuranceExp!.year}";
                      });
                    }
                  },
                ),
              ),
              const Text(
                'Birthday can only be modified one time, Be careful !',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 50,
              ),
              InkWell(
                onTap: () async {},
                child: Container(
                    width: size.width * 0.9,
                    height: 50,
                    decoration: BoxDecoration(
                      border: Border.all(
                          width: 3,
                          color: const Color.fromARGB(255, 114, 88, 219)),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: const Center(
                      child: Text(
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                        "Modify",
                      ),
                    )),
              ),
            ],
          ),
        ));
  }
}
