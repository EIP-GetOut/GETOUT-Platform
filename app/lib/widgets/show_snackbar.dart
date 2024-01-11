import 'package:flutter/material.dart';

void showSnackBar(final BuildContext context, final String message) {
  final snackBar = SnackBar(
      backgroundColor: Theme.of(context).colorScheme.error,
      content: Text(message,
          style: Theme.of(context).textTheme.displaySmall));
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
