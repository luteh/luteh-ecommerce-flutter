mixin SerializeHelper {
  List<T> serializeList<T>(Object? json, T Function(dynamic) fromJson) =>
      (json as List<dynamic>?)?.map((e) => fromJson(e)).toList() ??
      List.empty();
}
