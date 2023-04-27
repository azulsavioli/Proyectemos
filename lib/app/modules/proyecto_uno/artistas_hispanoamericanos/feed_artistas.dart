import 'package:flutter/material.dart';

import '../../../../commons/strings.dart';
import '../../../../commons/styles.dart';
import '../../widgets/drawer_menu.dart';

class FeedArtistasPage extends StatefulWidget {
  const FeedArtistasPage({super.key});

  @override
  State<FeedArtistasPage> createState() => _FeedArtistasPageState();
}
//TODO(shared preferences) : lembrar de pegar o valor
//do feedtype no shared preferences para
//realizar a logica de buscar o feed de acordo, tuma ou todos;

class _FeedArtistasPageState extends State<FeedArtistasPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: ThemeColors.white),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: Color.fromRGBO(250, 251, 250, 1),
        ),
        title: Text(
          Strings.titleFeedbackEventoUno,
          style: ThemeText.paragraph16WhiteBold,
        ),
      ),
      endDrawer: const DrawerMenuWidget(),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 30, 16, 16),
        child: Column(
          children: [
            Center(
              child: Text(
                Strings.titleEventoCulturalUno,
                style: ThemeText.paragraph16BlueBold,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              'feedback',
              style: ThemeText.paragraph16GrayNormal,
            ),
          ],
        ),
      ),
    );
  }
}
