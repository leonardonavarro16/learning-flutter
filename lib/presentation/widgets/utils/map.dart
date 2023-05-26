class MapUtils {
  static Map<String, dynamic> formatAsFormDataMap(
    Map<String, dynamic> nestedMap, {
    String prefix = '',
  }) {
    Map<String, dynamic> flattenedMap = {};

    nestedMap.forEach((key, value) {
      if (value is Map<String, dynamic>) {
        String newPrefix = (prefix.isEmpty) ? key : '$prefix[$key]';
        flattenedMap.addAll(formatAsFormDataMap(value, prefix: newPrefix));
      } else {
        String newKey = (prefix.isEmpty) ? key : '$prefix[$key]';
        flattenedMap[newKey] = value;
      }
    });

    return flattenedMap;
  }

  static Map<String, dynamic> removeKeysAndGetRemoved(
    Map<String, dynamic> originalMap,
    List<String> keysToRemove,
  ) {
    Map<String, dynamic> removedMap = {};

    for (var key in keysToRemove) {
      if (originalMap.containsKey(key)) {
        removedMap[key] = originalMap[key];
        originalMap.remove(key);
      }
    }
    return removedMap;
  }

  static Map<String, String> convertMapToStringValues(
    Map<String, dynamic> inputMap,
  ) {
    return inputMap.map((key, value) {
      return MapEntry(key, value.toString());
    });
  }
}
