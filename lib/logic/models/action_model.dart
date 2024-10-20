import 'package:flutter/material.dart';

class ActionHandler {
  final String? description; // What does this Action do?
  final VoidCallback? action; // The function for the Action.
  final Intent? intent; // The Intent for the Action.
  late final BuildContext context; // Necessary context for Action to act on.

  ActionHandler({
    required this.description,
    this.action,
    this.intent,
    required this.context,
  });
}

class DataRequestActionHandler extends ActionHandler {
  final Future<dynamic> Function()?
      dataRequest; // The function for retrieving data
  final void Function(dynamic data)?
      onData; // What should be done on receiving the data
  DataRequestActionHandler({
    required super.description,
    required super.context,
    required this.dataRequest,
    required this.onData,
    super.action,
    super.intent,
  });
}
