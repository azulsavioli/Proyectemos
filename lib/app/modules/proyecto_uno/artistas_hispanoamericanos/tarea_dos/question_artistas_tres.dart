import 'package:flutter/material.dart';

import '../../../widgets/custom_upload_form.dart';
import 'tarea_dos_controller.dart';

class QuestionArtistashispanoamericanosTres extends StatefulWidget {
  final ArtistasLatinoamericanosTareaDosController controller;
  final TextEditingController textController;

  const QuestionArtistashispanoamericanosTres({
    Key? key,
    required this.controller,
    required this.textController,
  }) : super(key: key);

  @override
  State<QuestionArtistashispanoamericanosTres> createState() =>
      _QuestionArtistashispanoamericanosTresState();
}

class _QuestionArtistashispanoamericanosTresState
    extends State<QuestionArtistashispanoamericanosTres>
    with AutomaticKeepAliveClientMixin {
  ArtistasLatinoamericanosTareaDosController get controller =>
      widget.controller;
  TextEditingController get textController => widget.textController;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 20,
          ),
          CustomUploadForm(
            title: controller.randonCountrys[2],
            controller: textController,
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
