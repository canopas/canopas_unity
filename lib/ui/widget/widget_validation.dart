import 'package:flutter/cupertino.dart';

class ValidateWidget extends StatelessWidget {
  final bool isValid;
  final Widget child;
  final Widget unValidWidget;

  const ValidateWidget(
      {Key? key,
      required this.isValid,
      required this.child,
      this.unValidWidget = const SizedBox()})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isValid) {
      return child;
    } else {
      return unValidWidget;
    }
  }
}
