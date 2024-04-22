import 'dart:async';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../../commons/strings/strings.dart';
import '../../../../../../commons/styles.dart';
import '../../../../../../repository/proyectemos_repository.dart';
import '../../../../widgets/drawer_menu.dart';

class FeedCreaTuMovimientoTareaDosPage extends StatefulWidget {
  const FeedCreaTuMovimientoTareaDosPage({super.key});

  @override
  State<FeedCreaTuMovimientoTareaDosPage> createState() =>
      _FeedCreaTuMovimientoTareaDosPageState();
}

class _FeedCreaTuMovimientoTareaDosPageState
    extends State<FeedCreaTuMovimientoTareaDosPage> {
  final _repository = ProyectemosRepository();
  late Stream<List<dynamic>> _linkMovimientoStream;

  @override
  void initState() {
    _linkMovimientoStream = _repository.getMovimientoSocialeTurmaStream();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: ThemeColors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: Color.fromRGBO(250, 251, 250, 1),
        ),
        title: Text(
          Strings.titleGrabacionPodcastFeed,
          style: ThemeText.paragraph14WhiteBold,
        ),
      ),
      endDrawer: DrawerMenuWidget(),
      body: StreamBuilder<List<dynamic>>(
        stream: _linkMovimientoStream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('Ocurrió un error al intentar cargar las imágenes.'),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          final students = snapshot.data ?? [];

          if (students.isNotEmpty) {
            return ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    top: 20,
                    left: 10,
                    right: 10,
                    bottom: 15,
                  ),
                  child: Text(
                    'Links del movimientos compartidos por los estudiantes',
                    textAlign: TextAlign.center,
                    style: ThemeText.paragraph16BlueBold,
                  ),
                ),
                buildCards(students),
              ],
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Widget buildCards(List<dynamic> lista) {
    final cardsPodcast = <Widget>[];
    String movimientosLink;
    String nomeMovimiento;
    String grupo;

    var i = 0;
    while (i < lista.length) {
      movimientosLink = lista[i]['movimiento_link'];
      nomeMovimiento = lista[i]['nome_del_movimiento'];
      grupo = lista[i]['grupo'];
      grupo.substring(1, grupo.length - 1);

      for (var j = 0; j < 1; j++) {
        cardsPodcast.add(
          Padding(
            padding: const EdgeInsets.all(12),
            child: Card(
              color: ThemeColors.white,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    ListTile(
                      leading: CircleAvatar(
                        radius: 20,
                        backgroundColor: ThemeColors.yellow,
                        child: Icon(
                          Icons.group_add,
                          color: ThemeColors.white,
                          size: 24,
                        ),
                      ),
                      title: Text(nomeMovimiento),
                      subtitle: Text(
                        '''
${grupo.substring(1, grupo.length - 1)}\n''',
                      ),
                    ),
                    ElevatedButton.icon(
                      style: ButtonStyle(
                        elevation: MaterialStateProperty.all(3),
                        backgroundColor: MaterialStateProperty.all(
                          ThemeColors.white,
                        ),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                      onPressed: () => launchUrlMovimientoSoliale(
                        movimientosLink,
                      ),
                      icon: const Icon(
                        Icons.link,
                        color: ThemeColors.yellow,
                      ),
                      label: Text(
                        'Ir para o podcast',
                        style: ThemeText.paragraph14Gray,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }
      i++;
    }
    return Column(
      children: cardsPodcast,
    );
  }

  Future<void> launchUrlMovimientoSoliale(String urlString) async {
    final url = Uri.parse(urlString);

    if (urlString.contains("http") || urlString.contains("https")) {
      await launchUrl(url);
    } else if (!urlString.contains("http") && !urlString.contains("https")) {
      final httpUrl = Uri.parse('https://$urlString');
      await launchUrl(httpUrl);
    } else {
      print('Could not launch $url');
    }
  }
}
