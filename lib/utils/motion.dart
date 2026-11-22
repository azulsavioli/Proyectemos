import 'package:flutter/widgets.dart';

/// Page transitions collapse when the system asks for reduced motion.
Duration motionDuration(
  BuildContext context, [
  Duration duration = const Duration(milliseconds: 400),
]) {
  return MediaQuery.disableAnimationsOf(context) ? Duration.zero : duration;
}
