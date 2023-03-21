import 'package:flutter/material.dart';
import 'package:projectunity/data/model/employee/employee.dart';

class CreateOrgScreen extends StatefulWidget {
  final Employee employee;

  const CreateOrgScreen({Key? key, required this.employee}) : super(key: key);

  @override
  State<CreateOrgScreen> createState() => _CreateOrgScreenState();
}

class _CreateOrgScreenState extends State<CreateOrgScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: const [],
      ),
    );
  }
}
