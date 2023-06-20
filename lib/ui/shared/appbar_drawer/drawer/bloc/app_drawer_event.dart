import '../../../../../data/model/space/space.dart';

abstract class DrawerEvents {}

class FetchSpacesEvent extends DrawerEvents {}

class ChangeSpaceEvent extends DrawerEvents {
  final Space space;

  ChangeSpaceEvent(this.space);
}

class SignOutWithCurrentSpaceEvent extends DrawerEvents {}
