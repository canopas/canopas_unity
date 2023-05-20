import 'package:flutter/material.dart';
import 'package:projectunity/data/configs/text_style.dart';
import '../../../data/configs/colors.dart';

class SignInButton extends StatelessWidget {
  const SignInButton({
    Key? key,
    required this.onPressed,
    required this.title,
    required this.image,
  }) : super(key: key);

  final Function() onPressed;
  final String image;
  final String title;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.zero,
        fixedSize: Size(MediaQuery.of(context).size.width * 0.8, 50),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: AppColors.whiteColor),
                child: Image(
                    image: AssetImage(image),
                    fit: BoxFit.contain,
                    width: 35,
                    height: 35)),
            Flexible(
              child: Text(
                title,
                style: AppFontStyle.bodyLarge
                    .copyWith(color: AppColors.whiteColor),
                overflow: TextOverflow.clip,
              ),
            ),
            const SizedBox(width: 35),
          ],
        ),
      ),
    );
  }
}
