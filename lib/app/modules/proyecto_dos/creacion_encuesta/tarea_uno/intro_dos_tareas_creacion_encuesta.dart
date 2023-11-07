import 'package:flutter/material.dart';

import '../../../../../commons/strings/strings_creacion_encuesta.dart';
import '../../../../../commons/styles.dart';

class IntroTareaDosCreacionEncuestaPage extends StatefulWidget {
  const IntroTareaDosCreacionEncuestaPage({
    Key? key,
  }) : super(key: key);

  @override
  State<IntroTareaDosCreacionEncuestaPage> createState() =>
      _IntroTareaDosCreacionEncuestaPageState();
}

class _IntroTareaDosCreacionEncuestaPageState
    extends State<IntroTareaDosCreacionEncuestaPage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            StringsCreacionEncuesta.descriptionTwoCreacionEncuesta,
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
                  Icons.draw,
                  color: ThemeColors.blue,
                ),
                title: Text(StringsCreacionEncuesta.topicOne),
              ),
              ListTile(
                leading: Icon(
                  Icons.people,
                  color: ThemeColors.yellow,
                ),
                title: Text(StringsCreacionEncuesta.topicTwo),
              ),
              ListTile(
                leading: Icon(
                  Icons.play_lesson,
                  color: ThemeColors.red,
                ),
                title: Text(StringsCreacionEncuesta.topicThree),
              ),
              SizedBox(
                height: 40,
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            StringsCreacionEncuesta.descriptionThreeCreacionEncuesta,
            style: ThemeText.paragraph16GrayNormal,
          ),
        ],
      ),
    );
  }
}
