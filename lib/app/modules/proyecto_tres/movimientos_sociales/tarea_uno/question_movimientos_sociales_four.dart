import 'package:flutter/material.dart';

import '../../../../../commons/styles.dart';
import 'movimientos_sociales_controller.dart';

class IntroFourMovimientosSocialesPage extends StatefulWidget {
  final MovimientosSocialesController controller;

  const IntroFourMovimientosSocialesPage({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  State<IntroFourMovimientosSocialesPage> createState() =>
      _IntroFourMovimientosSocialesPageState();
}

class _IntroFourMovimientosSocialesPageState
    extends State<IntroFourMovimientosSocialesPage>
    with AutomaticKeepAliveClientMixin {
  MovimientosSocialesController get controller => widget.controller;

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
          Text(
            controller.randonMovimientos,
            style: ThemeText.paragraph16GrayBold,
          ),
          const SizedBox(
            height: 25,
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            height: 60,
            width: MediaQuery.of(context).size.width,
            child: ElevatedButton.icon(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                  buttonFileSelected ? ThemeColors.green : ThemeColors.blue,
                ),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              icon: buttonFileIcon,
              onPressed: () async {
                final file = await controller.selectFile();
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
