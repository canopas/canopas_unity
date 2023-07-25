extension NullCheckString on String? {
  bool get isNotNullOrEmpty => !(this == null || this!.trim().isEmpty);
}
