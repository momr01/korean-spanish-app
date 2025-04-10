import 'package:flutter/material.dart';

void showSnackBar(
  BuildContext context,
  String text,
) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
  // SnackbarGlobal.show(text);
}

String capitalizeFirstLetter(String text) {
  List<String> listOfWords = text.split(" ");
  String capitalized = "";

  for (var word in listOfWords) {
    if (word.isNotEmpty) {
      capitalized +=
          '${word[0].toUpperCase()}${word.substring(1).toLowerCase()} ';
    }
  }
  return capitalized.trim();
}
