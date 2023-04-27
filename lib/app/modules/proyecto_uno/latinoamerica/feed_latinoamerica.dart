import 'package:card_swiper/card_swiper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../commons/strings.dart';
import '../../../../commons/styles.dart';
import '../../../proyectemos_repository.dart';
import '../../widgets/drawer_menu.dart';

Widget buildSwiperCards(List lista) {
  List<Widget> swipers = [];
  var i = 0;
  while (i < lista.length) {
    final cards = [];

    for (var j = 0; j < 10; j++) {
      cards.add(
        Card(
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
                fit: BoxFit.cover,
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

class FeedLatinoamericaPage extends StatefulWidget {
  const FeedLatinoamericaPage({super.key});

  @override
  State<FeedLatinoamericaPage> createState() => _FeedLatinoamericaPageState();
}

class _FeedLatinoamericaPageState extends State<FeedLatinoamericaPage> {
  @override
  void initState() {
    getImages();
    super.initState();
  }

  List students = [];

  Future<dynamic> getImages() async {
    try {
      final snapshot =
          await context.read<ProyectemosRepository>().getImagesTurma();
      await setStudentsImageList(snapshot);
    } on FirebaseException catch (e) {
      return e.toString();
    }
  }

  Future<List> setStudentsImageList(snapshot) async {
    students = [];

    for (final student in snapshot) {
      students.add(await student);
    }
    return students;
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
          style: ThemeText.paragraph16WhiteBold,
        ),
      ),
      endDrawer: const DrawerMenuWidget(),
      body: FutureBuilder(
        future: getImages(),
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
          return ListView(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    top: 20, left: 10, right: 10, bottom: 15),
                child: Text(
                  textAlign: TextAlign.center,
                  'Actividades compartidas por los estudiantes',
                  style: ThemeText.paragraph16BlueBold,
                ),
              ),
              buildSwiperCards(students)
            ],
          );
        },
      ),
    );
  }
}
