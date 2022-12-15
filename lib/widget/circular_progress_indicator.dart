import 'package:flutter/material.dart';
import '../configs/colors.dart';

class kCircularProgressIndicator extends StatelessWidget {
  final double size;
  const kCircularProgressIndicator({Key? key, this.size = 38}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Center(
      child: SizedBox(
        height: size,
        width: size,
        child:  CircularProgressIndicator(
          strokeWidth: size/9,
          color: AppColors.primaryBlue,
        ),
      ),
    );
  }
}
