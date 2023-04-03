const int kRoleTypeAdmin = 1;
const int kRoleTypeEmployee = 2;
const int kRoleTypeHR = 3;

enum UserSpaceStatus { unDefined, create, join }

Map<UserSpaceStatus, int> spaceStatusMap = Map.unmodifiable({
  UserSpaceStatus.unDefined: 0,
  UserSpaceStatus.create: 1,
  UserSpaceStatus.join: 2
});
