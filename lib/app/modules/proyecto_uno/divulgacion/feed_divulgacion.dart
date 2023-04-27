import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';

import '../../../../commons/strings.dart';
import '../../../../commons/styles.dart';
import '../../widgets/drawer_menu.dart';

class FeedDivulgacionPage extends StatefulWidget {
  const FeedDivulgacionPage({super.key});

  @override
  State<FeedDivulgacionPage> createState() => _FeedDivulgacionPageState();
}
//TODO(shared preferences) : lembrar de pegar o valor do feedtype no shared preferences para realizar a logica de buscar o feed de acordo, tuma ou todos;

class _FeedDivulgacionPageState extends State<FeedDivulgacionPage> {
  final imagens = [];
  final stream = [];

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
          Strings.titleDivulgacionUnoFeed,
          style: ThemeText.paragraph16WhiteBold,
        ),
      ),
      endDrawer: const DrawerMenuWidget(),
      body: ListView(
        children: [
          Padding(
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
              padding: const EdgeInsets.all(8),
              child: Swiper(
                layout: SwiperLayout.STACK,
                itemHeight: 400,
                itemWidth: 300,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    clipBehavior: Clip.antiAlias,
                    child: Column(
                      children: [
                        ListTile(
                          title: const Text('Nome do aluno'),
                          subtitle: Text(
                            'Descripcion do video',
                            style:
                                TextStyle(color: Colors.black.withOpacity(0.6)),
                          ),
                        ),
                        Image.network(
                          'https://images.ctfassets.net/hrltx12pl8hq/4T3awLHLswoH7odPXFrNmA/7a8bfc9dcb8bc33cf96d20ab4eebb2a8/Shutterstock_1207028731.jpg?fit=fill&w=400&h=560&fm=webp',
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
