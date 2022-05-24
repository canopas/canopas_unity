import 'package:flutter/material.dart';
import 'package:projectunity/Navigation%20/app_state_manager.dart';
import 'package:projectunity/di/service_locator.dart';
import 'package:projectunity/user/user_manager.dart';

class LeaveScreen extends StatefulWidget {
  LeaveScreen({Key? key}) : super(key: key);

  @override
  _LeaveScreenState createState() => _LeaveScreenState();
}

class _LeaveScreenState extends State<LeaveScreen> {
  final UserManager _userManager = getIt<UserManager>();
  final _stateManager = getIt<AppStateManager>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.fromLTRB(30, 50, 20, 0),
      child: Column(
        children: [
          Text(
            'Hi  ${_userManager.getUserFullName() ?? ''} !',
            style: const TextStyle(
                fontSize: 30, color: Colors.black, fontWeight: FontWeight.w500),
          ),
          const Text(
            'View your  ',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 30, color: Colors.grey, fontWeight: FontWeight.w500),
          ),
          OutlinedButton(
              onPressed: () => _stateManager.onTapForUserAllLeaves(),
              child: const Text('All Leaves',
                  style: TextStyle(color: Colors.blueGrey, fontSize: 20)),
              style: ElevatedButton.styleFrom(
                  shadowColor: Colors.blueGrey[100],
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  padding: const EdgeInsets.all(10))),
          OutlinedButton(
              onPressed: () => _stateManager.onTapForUserUpComingLeaves(),
              child: const Text('Upcoming leaves',
                  style: TextStyle(color: Colors.blueGrey, fontSize: 20)),
              style: ElevatedButton.styleFrom(
                  shadowColor: Colors.blueGrey[100],
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  padding: const EdgeInsets.all(10))),
          OutlinedButton(
              onPressed: () => _stateManager.onTapForTeamLeaves(),
              child: const Text('Team Leaves',
                  style: TextStyle(color: Colors.blueGrey, fontSize: 20)),
              style: ElevatedButton.styleFrom(
                  shadowColor: Colors.blueGrey[100],
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  padding: const EdgeInsets.all(10))),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  style: ButtonStyle(
                    padding:
                        MaterialStateProperty.all(const EdgeInsets.all(10)),
                    backgroundColor: MaterialStateProperty.all(Colors.blueGrey),
                  ),
                  onPressed: () => _stateManager.onTapOfLeaveRequest(),
                  child: const Text(
                    'Apply for Leaves',
                    style: TextStyle(fontSize: 20),
                  )),
            ),
          )
        ],
      ),
    ));
  }
}
