import 'package:flutter/material.dart';
import 'package:proyectemos/app/modules/proyecto_dos/el_podcast/tarea_uno/tarea_uno_controller.dart';
import 'package:proyectemos/app/modules/widgets/custom_text_form_field.dart';

import '../../../../../commons/strings/strings_conoces_podcast.dart';
import '../../../../../commons/styles.dart';
import '../../../widgets/custom_record_audio_button.dart';

class QuestionConocesPodcastQuatro extends StatefulWidget {
  final TextEditingController textController;
  final ConocesPodcastController controller;
  final FocusNode focusNode;

  const QuestionConocesPodcastQuatro({
    Key? key,
    required this.controller,
    required this.textController,
    required this.focusNode,
  }) : super(key: key);

  @override
  State<QuestionConocesPodcastQuatro> createState() =>
      _QuestionConocesPodcastQuatroState();
}

class _QuestionConocesPodcastQuatroState
    extends State<QuestionConocesPodcastQuatro>
    with AutomaticKeepAliveClientMixin {
  TextEditingController get _textController => widget.textController;
  ConocesPodcastController get _controller => widget.controller;
  FocusNode get focusNode => widget.focusNode;
  bool isAccessibleOn = false;

  @override
  initState() {
    super.initState();
    _controller.getIsAcessible();
    if (_controller.isAccessible != null) {
      setState(() {
        this.isAccessibleOn = _controller.isAccessible!;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isAccessibleOn)
            Text(
              StringsConocesPodcast.questionQuatroConocesPodcastAccessible,
              style: ThemeText.paragraph16GrayNormal,
            )
          else
            Text(
              StringsConocesPodcast.questionQuatroConocesPodcast,
              style: ThemeText.paragraph16GrayNormal,
            ),
          const SizedBox(
            height: 20,
          ),
          if (isAccessibleOn)
            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: CustomTextFormField(
                focusNode: focusNode,
                textInputAction: TextInputAction.next,
                hint: 'Respuesta',
                controller: _textController,
                keyboardType: TextInputType.text,
                validatorVazio: 'Ingrese tuja respuesta correctamente',
                validatorMenorqueNumero:
                    'Su respuesta debe tener al menos 3 caracteres',
              ),
            )
          else
            CustomRecordAudioButton(
              question: StringsConocesPodcast.questionQuatroConocesPodcast,
              isAudioFinish: _controller.isAudioFinish,
              namedRoute: '/record_and_play_conoces_podcast',
              labelButton: 'Grabar la respuesta',
              labelButtonFinished: 'Completo',
            ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
