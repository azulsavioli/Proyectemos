import 'package:flutter/material.dart';

/// Drawer control with a name and a 48dp target.
class MenuIconButton extends StatelessWidget {
  final double iconSize;

  const MenuIconButton({super.key, this.iconSize = 24});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: 'Menu',
      style: IconButton.styleFrom(
        minimumSize: const Size(48, 48),
        tapTargetSize: MaterialTapTargetSize.padded,
        iconSize: iconSize,
      ),
      icon: Icon(Icons.menu, size: iconSize),
      onPressed: () => Scaffold.of(context).openEndDrawer(),
    );
  }
}
