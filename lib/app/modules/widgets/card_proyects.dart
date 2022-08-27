import 'package:flutter/material.dart';

class CardProyecto extends StatelessWidget {
  final Function onCallback;
  final String image;
  final Color backgroundColor;
  final String title;
  final TextStyle titleColor;
  final String description;
  final TextStyle descriptionColor;

  const CardProyecto({
    Key? key,
    required this.onCallback,
    required this.backgroundColor,
    required this.title,
    required this.titleColor,
    required this.description,
    required this.descriptionColor,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: backgroundColor,
      splashColor: backgroundColor,
      onTap: onCallback(),
      child: Card(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * .9,
          height: MediaQuery.of(context).size.height * .23,
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  image,
                  height: 150,
                  width: 150,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      style: titleColor,
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    SizedBox(
                      width: 160,
                      child: Text(
                        description,
                        style: descriptionColor,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
