import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';

import 'Models/chat.dart';
import 'auth/AuthProvider/auth.dart';

class Pending extends StatefulWidget {
  const Pending({super.key});

  @override
  State<Pending> createState() => _PendingState();
}

class _PendingState extends State<Pending> {
  TextEditingController emailController = TextEditingController();
  bool isLoading=false;
  List<Chat> chats=[];
  @override
  Widget build(BuildContext context) {
    var prov = Provider.of<AuthProvider>(context, listen: false);
    var size = MediaQuery.of(context).size;
    double widthSize = MediaQuery.of(context).size.width;
    double heightSize = MediaQuery.of(context).size.height;
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
                    icon: Transform.rotate(
                        angle: -45 * 3.1415926535 / 180,
                        child: const Icon(Icons.send,
                            color: Colors.grey)),
                    label: const Text(
                      'Email',
                      style:
                      TextStyle(color:  Colors.grey),
                    ))
              ],
            ),
          ),
        ),
      ),
      body: isLoading?
      const Center(
        child: CircularProgressIndicator(),
      ):
          Column(
            children: [
              Expanded(
                  child: ListView.separated(
                  separatorBuilder: (context, index) =>  Center(
                    child: Container(
                      height: 1,
                      width: widthSize-60,
                      color: Colors.grey,
                    ),
                  ),
                  itemCount: 2,
                    itemBuilder:(context, index) =>
                        Padding(
                            padding: EdgeInsets.all(20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 30,
                                  width: 30,
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(50),
                                      child: Image.asset('assets/Frame 61.png')

                                  ),
                                ),
                                const SizedBox(width: 20,),
                                Column(
                                  children:const [
                                    Text(
                                      "a.boukhatem98@gmail.com",
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(height: 10,),
                                    Text("User Email")
                                  ],
                                )
                              ],
                            ),
                              InkWell(
                                onTap: (){

                                },
                                child: const Icon(
                                  Icons.delete_forever_outlined,
                                  color: Colors.black,
                                ),
                              )
                             ],),
                        )
              ))
            ],
          )

    );
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
}