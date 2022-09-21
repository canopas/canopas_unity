import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projectunity/configs/text_style.dart';
import 'package:projectunity/core/utils/const/image_constant.dart';

class EmptyScreen extends StatelessWidget {
  final String message;
  const EmptyScreen({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Image(
            image: AssetImage(emptyLeaveStateImage),
            height: 100,
            width: 100,
          ),
          const SizedBox(
            height: 20,
          ),
          Text(message,
            textAlign: TextAlign.center,
            style: AppTextStyle.secondarySubtitle500,),
        ],
      ),
    );
  }
}
