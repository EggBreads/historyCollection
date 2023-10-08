import 'package:flutter/material.dart';

void showFirebaseErrorSnack(BuildContext context, String msg) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      // action: SnackBarAction(
      //   label: "Close",
      //   onPressed: () {},
      // ),
      showCloseIcon: true,
      content: Text((msg)),
    ),
  );
}
