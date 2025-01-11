import 'dart:convert';

class StringUtils {
  static String decodeVNString(String value) {
    List<int> bytes = latin1.encode(value);
    return utf8.decode(bytes);
  }
}