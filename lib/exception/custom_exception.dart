
class CustomException implements Exception {
  String errorMessage;

  CustomException(this.errorMessage);

  @override
  String toString() {
    return errorMessage;
  }
}
