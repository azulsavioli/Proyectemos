import 'package:flutter/material.dart';

import '../../../commons/styles.dart';

class CardButton extends StatelessWidget {
  final String text;
  final double cardWidth;
  final double cardHeight;
  final String? namedRoute;
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
    final double shortestSide = MediaQuery.of(context).size.shortestSide;
    final bool isMobile = shortestSide < 600;
    return isMobile
        ? _buildMobileCard(context)
        : _buildDesktopCard(context);
  }

  Widget _buildMobileCard(BuildContext context) {
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
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          foregroundColor: shadowColor,
          backgroundColor: Colors.white,
          elevation: 3,
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 20),
          textStyle: ThemeText.paragraph14Gray,
        ),
        onPressed: () {
          if (namedRoute == null)
            return;
          else
            Navigator.of(context).pushNamed(namedRoute!);
        },
        label: Row(
          children: [
            const SizedBox(
              width: 24,
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

  Widget _buildDesktopCard(BuildContext context) {
    return SizedBox(
      height: cardHeight,
      width: cardWidth,
      child: ElevatedButton.icon(
        icon: Padding(
          padding: const EdgeInsets.only(left: 24),
          child: CircleAvatar(
            radius: 45,
            backgroundColor: backgroundColor,
            child: Icon(
              icon,
              size: iconSize,
              color: ThemeColors.white,
            ),
          ),
        ),
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          foregroundColor: shadowColor,
          backgroundColor: Colors.white,
          elevation: 3,
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 20),
          textStyle: ThemeText.paragraph14Gray,
        ),
        onPressed: () {
          if (namedRoute == null)
            return;
          else
            Navigator.of(context).pushNamed(namedRoute!);
        },
        label: Row(
          children: [
            const SizedBox(
              width: 60,
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
