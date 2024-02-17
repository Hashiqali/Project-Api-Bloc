import 'package:flutter/material.dart';

snakbar(context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    duration: const Duration(seconds: 1),
    behavior: SnackBarBehavior.floating,
    backgroundColor: const Color.fromARGB(255, 95, 94, 94),
    margin: const EdgeInsets.all(20),
    content: Text(
      text,
      textAlign: TextAlign.center,
      style: const TextStyle(color: Colors.white),
    ),
  ));
}
