import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../models/custom_error.dart';

void errorDialog(BuildContext context, CustomError e) {
  if (kIsWeb) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(e.code),
          actions: [
            CupertinoDialogAction(
              child: const Text('OK'),
              onPressed: () => Navigator.pop(context),
            ),
          ],
          content: Text('${e.plugin}\n${e.message}'),
        );
      },
    );
  } else if (Platform.isIOS) {
    showCupertinoDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text(e.code),
          actions: [
            CupertinoDialogAction(
              child: const Text('OK'),
              onPressed: () => Navigator.pop(context),
            ),
          ],
          content: Text('${e.plugin}\n${e.message}'),
        );
      },
    );
  } else {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(e.code),
          actions: [
            CupertinoDialogAction(
              child: const Text('OK'),
              onPressed: () => Navigator.pop(context),
            ),
          ],
          content: Text('${e.plugin}\n${e.message}'),
        );
      },
    );
  }
}
