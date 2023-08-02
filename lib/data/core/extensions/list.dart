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
