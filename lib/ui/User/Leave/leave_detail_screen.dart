import 'package:flutter/material.dart';

class LeaveDetailScreen extends StatefulWidget {
  const LeaveDetailScreen({Key? key}) : super(key: key);

  @override
  _LeaveDetailScreenState createState() => _LeaveDetailScreenState();
}

class _LeaveDetailScreenState extends State<LeaveDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(body: Center(child: Text('All Leaves'))),
    );
  }
}
