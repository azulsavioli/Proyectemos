import 'package:flutter/material.dart';

import '../../../../../commons/styles.dart';
import 'tarea_uno_controller.dart';

class QuestionDivulgacaoOne extends StatefulWidget {
  final DivulgacaoController controller;

  const QuestionDivulgacaoOne({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  State<QuestionDivulgacaoOne> createState() => _QuestionDivulgacaoOneState();
}

enum OpcoesCompartilhamento { turma, todos }

class _QuestionDivulgacaoOneState extends State<QuestionDivulgacaoOne>
    with AutomaticKeepAliveClientMixin {
  DivulgacaoController get _controller => widget.controller;

  bool isButtonDisabled = false;

  bool buttonFileSelected = false;
  Icon buttonFileIcon = const Icon(
    Icons.file_copy,
    color: ThemeColors.white,
  );
  Color buttonFileColor = ThemeColors.blue;

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
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: RadioListTile<OpcoesCompartilhamento>(
                    title: const Text('Todos'),
                    fillColor: WidgetStateProperty.resolveWith(
                      (states) => ThemeColors.blue,
                    ),
                    value: OpcoesCompartilhamento.todos,
                    groupValue: _controller.sendingType,
                    onChanged: (OpcoesCompartilhamento? value) {
                      setState(() {
                        _controller.sendingType = value;
                      });
                    },
                  ),
                ),
                Expanded(
                  child: RadioListTile<OpcoesCompartilhamento>(
                    title: const Text('Turma'),
                    fillColor: WidgetStateProperty.resolveWith(
                      (states) => ThemeColors.blue,
                    ),
                    value: OpcoesCompartilhamento.turma,
                    groupValue: _controller.sendingType,
                    onChanged: (OpcoesCompartilhamento? value) {
                      setState(() {
                        _controller.sendingType = value;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          SizedBox(
            height: 60,
            width: MediaQuery.of(context).size.width,
            child: ElevatedButton.icon(
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(
                  buttonFileSelected ? ThemeColors.green : ThemeColors.blue,
                ),
                shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              icon: buttonFileIcon,
              onPressed: () async {
                final file = await _controller.selectFile();
                if (file != null) {
                  setState(() {
                    buttonFileColor = ThemeColors.green;
                    buttonFileIcon = const Icon(
                      Icons.check,
                      color: ThemeColors.white,
                    );
                    buttonFileSelected = true;
                  });
                }
              },
              label: Text(
                'Subir el vídeo',
                style: ThemeText.paragraph16White,
              ),
            ),
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
