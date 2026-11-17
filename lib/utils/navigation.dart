import 'package:flutter/widgets.dart';

/// Pops the current route. If this screen is the only entry on the stack,
/// replaces it with [fallbackRoute] so the back arrow never pushes another copy.
void popOrReplace(BuildContext context, String fallbackRoute) {
  final navigator = Navigator.of(context);
  if (navigator.canPop()) {
    navigator.pop();
    return;
  }
  navigator.pushReplacementNamed(fallbackRoute);
}
