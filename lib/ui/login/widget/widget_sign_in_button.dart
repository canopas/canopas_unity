import 'package:flutter/material.dart';

import '../../../configs/colors.dart';
import '../../../utils/const/image_constant.dart';

class SignInButton extends StatelessWidget {
   SignInButton({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: MediaQuery.of(context).size.width / 1.5,
        height: 50,
        child: TextButton(
            style: ButtonStyle(
              side: MaterialStateProperty.all(
                const BorderSide(color: AppColors.peachColor, width: 2),
              ),
              backgroundColor: MaterialStateProperty.all(
                AppColors.creamColor.withOpacity(0.2),
              ),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
              ),
              overlayColor: MaterialStateProperty.all(
                  AppColors.peachColor.withOpacity(0.2)),
            ),
             onPressed: onPressed,
             child: Row(children: [
               Image.asset(
                 googleLogoImage,
                 height: 40,
               ),
               const Expanded(
                 child: Text(
                   'Sign in with Google',
                   textAlign: TextAlign.center,
                   style: TextStyle(color: Colors.black54, fontSize: 20),
                ),
              )
            ])));
  }
}
