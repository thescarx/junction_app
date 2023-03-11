import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:junc_app/home/home.dart';
import 'package:provider/provider.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

import 'Models/messaerieModel.dart';
import 'auth/AuthProvider/auth.dart';
import 'auth/Screens/emailConnection.dart';

class UserHome extends StatefulWidget {
  const UserHome({super.key});

  @override
  State<UserHome> createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
  TextEditingController emailController = TextEditingController();
  TextEditingController textChat = TextEditingController();
  bool isLoading = false;
  List<Message> msgs=[];
  final String apiKey = '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';
  final String endpoint = 'https://api.chatgpt.com/generate';
  SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;
  String _lastWords = '';



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadData();
    _initSpeech();
  }



  @override
  Widget build(BuildContext context) {
    var prov = Provider.of<AuthProvider>(context, listen: false);
    var size = MediaQuery.of(context).size;
    double widthSize = MediaQuery.of(context).size.width;
    double heightSize = MediaQuery.of(context).size.height;
    return Scaffold(

        appBar:PreferredSize(
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
                      child:
                           Image.asset('assets/user-avatar.png')
                          ,
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
                        if(prov.user!.isConnected){
                          _showMyDialog();
                        }
                        else{
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const EmailConnection(),
                          ));
                        }
                        
                      },
                      icon: Transform.rotate(
                        angle: -45 * 3.1415926535 / 180,
                        child: const Icon(Icons.send,
                            color: Color.fromARGB(255, 114, 88, 219))),
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
                children: [
                  Expanded(
                      child:
                      GroupedListView<Message,DateTime>(
                        padding: const EdgeInsets.all(8),
                        useStickyGroupSeparators: true,
                        floatingHeader: true,
                        itemComparator: (element1, element2) => _compareDates(element1.date, element2.date),
                        elements: msgs,
                        groupBy: (message) =>DateTime(
                            message.date.year,
                            message.date.month,
                            message.date.day
                        ),
                        groupHeaderBuilder: (Message message)=>const SizedBox(
                          height: 20,),
                        itemBuilder: (context,Message message)=>Align(
                            alignment: message.isSentByMe
                                ?Alignment.centerRight
                                :Alignment.centerLeft,
                            child: message.isSentByMe
                                ?Row(
                              mainAxisAlignment:  MainAxisAlignment.end,
                                  children: [
                                    // SizedBox(
                                    //   height: 20,
                                    //   width: 20,
                                    //   child: ClipRRect(
                                    //     borderRadius: BorderRadius.circular(50),
                                    //     child: Image.asset('assets/user-avatar.png')
                                    //
                                    //   ),
                                    // ),
                                    // const SizedBox(width: 10,),
                                    Container(
                                    decoration: const BoxDecoration(
                                      color:  Color.fromARGB(255, 114, 88, 219),
                                      borderRadius: BorderRadius.only(topLeft: Radius.circular(15.0),bottomLeft: Radius.circular(15.0)),
                                    ),

                                    child: Padding(
                                      padding: const EdgeInsets.all(12),
                                      child: Text(message.text,style: const TextStyle(color: Colors.white,fontFamily: 'Tajawal'),),
                                    )),
                                  ],
                                )
                                :Container(
                                decoration:  BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: const BorderRadius.only(topRight: Radius.circular(15.0),bottomRight: Radius.circular(15.0),),
                                  border: Border.all(
                                    color: Color.fromARGB(255, 114, 88, 219), // set the color of the border
                                    width: 1.0, // set the width of the border
                                  ),

                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(12),
                                  child: Text(message.text.trim(),style:const TextStyle(fontFamily: 'Tajawal',color: Color.fromARGB(255, 114, 88, 219)),),
                                ))
                        ),
                        separator:const SizedBox(height: 10,),

                      )),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: widthSize - 72,
                          height: 56,
                          child: TextField(
                            controller: textChat,
                            decoration: InputDecoration(
                              suffixIcon: Padding(
                                padding: const EdgeInsets.only(bottom: 5.0),
                                child: InkWell(
                                  onTap: (){
                                    setState(() {
                                      msgs.add(Message(textChat.text, DateTime.now(), true));
                                    });
                                    _generateTextFromGpt(textChat.text);
                                  },
                                  child: Transform.rotate(
                                    angle: -45 * 3.1415926535 / 180,
                                      child: const Icon(Icons.send,size: 30,)),
                                ),
                              ),
                              filled: true,
                              fillColor: Colors.white,
                              floatingLabelBehavior:
                              FloatingLabelBehavior.always,
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color:  Color.fromARGB(255, 114, 88, 219),
                                    width: 1.5),
                                borderRadius:
                                BorderRadius.circular(12.0),
                              ),
                              border: OutlineInputBorder(
                                borderRadius:
                                BorderRadius.circular(12),
                                borderSide: const BorderSide(
                                    color:  Color.fromARGB(255, 114, 88, 219),
                                    width: 1.5),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius:
                                BorderRadius.circular(12.0),
                                borderSide: const BorderSide(
                                    color:  Colors.blueGrey,
                                    width: 1.5),
                              ),

                            ),
                          ),
                        ),
                        InkWell(
                          onTap: _speechToText.isNotListening ? _startListening : _stopListening,
                          child: SizedBox(
                            width: 50,
                            height: 56,
                            child: Icon(
                              _speechToText.isNotListening ? Icons.mic_off : Icons.mic,
                                color: _speechToText.isNotListening ? Colors.black :  const Color.fromARGB(255, 114, 88, 219),
                              size: 35,
                            )
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ));
  }
  void _initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
    setState(() {});
  }

  void _startListening() async {
    await _speechToText.listen(onResult: _onSpeechResult);
    setState(() {});
  }
  void _stopListening() async {
    await _speechToText.stop();
    setState(() {});
  }


  void _onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      textChat.text = result.recognizedWords;
    });
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
  _compareDates(DateTime date1,date2){
    if (date1.isBefore(date2)) {
      return -1;
    } else if (date1.isAfter(date2)) {
      return 1;
    } else {
      return 0;
    }
  }
   _generateTextFromGpt(String prompt) async {
    final response = await http.post(
      Uri.parse('https://api.openai.com/v1/engines/text-davinci-002/completions'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $apiKey',
      },
      body: jsonEncode(<String, dynamic>{
        'prompt': prompt,
      }),
    );

    if (response.statusCode == 200) {
      final responseJson = jsonDecode(response.body);
      final text = responseJson['choices'][0]['text'] as String;
      setState(() {
        msgs.add(Message(text,DateTime.now(),false));
      });
    } else {
      print(response.reasonPhrase);
      throw Exception('Failed to generate text from GPT API');
    }
  }
}
