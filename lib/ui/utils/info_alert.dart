import 'package:flutter/material.dart';
import 'package:nes_ui/nes_ui.dart';

showInfoDialog<T>(
  BuildContext context, {
  required String message,
  Function()? onBackButtonPressed,
}) =>
    NesDialog.show<void>(
      context: context,
      builder: (_) => Text(message),
    );
