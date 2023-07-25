import 'package:flutter/material.dart';

import 'package:projectunity/data/provider/user_status_notifier.dart';

import '../../../../data/model/space/space.dart';

class SpaceNotifierWidget extends InheritedNotifier<UserStatusNotifier> {
  const SpaceNotifierWidget(
      {super.key, required UserStatusNotifier notifier, required Widget child})
      : super(notifier: notifier, child: child);

  static Space? of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<SpaceNotifierWidget>()!
        .notifier!
        .currentSpace;
  }

  @override
  bool updateShouldNotify(
      covariant InheritedNotifier<UserStatusNotifier> oldWidget) {
    return notifier!.currentSpace != oldWidget.notifier!.currentSpace;
  }
}
