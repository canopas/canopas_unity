import 'package:flutter/material.dart';

import 'package:projectunity/data/provider/user_state.dart';

import '../../../../data/model/space/space.dart';

class SpaceNotifierWidget extends InheritedNotifier<UserStateNotifier> {
  const SpaceNotifierWidget(
      {super.key, required UserStateNotifier notifier, required Widget child})
      : super(notifier: notifier, child: child);

  static Space? of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<SpaceNotifierWidget>()!
        .notifier!
        .currentSpace;
  }

  @override
  bool updateShouldNotify(
      covariant InheritedNotifier<UserStateNotifier> oldWidget) {
    return notifier!.currentSpace != oldWidget.notifier!.currentSpace;
  }
}
