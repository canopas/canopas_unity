import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projectunity/di/service_locator.dart';

import '../../../../../user/user_manager.dart';

class HeaderContent extends StatelessWidget {
  HeaderContent({
    Key? key,
  }) : super(key: key);

  final UserManager _userManager = getIt<UserManager>();

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hi, ${_userManager.getUserName()}!',
                style: GoogleFonts.ibmPlexSans(
                    fontSize: 24,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                'Know your Team ',
                style: GoogleFonts.ibmPlexSans(
                    color: Colors.black54, letterSpacing: 0.1, fontSize: 17),
              ),
            ],
          ),
          Align(
            alignment: Alignment.topRight,
            child: _userManager.getUserImage() == null
                ? const Icon(
                    Icons.account_circle_rounded,
                    size: 70,
                  )
                : CircleAvatar(
                    radius: height / 100 * 3,
                    backgroundImage:
                        NetworkImage(_userManager.getUserImage()!)),
          ),
        ],
      ),
    );
  }
}
