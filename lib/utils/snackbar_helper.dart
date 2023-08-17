import 'package:flutter/material.dart';

void showErrorMessage(
  BuildContext context, {
  required String message,
  })
  {
    final snackBar = SnackBar(
      content: Text(
        message,
        style: TextStyle(color: Colors.white),),
      backgroundColor: Colors.red,);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }


void showSuccessMessage(
  BuildContext context, {
  required String message})
  {
    final snackBar = SnackBar(
      content: Text(message,
      style: TextStyle(color: const Color.fromARGB(255, 0, 23, 57)),),
      backgroundColor: const Color.fromARGB(255, 67, 212, 142),
      
      );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }