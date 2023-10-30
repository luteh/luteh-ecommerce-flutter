import 'dart:convert';

import 'package:crypto/crypto.dart';

extension StringExtention on String {
  String toSHA256() {
    var bytes = utf8.encode(this); // Convert input string to UTF-8 bytes
    var digest = sha256.convert(bytes); // Calculate SHA-256 hash
    return digest.toString(); // Convert the hash to a string representation
  }

  String capitalizeFirstLetter() {
    if (isEmpty) return this; // Handle empty string case.
    return this[0].toUpperCase() + substring(1);
  }
}
