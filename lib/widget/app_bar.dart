import 'package:flutter/material.dart';

Widget customAppBar(String title) {
  return AppBar(
    backgroundColor: Colors.transparent,
    elevation: 0,
    leading: IconButton(
      icon: const Icon(
        Icons.menu,
        size: 34,
      ),
      onPressed: () {
        //action for search icon button
      },
    ),
    title: Center(child: Text(title)),
    actions: <Widget>[
      IconButton(
        icon: const Icon(
          Icons.add,
          size: 34,
        ),
        onPressed: () {
          //action for search icon button
        },
      ),
    ],
  );
}
