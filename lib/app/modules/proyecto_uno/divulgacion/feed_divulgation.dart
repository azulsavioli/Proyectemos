import 'dart:async';

import 'package:appinio_video_player/appinio_video_player.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../commons/strings.dart';
import '../../../../commons/styles.dart';
import '../../../../repository/proyectemos_repository.dart';
import '../../../../services/tasks_completed.dart';
import '../../widgets/drawer_menu.dart';

class FeedDivulgationPage extends StatefulWidget {
  const FeedDivulgationPage({Key? key}) : super(key: key);

  @override
  State<FeedDivulgationPage> createState() => _FeedDivulgationPageState();
}

class _FeedDivulgationPageState extends State<FeedDivulgationPage> {
  bool feedTurma = false;
  bool feedTodos = false;
  late VideoPlayerController videoPlayerController;
  late List<String> videosList;
  late List<CustomVideoPlayerController> customVideoPlayerControllers;
  late CustomVideoPlayerController customVideoPlayerController;
  List students = [];
  late StreamController<List> _videosStreamController;

  @override
  void initState() {
    _videosStreamController = StreamController<List>();
    startFeed();
    super.initState();
  }

  @override
  void dispose() {
    for (final controller in customVideoPlayerControllers) {
      controller.dispose();
    }
    _videosStreamController.close();
    super.dispose();
  }

  Future<void> startFeed() async {
    await getFeedTask();
    await getVideos().then((_) => {makeVideoList(), initVideoControllers()});
  }

  Future<void> getFeedTask() async {
    final resultado = await TasksCompletedService.getUnoDivulgationFeedType();

    setState(() {
      feedTurma = resultado[0];
      feedTodos = resultado[1];
    });
  }

  Future<void> getVideos() async {
    try {
      if (feedTurma) {
        final snapshot =
            await context.read<ProyectemosRepository>().getVideosTurma();
        final studentsList = await setStudentsList(snapshot);
        _videosStreamController.add(studentsList);
      } else {
        final snapshot =
            await context.read<ProyectemosRepository>().getVideosPublic();
        final studentsList = await setStudentsList(snapshot);
        _videosStreamController.add(studentsList);
      }
    } on FirebaseException catch (e) {
      _videosStreamController.addError(e.toString());
    }
  }

  Future<List> setStudentsList(snapshot) async {
    students = [];

    for (final student in snapshot) {
      students.add(await student);
    }

    return students;
  }

  List<String> makeVideoList() {
    videosList = [];
    for (final video in students) {
      videosList.add(video['resposta_1']);
    }
    return videosList;
  }

  List<CustomVideoPlayerController> initVideoControllers() {
    customVideoPlayerControllers = [];

    for (final video in videosList) {
      customVideoPlayerController = CustomVideoPlayerController(
        context: context,
        videoPlayerController: VideoPlayerController.network(
          video,
        )..initialize().then((value) => setState(() {})),
      );
      customVideoPlayerControllers.add(customVideoPlayerController);
    }
    return customVideoPlayerControllers;
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
          Strings.titleDivulgacionUnoFeed,
          style: ThemeText.paragraph16WhiteBold,
        ),
      ),
      endDrawer: const DrawerMenuWidget(),
      body: StreamBuilder<List>(
        stream: _videosStreamController.stream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('Ocurrió un error al intentar cargar las imágenes.'),
            );
          }
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          final students = snapshot.data!;

          return Padding(
            padding: const EdgeInsets.all(16),
            child: ListView(
              children: [
                const SizedBox(
                  height: 25,
                ),
                Text(
                  'Actividades compartidas por los estudiantes',
                  textAlign: TextAlign.center,
                  style: ThemeText.paragraph16BlueBold,
                ),
                const SizedBox(
                  height: 25,
                ),
                buildCards(students, customVideoPlayerControllers),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget buildCards(
    List listStudents,
    List<CustomVideoPlayerController> videoControllers,
  ) {
    List<Widget> cards = [];
    var i = 0;
    while (i < listStudents.length) {
      cards.add(
        Card(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8),
                child: ListTile(
                  title: Text(listStudents[i]['aluno']),
                ),
              ),
              SizedBox(
                width: 600,
                height: 400,
                child: CustomVideoPlayer(
                  customVideoPlayerController: videoControllers[i],
                ),
              ),
            ],
          ),
        ),
      );
      i++;
    }
    return Column(
      children: cards,
    );
  }
}
