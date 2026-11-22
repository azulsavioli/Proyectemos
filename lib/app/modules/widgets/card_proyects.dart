import 'package:flutter/material.dart';

import '../../../commons/styles.dart';

class CardProyecto extends StatelessWidget {
  final String namedRoute;
  final String image;
  final Color backgroundColor;
  final String title;
  final TextStyle titleColor;
  final String description;
  final TextStyle descriptionColor;
  final IconData? icon;

  const CardProyecto({
    Key? key,
    required this.backgroundColor,
    required this.title,
    required this.titleColor,
    required this.description,
    required this.descriptionColor,
    required this.image,
    required this.namedRoute,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double shortestSide = MediaQuery.of(context).size.shortestSide;
    final bool isMobile = shortestSide < 450;
    return isMobile ? buildPhoneLayout(context) : buildTabletLayout(context);
  }

  Widget buildPhoneLayout(BuildContext context) {
    return _card(context, imageSize: 96, gap: 12);
  }

  Widget buildTabletLayout(BuildContext context) {
    return _card(context, imageSize: 140, gap: 20);
  }

  Widget _card(
    BuildContext context, {
    required double imageSize,
    required double gap,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(namedRoute);
      },
      child: Card(
        elevation: 3,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                image,
                height: imageSize,
                width: imageSize,
                fit: BoxFit.contain,
              ),
              SizedBox(width: gap),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: titleColor, softWrap: true),
                    const SizedBox(height: 8),
                    Text(description, style: descriptionColor, softWrap: true),
                  ],
                ),
              ),
              if (icon != null) ...[
                const SizedBox(width: 8),
                CircleAvatar(
                  radius: 15,
                  backgroundColor: backgroundColor,
                  child: Icon(
                    icon!,
                    size: 20,
                    color: ThemeColors.foregroundOn(backgroundColor),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
