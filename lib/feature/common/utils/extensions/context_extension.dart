import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

extension DisplaySnackbar on BuildContext {
  Future<void> displaySnackbar(String? snackbarMessage,
      {SnackBarAction? action}) async {
    if (snackbarMessage != null ||
        snackbarMessage?.isNotEmpty == true && mounted) {
      try {
        ScaffoldMessenger.of(this).hideCurrentSnackBar();
        ScaffoldMessenger.of(this).showSnackBar(
          SnackBar(
            content: Text(snackbarMessage ?? ""),
            action: action,
          ),
        );
      } catch (e) {
        if (kDebugMode) log(e.toString());
      }
    }
  }
}
