class ImageStoragePath{
  static String spaceLogoPath({required String spaceId}) => "images/$spaceId/space-logo";
  static String membersProfilePath({required String spaceId, required String uid}) => "images/$spaceId/$uid/profile";
}