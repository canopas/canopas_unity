import 'package:flutter/material.dart';
import 'package:projectunity/Widget/user_widget.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 50, 15, 0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Icon(
                Icons.account_circle_rounded,
                size: 50,
              ),
              IconButton(
                icon: const Icon(Icons.search),
                iconSize: 30,
                onPressed: () {},
              )
            ],
          ),
        ),
        const Expanded(
          child: Text(
            'Hi,Sneha Sanghani',
            style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.normal),
          ),
        ),
        const Expanded(
          child: Text(
              'Know your colleague,find their contact information and get in touch with him/her ',
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.grey,
                  fontSize: 20)),
        ),
        Expanded(
          flex: 8,
          child: ListView.builder(
              itemCount: 10,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return UserWidget();
              }),
        ),
      ]),
    );
  }
}
