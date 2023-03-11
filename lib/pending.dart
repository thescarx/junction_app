import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class Pending extends StatefulWidget {
  const Pending({super.key});

  @override
  State<Pending> createState() => _PendingState();
}

class _PendingState extends State<Pending> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('Pending'),),
    );
  }
}