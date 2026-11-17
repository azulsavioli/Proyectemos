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
    return isMobile ? _buildMobileCard(context) : _buildDesktopCard(context);
  }

  Widget _buildMobileCard(BuildContext context) {
    return _buildCard(context, iconRadius: 25, gap: 12, horizontalPadding: 14);
  }

  Widget _buildDesktopCard(BuildContext context) {
    return _buildCard(context, iconRadius: 45, gap: 24, horizontalPadding: 20);
  }

  Widget _buildCard(
    BuildContext context, {
    required double iconRadius,
    required double gap,
    required double horizontalPadding,
  }) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        minHeight: cardHeight,
        minWidth: cardWidth,
        maxWidth: cardWidth,
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          foregroundColor: shadowColor,
          backgroundColor: Colors.white,
          elevation: 3,
          padding: EdgeInsets.symmetric(
            horizontal: horizontalPadding,
            vertical: 16,
          ),
          textStyle: ThemeText.paragraph14Gray,
        ),
        onPressed: () {
          if (namedRoute == null) {
            return;
          }
          Navigator.of(context).pushNamed(namedRoute!);
        },
        child: Row(
          children: [
            CircleAvatar(
              radius: iconRadius,
              backgroundColor: backgroundColor,
              child: Icon(
                icon,
                size: iconSize,
                color: ThemeColors.foregroundOn(backgroundColor),
              ),
            ),
            SizedBox(width: gap),
            Expanded(
              child: Text(
                text,
                style: ThemeText.paragraph14Gray,
                softWrap: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
