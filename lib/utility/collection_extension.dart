extension IterableExtension<V> on Iterable<V> {
  Map<K, List<V>> groupBy<K>(K Function(V) keyFunction) => fold(
        <K, List<V>>{},
        (Map<K, List<V>> map, V element) =>
            map..putIfAbsent(keyFunction(element), () => <V>[]).add(element),
      );
}
