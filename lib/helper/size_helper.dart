import 'package:flutter/material.dart';

/// Returns the width of the screen
///
/// Equivalent to MediaQuery.of(context).size.width
///
/// [context] BuildContext of the current widget
double widthScreen(BuildContext context, {double scale = 1.0}) {
  return MediaQuery.of(context).size.width * scale;
}

/// Returns the height of the screen
///
/// Equivalent to MediaQuery.of(context).size.height
///
/// [context] BuildContext of the current widget
double heightScreen(BuildContext context, {double scale = 1.0}) {
  return MediaQuery.of(context).size.height * scale;
}
