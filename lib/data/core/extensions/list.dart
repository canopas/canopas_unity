extension Iterables<E> on Iterable<E> {
  Map<K, List<E>> groupBy<K>(K Function(E) keyFunction) => fold(
      <K, List<E>>{},
      (Map<K, List<E>> map, E element) =>
          map..putIfAbsent(keyFunction(element), () => <E>[]).add(element));
}

extension IterableListMergeExtension<T> on Iterable<List<T>> {
  List<T> merge() {
    List<T> mergedList = [];
    for (var list in this) {
      mergedList.addAll(list);
    }
    return mergedList;
  }
}

extension ConvertListToMapExtension<T> on List<T> {
  Map<DateTime, List<T>> groupByMonth(DateTime Function(T element) extractor) {
    sort((a, b) => extractor(b).compareTo(extractor(a)));
    return groupBy(
        (item) => DateTime(extractor(item).year, extractor(item).month));
  }

  void removeWhereAndAdd(T? newElement, bool Function(T element) where) {
    removeWhere(where);
    if (newElement != null) {
      add(newElement);
    }
  }
}
