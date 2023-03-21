import 'package:flutter/material.dart';
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
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(5),
          elevation: 2,
          fixedSize: Size(MediaQuery.of(context).size.width * 0.85, 50),
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                  image: DecorationImage(
                      fit: BoxFit.cover, image: AssetImage(image)),
                  shape: BoxShape.circle),
            ),
            Text(title),
            const SizedBox(
                width: 40,
                child: Center(child: Icon(Icons.arrow_forward_rounded)))
          ],
        ));
  }
}
