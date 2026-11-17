import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyectemos/commons/styles.dart';
import 'package:proyectemos/providers/acessibility_provider.dart';

class CustomSwitch extends StatelessWidget {
  const CustomSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AccessibilityProvider>();
    final enabled = provider.isEnabled(context);
    final trackColor = WidgetStateProperty.resolveWith<Color?>((states) {
      if (states.contains(WidgetState.selected)) {
        return Colors.amber;
      }
      return null;
    });
    final overlayColor = WidgetStateProperty.resolveWith<Color?>((states) {
      if (states.contains(WidgetState.selected)) {
        return Colors.amber.withValues(alpha: 0.54);
      }
      if (states.contains(WidgetState.disabled)) {
        return ThemeColors.gray;
      }
      return null;
    });

    return Switch(
      value: enabled,
      overlayColor: overlayColor,
      trackColor: trackColor,
      thumbColor: const WidgetStatePropertyAll<Color>(Colors.white),
      onChanged: provider.setAccessibility,
    );
  }
}
