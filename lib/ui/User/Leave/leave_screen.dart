import 'package:flutter/material.dart';

import 'leave_detail_screen.dart';

class LeaveScreen extends StatelessWidget {
  const LeaveScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 50, 20, 0),
        child: Center(
          child: Column(
            children: [
              const Text(
                'Hey! Your upcoming leaves are ',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 30,
                    color: Colors.grey,
                    fontWeight: FontWeight.w500),
              ),
              OutlinedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LeaveDetailScreen()));
                  },
                  child: const Text(
                    'View All',
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
