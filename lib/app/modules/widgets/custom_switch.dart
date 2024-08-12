import 'package:flutter/material.dart';
import 'package:proyectemos/commons/styles.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomSwitch extends StatefulWidget {
  const CustomSwitch({super.key});

  @override
  State<CustomSwitch> createState() => _CustomSwitchState();
}

class _CustomSwitchState extends State<CustomSwitch> {
  bool isAccessibleOn = false;

  @override
  void initState() {
    super.initState();
    getIsAcessible();
  }

  Future<void> isAcessible(bool value) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setBool(
      "isAccessible",
      value,
    );
  }

  Future<void> getIsAcessible() async {
    final preferences = await SharedPreferences.getInstance();
    final isAccessible = preferences.getBool("isAccessible");
    if (isAccessible != null) {
      setState(() {
        this.isAccessibleOn = isAccessible;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final WidgetStateProperty<Color?> trackColor =
        WidgetStateProperty.resolveWith<Color?>(
      (Set<WidgetState> states) {
        if (states.contains(WidgetState.selected)) {
          return Colors.amber;
        }
        return null;
      },
    );
    final WidgetStateProperty<Color?> overlayColor =
        WidgetStateProperty.resolveWith<Color?>(
      (Set<WidgetState> states) {
        if (states.contains(WidgetState.selected)) {
          return Colors.amber.withOpacity(0.54);
        }
        if (states.contains(WidgetState.disabled)) {
          return ThemeColors.gray;
        }
        return null;
      },
    );

    return Switch(
      value: isAccessibleOn,
      overlayColor: overlayColor,
      trackColor: trackColor,
      thumbColor: const WidgetStatePropertyAll<Color>(Colors.white),
      onChanged: (bool value) {
        setState(() {
          isAccessibleOn = value;
          if (value == true) {
            isAcessible(true);
          } else {
            isAcessible(false);
          }
        });
      },
    );
  }
}
