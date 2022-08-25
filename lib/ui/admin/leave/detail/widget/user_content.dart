import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projectunity/configs/text_style.dart';
import 'package:projectunity/widget/user_profile_image.dart';

import '../../../../../configs/colors.dart';
import '../../../../../configs/font_size.dart';
import '../../../../../model/employee/employee.dart';

class UserContent extends StatelessWidget {
  Employee employee;

  UserContent({Key? key, required this.employee}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
      child: Row(
        children: [
          ImageProfile(iconSize: 50, imageUrl: employee.imageUrl),
          const SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildUserName(name: employee.name),
              const SizedBox(
                height: 3,
              ),
              _buildDesignation(designation: employee.designation)
            ],
          ),
        ],
      ),
    );
  }

  Text _buildDesignation({required String designation}) {
    return Text(
      designation,
      style: AppTextStyle.secondarySubtitle500
    );
  }
}

Text _buildUserName({required String name}) {
  return Text(
    name,
    style: AppTextStyle.secondarySubtitle500,
  );
}
