import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

class HeaderTitle extends StatelessWidget {
  var animation = const AlwaysStoppedAnimation(0.6);

  HeaderTitle({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentTween(
              begin: Alignment.bottomCenter, end: Alignment.bottomCenter)
          .evaluate(animation),
      child: Padding(
        padding: const EdgeInsets.only(top: 30.0),
        child: Text(
          AppLocalizations.of(context).admin_addMember_addMember_tag,
          style: TextStyle(
              fontSize: Tween<double>(begin: 40, end: 20).evaluate(animation),
              color: Colors.white,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
