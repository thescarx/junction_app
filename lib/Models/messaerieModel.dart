import 'package:flutter/cupertino.dart';

class MsgModel{
String text;
DateTime date;
bool isSentByMe;
MsgModel(@required this.text,@required this.date,@required this.isSentByMe);
}