import 'package:card_swiper/card_swiper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../commons/strings.dart';
import '../../../../commons/styles.dart';
import '../../../proyectemos_repository.dart';
import '../../widgets/drawer_menu.dart';

class FeedLatinoamericaPage extends StatefulWidget {
  const FeedLatinoamericaPage({super.key});

  @override
  State<FeedLatinoamericaPage> createState() => _FeedLatinoamericaPageState();
}

class _FeedLatinoamericaPageState extends State<FeedLatinoamericaPage> {
  var studentsAnswers;

  getStudentsAnswers() async {
    String doc = 'uno/artistas-latinoamericanos/atividade_3/';

    try {
      studentsAnswers =
          await context.read<ProyectemosRepository>().getAllStudentsAnswers();
      print(studentsAnswers);
    } on FirebaseException catch (e) {
      return e.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    var studentsCardsInfo = getStudentsAnswers();

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
        automaticallyImplyLeading: true,
        title: const Text(Strings.titleLatinoamericaUno,
            style: ThemeText.paragraph16WhiteBold),
      ),
      endDrawer: const DrawerMenuWidget(),
      body: ListView(
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 20, left: 10, right: 10, bottom: 15),
            child: Text(
              textAlign: TextAlign.center,
              'Actividades compartidas por los estudiantes',
              style: ThemeText.h3title22yellow,
            ),
          ),
          SizedBox(
            height: 400,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Swiper(
                layout: SwiperLayout.STACK,
                itemHeight: 400.0,
                itemWidth: 300.0,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    clipBehavior: Clip.antiAlias,
                    child: Column(
                      children: [
                        ListTile(
                          title: const Text('Card title 1'),
                          subtitle: Text(
                            'Secondary Text',
                            style:
                                TextStyle(color: Colors.black.withOpacity(0.6)),
                          ),
                        ),
                        Image.network(
                          "https://images.ctfassets.net/hrltx12pl8hq/4T3awLHLswoH7odPXFrNmA/7a8bfc9dcb8bc33cf96d20ab4eebb2a8/Shutterstock_1207028731.jpg?fit=fill&w=400&h=560&fm=webp",
                          fit: BoxFit.cover,
                          height: 300,
                          width: 400,
                        ),
                      ],
                    ),
                  );
                },
                itemCount: 3,
                pagination: const SwiperPagination(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
