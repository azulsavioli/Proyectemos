import 'package:flutter/material.dart';

class PaddedDropdownMenuItem<T> extends StatelessWidget {
  final double padding;
  final T value;
  final Widget child;

  const PaddedDropdownMenuItem({
    Key? key,
    required this.padding,
    required this.value,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: padding),
      child: DropdownMenuItem<T>(
        value: value,
        child: child,
      ),
    );
  }
}
