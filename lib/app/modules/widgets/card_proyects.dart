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

  Widget buildTabletLayout(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(namedRoute);
      },
      child: Card(
        elevation: 3,
        color: Colors.white,
        child: SizedBox(
          width: MediaQuery.of(context).size.width * .98,
          height: MediaQuery.of(context).size.height * .24,
          child: Center(
            child: Row(
              children: [
                Image.asset(
                  image,
                  height: 150,
                  width: 150,
                ),
                SizedBox(
                  width: 24,
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
                      height: 24,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        SizedBox(
                          width: 250,
                          child: Text(
                            description,
                            style: descriptionColor,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        SizedBox(
                          width: 250,
                        ),
                        if (icon != null)
                          CircleAvatar(
                            radius: 15,
                            backgroundColor: backgroundColor,
                            child: Icon(
                              icon!,
                              size: 60,
                              color: const Color.fromARGB(255, 157, 187, 157),
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
