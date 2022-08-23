import 'package:flutter/material.dart';

class CardClicavel extends StatelessWidget {
  final Function onCallback;
  final Color backgroundColor;
  final IconData icon;
  final Color iconColor;
  final String text;
  final TextStyle textColor;

  const CardClicavel({
    Key? key,
    required this.onCallback,
    required this.backgroundColor,
    required this.icon,
    required this.iconColor,
    required this.text,
    required this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: iconColor,
      splashColor: backgroundColor,
      onTap: onCallback(),
      child: Card(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * .9,
          height: MediaQuery.of(context).size.width * .2,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: backgroundColor,
                      child: Icon(
                        icon,
                        color: iconColor,
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Text(
                      text,
                      style: textColor,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
