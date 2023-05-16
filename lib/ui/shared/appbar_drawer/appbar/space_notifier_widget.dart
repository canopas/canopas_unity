import 'package:flutter/material.dart';

import 'package:projectunity/data/provider/user_data.dart';

import '../../../../data/model/space/space.dart';

class SpaceNotifierWidget extends InheritedNotifier<UserManager> {
  const SpaceNotifierWidget(
      {super.key, required UserManager notifier, required Widget child})
      : super(notifier: notifier, child: child);

  static Space of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<SpaceNotifierWidget>()!
        .notifier!
        .currentSpace!;
  }

  @override
  bool updateShouldNotify(covariant InheritedNotifier<UserManager> oldWidget) {
    return notifier!.currentSpace != oldWidget.notifier!.currentSpace;
  }
}
