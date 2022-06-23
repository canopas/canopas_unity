import 'package:flutter/material.dart';

import '../configs/colors.dart';

class kCircularProgressIndicator extends StatelessWidget {
  const kCircularProgressIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: CircularProgressIndicator(
          color: AppColors.primaryBlue,
        ),
      ),
    );
  }
}
