mixin InputValidationMixin {
  bool validInputLength(String? name) => (name?.trim() ?? "").length >= 4;

  bool validDomain(String? email) =>
      email != null && email.length >= 4 && email.contains('.') ||
      email!.isEmpty;

  bool validEmail(String? email) =>
      email != null &&
      email.length >= 4 &&
      email.contains('@') &&
      email.contains('.');
}
