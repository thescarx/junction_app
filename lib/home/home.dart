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

  // final List<Widget> screens = const [
  //   UserHome(),
  //   Pending(),
  //   Profil(),
  //   Settings()
  // ];

  final PageStorageBucket Bucket = PageStorageBucket();
  Widget currentScrteen = const Profil();

  @override
  Widget build(BuildContext context) {
    var prov = Provider.of<AuthProvider>(context, listen: false);
    return Scaffold(
      body: PageStorage(
        bucket: Bucket,
        child: currentScrteen,
      ),
      bottomNavigationBar: BottomAppBar(
        height: 60,
        notchMargin: 0,
        // elevation: 30,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            MaterialButton(
              // minWidth: 40,
              onPressed: () {
                setState(() {
                  currentScrteen = const UserHome();
                  CurrentTab = 0;
                });
              },
              child: Container(
                width: 60,
                height: 90,
                color: CurrentTab == 0
                    ? Color.fromARGB(255, 114, 88, 219)
                    : Colors.white,
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
                            color:
                                CurrentTab == 0 ? Colors.white : Colors.black),
                        "Chat",
                      ),
                  ],
                ),
              ),
            ),
            MaterialButton(
              // minWidth: 40,
              onPressed: () {
                setState(() {
                  currentScrteen = const Pending();
                  CurrentTab = 1;
                });
              },
              child: Container(
                width: 60,
                height: 90,
                color: CurrentTab == 1
                    ? Color.fromARGB(255, 114, 88, 219)
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
                            color:
                                CurrentTab == 1 ? Colors.white : Colors.black),
                        "History",
                      ),
                  ],
                ),
              ),
            ),
            MaterialButton(
              // minWidth: 40,
              onPressed: () {
                setState(() {
                  currentScrteen = const Profil();
                  CurrentTab = 2;
                });
              },
              child: Container(
                width: 60,
                height: 90,
                color: CurrentTab == 2
                    ? Color.fromARGB(255, 114, 88, 219)
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
                            color:
                                CurrentTab == 2 ? Colors.white : Colors.black),
                        "Profil",
                      ),
                  ],
                ),
              ),
            ),
            MaterialButton(
              // minWidth: 40,
              onPressed: () {
                setState(() {
                  currentScrteen = const Settings();
                  CurrentTab = 3;
                });
              },
              child: Container(
                width: 60,
                height: 90,
                color: CurrentTab == 3
                    ? Color.fromARGB(255, 114, 88, 219)
                    : Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.settings_outlined,
                      color: CurrentTab == 3
                          ? const Color(0xffCCCCD0)
                          : Colors.black,
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
                            color:
                                CurrentTab == 3 ? Colors.white : Colors.black),
                        "Settings",
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
