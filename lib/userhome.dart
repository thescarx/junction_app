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

  @override
  Widget build(BuildContext context) {
    var prov = Provider.of<AuthProvider>(context, listen: false);
    var size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(120),
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
                  SizedBox(
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
                      SizedBox(
                        height: 5,
                      ),
                      InkWell(
                          onTap: () {},
                          child: Text(
                            'View profile',
                            style: TextStyle(
                                color: Color.fromARGB(255, 114, 88, 219)),
                          )),
                    ],
                  ),
                  Spacer(),
                  TextButton.icon(
                      onPressed: () {},
                      icon: Icon(
                        Icons.send_outlined,
                        color: Color.fromARGB(255, 114, 88, 219),
                      ),
                      label: Text(
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
