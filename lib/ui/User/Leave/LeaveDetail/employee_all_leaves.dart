import 'package:flutter/cupertino.dart';

class EmployeeAllLeaves extends StatefulWidget {
  const EmployeeAllLeaves({Key? key}) : super(key: key);

  @override
  _EmployeeAllLeavesState createState() => _EmployeeAllLeavesState();
}

class _EmployeeAllLeavesState extends State<EmployeeAllLeaves> {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('all leaves'));
  }
}
