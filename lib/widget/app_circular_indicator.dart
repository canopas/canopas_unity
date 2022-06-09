import 'package:flutter/material.dart';
import 'package:projectunity/configs/colors.dart';

class AppCircularIndicator extends StatelessWidget {
  const AppCircularIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        color: AppColors.peachColor,
      ),
    );
  }
}
