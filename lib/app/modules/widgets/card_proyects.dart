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
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(namedRoute);
      },
      child: Card(
        elevation: 3,
        color: Colors.white,
        child: SizedBox(
          width: MediaQuery.of(context).size.width * .9,
          height: MediaQuery.of(context).size.height * .23,
          child: Center(
            child: Row(
              children: [
                Image.asset(
                  image,
                  height: 120,
                  width: 120,
                ),
                SizedBox(
                  width: 15,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: titleColor,
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        SizedBox(
                          width: 160,
                          child: Text(
                            description,
                            style: descriptionColor,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        SizedBox(
                          width: 160,
                        ),
                        if (icon != null)
                          CircleAvatar(
                            radius: 15,
                            backgroundColor: backgroundColor,
                            child: Icon(
                              icon!,
                              size: 20,
                              color: ThemeColors.white,
                            ),
                          ),
                      ],
                    )
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
