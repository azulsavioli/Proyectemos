import 'package:flutter/material.dart';
import 'package:flutter_native_splash/cli_commands.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../commons/strings/strings.dart';
import '../../../../commons/styles.dart';
import '../../../../repository/proyectemos_repository.dart';
import '../../widgets/drawer_menu.dart';

class FeedGrabacionPodcastPage extends StatefulWidget {
  const FeedGrabacionPodcastPage({Key? key}) : super(key: key);

  @override
  State<FeedGrabacionPodcastPage> createState() =>
      _FeedGrabacionPodcastPageState();
}

class _FeedGrabacionPodcastPageState extends State<FeedGrabacionPodcastPage> {
  late Stream<List<dynamic>> _podcastStream;
  final _repository = ProyectemosRepository();

  @override
  void initState() {
    _podcastStream = _repository.getPodcastTurmaStream();
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
        stream: _podcastStream,
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
                    'Podcasts compartidos por los estudiantes',
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
    String podcastLink;
    String nomePodcast;
    String nomeEpisodioPodcast;
    String grupo;
    String logoPodcast;

    var i = 0;
    while (i < lista.length) {
      podcastLink = lista[i]['podcast_link'];
      nomePodcast = lista[i]['nome_podcast'];
      nomeEpisodioPodcast = lista[i]['nome_episodio_podcast'];
      grupo = lista[i]['grupo'];
      logoPodcast = lista[i]['logo_podcast'];

      grupo.substring(1, grupo.length - 1);

      for (var j = 0; j < 1; j++) {
        cardsPodcast.add(
          Padding(
            padding: const EdgeInsets.all(12),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    ListTile(
                      leading: CircleAvatar(
                        radius: 32,
                        backgroundColor: ThemeColors.yellow,
                        child: Image.network(
                          logoPodcast,
                          // fit: BoxFit.cover,
                          height: 300,
                          width: 300,
                        ),
                      ),
                      title: Text(nomePodcast),
                      subtitle: Text(
                        '''
\n${nomeEpisodioPodcast.capitalize()}\n
${grupo.substring(1, grupo.length - 1)}\n''',
                      ),
                    ),
                    ElevatedButton.icon(
                      onPressed: () => launchUrlPodcast(
                        podcastLink,
                      ),
                      icon: const Icon(Icons.link),
                      label: const Text('Ir para o podcast'),
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

  Future<void> launchUrlPodcast(String urlString) async {
    final url = Uri.parse(urlString);

    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      print('Could not launch $url');
    }
  }
}
