extension NullCheckString on String? {
  bool get isNotNullOrEmpty => !(this == null || this!.trim().isEmpty);
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}
