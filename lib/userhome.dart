import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:junc_app/home/home.dart';
import 'package:provider/provider.dart';

import 'auth/AuthProvider/auth.dart';

class UserHome extends StatefulWidget {
  const UserHome({super.key});

  @override
  State<UserHome> createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
  TextEditingController emailController = TextEditingController();
  bool isLoading = false;
  _loadData() async {
    var prov = Provider.of<AuthProvider>(context, listen: false);
    setState(() {
      isLoading = true;
    });
    try {
      await prov.getUserData(prov.auth.currentUser!.uid);
    } catch (e) {
      EasyLoading.showError('Error has occured when loading user data');
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadData();
  }

  Future<void> _showMyDialog() async {
    var size = MediaQuery.of(context).size;
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          insetPadding: const EdgeInsets.all(20),
          contentPadding: EdgeInsets.zero,
          // clipBehavior: Clip.antiAliasWithSaveLayer,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          content: Builder(builder: (context) {
            return SizedBox(
              height: 200,
              width: 500,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text(
                      'This text comes from chatgpt',
                      overflow: TextOverflow.fade,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextField(
                      controller: emailController,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          prefixIcon: Icon(
                            Icons.email_outlined,
                            color: Colors.black,
                          ),
                          hintText: 'E-mail'),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          child: Container(
                            height: 40,
                            width: size.width * 0.35,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                    width: 2,
                                    color: const Color.fromARGB(
                                        255, 114, 88, 219))),
                            child: const Center(
                                child: Text(
                              'Cancel',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 114, 88, 219),
                                  fontWeight: FontWeight.bold),
                            )),
                          ),
                        ),
                        InkWell(
                          child: Container(
                            height: 40,
                            width: size.width * 0.35,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: const Color.fromARGB(255, 114, 88, 219)),
                            child: const Center(
                                child: Text(
                              'Send',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            )),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            );
          }),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var prov = Provider.of<AuthProvider>(context, listen: false);
    var size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(120),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 12),
            child: SizedBox(
              height: 80,
              width: size.width - 32,
              child: Row(
                children: [
                  SizedBox(
                    height: 60,
                    width: 50,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: prov.user!.pic!.isEmpty
                          ? Image.asset('assets/user-avatar.png')
                          : Image.network(prov.user!.pic!),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        prov.user!.email!,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      InkWell(
                          onTap: () {},
                          child: const Text(
                            'View profile',
                            style: TextStyle(
                                color: Color.fromARGB(255, 114, 88, 219)),
                          )),
                    ],
                  ),
                  const Spacer(),
                  TextButton.icon(
                      onPressed: () {
                        _showMyDialog();
                      },
                      icon: const Icon(
                        Icons.send_outlined,
                        color: Color.fromARGB(255, 114, 88, 219),
                      ),
                      label: const Text(
                        'Email',
                        style:
                            TextStyle(color: Color.fromARGB(255, 114, 88, 219)),
                      ))
                ],
              ),
            ),
          ),
        ),
        body: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                children: [],
              ));
  }
}
