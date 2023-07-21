import 'package:flutter/material.dart';

import '../../common.dart';

extension ContextExtention on BuildContext {
  AppLocalizations get localization => AppLocalizations.of(this)!;

  void showSnackBar({required String message}) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(this)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }
}
