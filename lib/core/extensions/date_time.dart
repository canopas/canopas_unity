extension DateExtention on int {
  DateTime toDate() {
    return DateTime.fromMillisecondsSinceEpoch(this);
  }
}
