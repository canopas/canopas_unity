import 'package:flutter/material.dart';

import '../../../../../configs/colors.dart';
import '../../../../configs/text_style.dart';

class OverlapProfile extends StatelessWidget {
  const OverlapProfile({
    Key? key,
    required this.length,
  }) : super(key: key);

  final int length;

  @override
  Widget build(BuildContext context) {
    final int num;
    const overlap = 25;
    if (length == 0) {
      return const Icon(
        Icons.account_circle_rounded,
        size: 50,
      );
    }
    length <= 3 ? num = length : num = 3;
    List<Widget> stackLayers = List<Widget>.generate(num, (index) {
      return Padding(
          padding: EdgeInsets.fromLTRB(index.toDouble() * overlap, 0, 0, 0),
          child: const CircleAvatar(
            backgroundColor: Colors.white,
            radius: 25,
            child: CircleAvatar(
              radius: 20,
              child: ClipOval(
                child: Image(
                  image: AssetImage('assets/images/angelaYu.jpeg'),
                ),
              ),
            ),
          ));
    });
    if (length > 3) {
      stackLayers.add(
        Padding(
          padding: const EdgeInsets.fromLTRB(75.0, 5, 0, 0),
          child: CircleAvatar(
            radius: 20,
            backgroundColor: AppColors.primaryBlue,
            child: Text(
              '+${(length - num)}..',
              style: AppTextStyle.subtitleText.copyWith(color: Colors.white),
            ),
          ),
        ),
      );
    }
    return Stack(
      children: stackLayers,
    );
  }
}
