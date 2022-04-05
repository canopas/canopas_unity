import 'package:flutter/material.dart';



class LeaveScreen extends StatelessWidget {
  const LeaveScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Padding(
        padding:  EdgeInsets.fromLTRB(30, 50, 20, 0),
        child: Text(
          'Hey! You have 10 leaves in your account ',
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 30,
              color: Colors.grey,
              fontWeight: FontWeight.w500),
        ),
    ));
  }
}
