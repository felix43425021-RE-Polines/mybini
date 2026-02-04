import 'package:flutter/material.dart';

/// Returns the width of context
///
/// Equivalent to MediaQuery.of(context).size.width
///
/// [context] BuildContext of the current widget
double width(BuildContext context, {double scale = 1.0}) {
  return MediaQuery.of(context).size.width * scale;
}

/// Returns the height of the context
///
/// Equivalent to MediaQuery.of(context).size.height
///
/// [context] BuildContext of the current widget
double height(BuildContext context, {double scale = 1.0}) {
  return MediaQuery.of(context).size.height * scale;
}
