import 'package:flutter/material.dart';

import '../../../commons/styles.dart';

class CardButton extends StatelessWidget {
  final String text;
  final double cardWidth;
  final double cardHeight;
  final String namedRoute;
  final Color backgroundColor;
  final IconData icon;
  final Color shadowColor;
  final double iconSize;

  const CardButton({
    Key? key,
    required this.text,
    required this.cardWidth,
    required this.cardHeight,
    required this.namedRoute,
    required this.backgroundColor,
    required this.icon,
    required this.shadowColor,
    required this.iconSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: cardHeight,
      width: cardWidth,
      child: ElevatedButton.icon(
        icon: Padding(
          padding: const EdgeInsets.only(left: 8),
          child: CircleAvatar(
            radius: 25,
            backgroundColor: backgroundColor,
            child: Icon(
              icon,
              size: iconSize,
              color: ThemeColors.white,
            ),
          ),
        ),
        style: ElevatedButton.styleFrom(
          foregroundColor: shadowColor,
          backgroundColor: Colors.white,
          elevation: 1,
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 20),
          textStyle: ThemeText.paragraph14Gray,
        ),
        onPressed: () {
          Navigator.of(context).pushNamed(namedRoute);
        },
        label: Row(
          children: [
            const SizedBox(
              width: 15,
            ),
            Text(
              text,
              style: ThemeText.paragraph14Gray,
            ),
          ],
        ),
      ),
    );
  }
}
