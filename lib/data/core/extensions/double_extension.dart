extension DoubleExtension on double {
  dynamic fixedAt(int l) =>
      (toInt() == this) ? toInt() : double.parse(toStringAsFixed(l));
}
