import 'package:flutter/material.dart';

class NotificationIcon extends StatelessWidget {
  const NotificationIcon({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        IconButton(
          color: Colors.white,
          icon: const Icon(
            Icons.notifications,
            size: 30,
          ),
          onPressed: () {},
        ),
        const Positioned(
            top: 10,
            right: 10,
            child: Icon(
              Icons.brightness_1,
              size: 10,
              color: Colors.red,
            ))
      ],
    );
  }
}
