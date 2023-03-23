import 'dart:developer';

String getValue(dynamic data, String message) {
  if (data.length == 0) {
    return message.toString();
  }
  if (data.length == 1) {
    // If it does, return the value of the only key-value pair
    List value = data.values.first;

    return value[0];
  }

  // Check if the map contains only one key-value pair

  // If the map contains multiple key-value pairs, return an error message
  return "Map contains multiple key-value pairs. Key must be specified.";
}
