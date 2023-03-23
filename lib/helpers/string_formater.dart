String getValue(Map<String, dynamic> map) {
  // Check if the map contains only one key-value pair
  if (map.length == 1) {
    // If it does, return the value of the only key-value pair
    return map.values.first.toString();
  }

  // If the map contains multiple key-value pairs, return an error message
  return "Map contains multiple key-value pairs. Key must be specified.";
}
