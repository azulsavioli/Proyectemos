import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';

import '../../../../commons/strings/strings.dart';
import '../../../../commons/styles.dart';
import '../../../../repository/proyectemos_repository.dart';
import '../../widgets/drawer_menu.dart';

class FeedLatinoamericaPage extends StatefulWidget {
  const FeedLatinoamericaPage({Key? key}) : super(key: key);

  @override
  State<FeedLatinoamericaPage> createState() => _FeedLatinoamericaPageState();
}

class _FeedLatinoamericaPageState extends State<FeedLatinoamericaPage> {
  late Stream<List<dynamic>> _imagesStream;
  final _repository = ProyectemosRepository();

  @override
  void initState() {
    _imagesStream = _repository.getImagesTurmaLatinoamericaStream();
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
          Strings.titleLatinoamericaUnoFeed,
          style: ThemeText.paragraph14WhiteBold,
        ),
      ),
      endDrawer: DrawerMenuWidget(),
      body: StreamBuilder<List<dynamic>>(
        stream: _imagesStream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('Ocurrió un error al intentar cargar las imágenes.'),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: ThemeColors.blue,
              ),
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
                    'Actividades compartidas por los estudiantes',
                    textAlign: TextAlign.center,
                    style: ThemeText.paragraph16BlueBold,
                  ),
                ),
                buildSwiperCards(students),
              ],
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(
                color: ThemeColors.blue,
              ),
            );
          }
        },
      ),
    );
  }

  Widget buildSwiperCards(List<dynamic> lista) {
    final swipers = <Widget>[];
    var i = 0;
    while (i < lista.length) {
      final cards = [];

      for (var j = 0; j < 5; j++) {
        cards.add(
          Card(
            color: ThemeColors.white,
            elevation: 3,
            child: Column(
              children: [
                ListTile(
                  title: Text(lista[i]['nome']),
                  subtitle: Text(
                    lista[i]['imagem_latinoamerica_${j + 1}'][0],
                    style: TextStyle(
                      color: Colors.black.withOpacity(0.6),
                    ),
                  ),
                ),
                Image.network(
                  lista[i]['imagem_latinoamerica_${j + 1}'][1],
                  fit: BoxFit.fitHeight,
                  height: 300,
                  width: 300,
                ),
              ],
            ),
          ),
        );
      }
      i++;
      swipers.add(
        Container(
          margin: const EdgeInsets.all(10),
          child: Swiper(
            itemCount: cards.length,
            itemBuilder: (BuildContext context, int index) {
              return cards[index];
            },
            itemWidth: 300,
            itemHeight: 400,
            layout: SwiperLayout.STACK,
          ),
        ),
      );
    }
    return Column(
      children: swipers,
    );
  }
}
