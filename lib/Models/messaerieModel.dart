import 'package:flutter/cupertino.dart';

class Message{
String text;
DateTime date;
bool isSentByMe;
Message(@required this.text,@required this.date,@required this.isSentByMe);
}