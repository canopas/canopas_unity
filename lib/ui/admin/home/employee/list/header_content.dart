import 'package:flutter/material.dart';
import 'package:projectunity/configs/font_size.dart';
import 'package:projectunity/configs/text_style.dart';
import 'package:projectunity/di/service_locator.dart';
import 'package:projectunity/widget/user_profile_image.dart';

import '../../../../../provider/user_data.dart';

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
                style: AppTextStyle.headerTextBold.copyWith(color: const Color(0xff000000))
              ),
              const Text(
                'Know your Team ',
                style: TextStyle(
                    color: Colors.black54,
                    letterSpacing: 0.1,
                    fontSize: subTitleTextSize),
              ),
            ],
          ),
          Align(
            alignment: Alignment.topRight,
              child: ImageProfile(
                iconSize: 50,
                imageUrl: _userManager.userImage,
              )),
        ],
      ),
    );
  }
}
