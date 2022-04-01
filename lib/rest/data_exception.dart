class DataException implements Exception {
  final String message;

  DataException(this.message);

  @override
  String toString() {
    return message;
  }
}
