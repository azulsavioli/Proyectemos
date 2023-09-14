import 'package:flutter/material.dart';

import '../../../../../commons/strings/strings_evento_cultural.dart';
import '../../../../../commons/styles.dart';

class IntroTareaDosEventoCulturalPage extends StatefulWidget {
  const IntroTareaDosEventoCulturalPage({
    Key? key,
  }) : super(key: key);

  @override
  State<IntroTareaDosEventoCulturalPage> createState() =>
      _IntroTareaDosEventoCulturalPageState();
}

class _IntroTareaDosEventoCulturalPageState
    extends State<IntroTareaDosEventoCulturalPage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            Text(
              StringsEventoCultural.descriptionTwoEventocultural,
              style: ThemeText.paragraph16GrayNormal,
            ),
            const SizedBox(
              height: 20,
            ),
            ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: const <Widget>[
                ListTile(
                  leading: Icon(
                    Icons.palette,
                    color: ThemeColors.blue,
                  ),
                  title: Text(StringsEventoCultural.topicOne),
                ),
                ListTile(
                  leading: Icon(
                    Icons.event,
                    color: ThemeColors.yellow,
                  ),
                  title: Text(StringsEventoCultural.topicTwo),
                ),
                ListTile(
                  leading: Icon(
                    Icons.place,
                    color: ThemeColors.red,
                  ),
                  title: Text(StringsEventoCultural.topicThree),
                ),
                ListTile(
                  leading: Icon(
                    Icons.edit,
                    color: ThemeColors.green,
                  ),
                  title: Text(StringsEventoCultural.topicFour),
                ),
                ListTile(
                  leading: Icon(
                    Icons.diversity_1,
                    color: ThemeColors.blue,
                  ),
                  title: Text(StringsEventoCultural.topicFive),
                ),
                ListTile(
                  leading: Icon(
                    Icons.emoji_objects,
                    color: ThemeColors.yellow,
                  ),
                  title: Text(StringsEventoCultural.topicSix),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
