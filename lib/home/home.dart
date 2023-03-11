import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:junc_app/auth/AuthProvider/auth.dart';
import 'package:junc_app/home/profil.dart';
import 'package:junc_app/pending.dart';
import 'package:junc_app/settings.dart';
import 'package:junc_app/userhome.dart';
import 'package:provider/provider.dart';

class HomeUser extends StatefulWidget {
  static const String idScreen = 'home';
  const HomeUser({Key? key}) : super(key: key);

  @override
  State<HomeUser> createState() => _HomeUserState();
}

class _HomeUserState extends State<HomeUser> {
  int CurrentTab = 0;
  Color mainColor = const Color.fromARGB(1, 120, 121, 241);

  final bool isKeyboardVisible = false;
  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }



  final PageStorageBucket Bucket = PageStorageBucket();
  Widget currentScrteen = const UserHome();

  @override
  Widget build(BuildContext context) {
    double widthSize = MediaQuery.of(context).size.width;
    double heightSize = MediaQuery.of(context).size.height;
    var prov = Provider.of<AuthProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: PageStorage(
        bucket: Bucket,
        child: currentScrteen,
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.transparent,
        height: 100,
        notchMargin: 0,
        elevation: 50,
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Container(
            width: widthSize-10,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50), color: Colors.white),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                InkWell(
                  onTap: (){
                    setState(() {
                      currentScrteen = const UserHome();
                      CurrentTab = 0;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.horizontal(
                        left: Radius.circular(50),
                      ),
                      // border: const Border.fromBorderSide(BorderSide.none),
                      color: CurrentTab == 0
                          ? const Color.fromARGB(255, 114, 88, 219)
                          : Colors.white,
                    ),
                    width: (widthSize-10)/4,
                    height: 100,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.chat_bubble_outline,
                          color: CurrentTab == 0 ? Colors.white : Colors.black,
                        ),
                        if (CurrentTab == 0)
                          const SizedBox(
                            height: 5,
                          ),
                        if (CurrentTab == 0)
                          Text(
                            style: TextStyle(
                                fontSize: 12,
                                fontFamily: "Tajawal",
                                fontWeight: FontWeight.w400,
                                color: CurrentTab == 0
                                    ? Colors.white
                                    : Colors.black),
                            "Chat",
                          ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  // minWidth: 40,
                  onTap: () {
                    setState(() {
                      currentScrteen = const Pending();
                      CurrentTab = 1;
                    });
                  },
                  child: Container(
                    width: (widthSize-10)/4,
                    height: 90,
                    color: CurrentTab == 1
                        ? const Color.fromARGB(255, 114, 88, 219)
                        : Colors.white,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.timer_outlined,
                          color: CurrentTab == 1 ? Colors.white : Colors.black,
                        ),
                        if (CurrentTab == 1)
                          const SizedBox(
                            height: 5,
                          ),
                        if (CurrentTab == 1)
                          Text(
                            style: TextStyle(
                                fontSize: 12,
                                fontFamily: "Tajawal",
                                fontWeight: FontWeight.w400,
                                color: CurrentTab == 1
                                    ? Colors.white
                                    : Colors.black),
                            "History",
                          ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  // minWidth: 40,
                  onTap: () {
                    setState(() {
                      currentScrteen = const Profil();
                      CurrentTab = 2;
                    });
                  },
                  child: Container(
                    width: (widthSize-10)/4,
                    height: 90,
                    color: CurrentTab == 2
                        ? const Color.fromARGB(255, 114, 88, 219)
                        : Colors.white,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.person_outline,
                          color: CurrentTab == 2 ? Colors.white : Colors.black,
                        ),
                        if (CurrentTab == 2)
                          const SizedBox(
                            height: 5,
                          ),
                        if (CurrentTab == 2)
                          Text(
                            style: TextStyle(
                                fontSize: 12,
                                fontFamily: "Tajawal",
                                fontWeight: FontWeight.w400,
                                color: CurrentTab == 2
                                    ? Colors.white
                                    : Colors.black),
                            "Profil",
                          ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  // minWidth: 40,
                  onTap: () {
                    setState(() {
                      currentScrteen = const Settings();
                      CurrentTab = 3;
                    });
                  },
                  child: Container(
                    width: (widthSize-10)/4,
                    height: 100,
                    decoration: BoxDecoration(
                      color: CurrentTab == 3
                          ? const Color.fromARGB(255, 114, 88, 219)
                          : Colors.white,
                      borderRadius: const BorderRadius.horizontal(
                          right: Radius.circular(50)),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.settings_outlined,
                          color: CurrentTab == 3 ? Colors.white : Colors.black,
                        ),
                        if (CurrentTab == 3)
                          const SizedBox(
                            height: 5,
                          ),
                        if (CurrentTab == 3)
                          Text(
                            style: TextStyle(
                                fontSize: 12,
                                fontFamily: "Tajawal",
                                fontWeight: FontWeight.w400,
                                color: CurrentTab == 3
                                    ? Colors.white
                                    : Colors.black),
                            "Settings",
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  
}
