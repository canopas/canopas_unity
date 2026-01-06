class ImageStoragePath {
  static String spaceLogoPath({required String spaceId}) =>
      "images/$spaceId/space-logo";

  static String membersProfilePath({
    required String spaceId,
    required String uid,
  }) => "images/$spaceId/$uid/profile";

  static String formHeaderImage({
    required String spaceId,
    required String formId,
  }) => "images/$spaceId/forms/$formId/header-image";

  static String formFieldImage({
    required String spaceId,
    required String formId,
    required String fieldId,
  }) => "images/$spaceId/forms/$formId/fields/$fieldId/image";

  static String memberFieldDocUploadPath({
    required String spaceId,
    required String uid,
    required String formId,
    required String fieldId,
  }) => "images/$spaceId/forms/$formId/responses/$uid/$fieldId/image";
}
