import 'dart:async';

import 'package:appinio_video_player/appinio_video_player.dart';
import 'package:chewie/chewie.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyectemos/commons/strings/strings_movimientos_sociales.dart';
import 'package:proyectemos/services/tres_tasks_completed.dart';

import '../../../../../commons/styles.dart';
import '../../../../../repository/proyectemos_repository.dart';
import '../../../widgets/drawer_menu.dart';

class FeedMovimientosSocialesPage extends StatefulWidget {
  const FeedMovimientosSocialesPage({Key? key}) : super(key: key);

  @override
  State<FeedMovimientosSocialesPage> createState() =>
      _FeedMovimientosSocialesPageState();
}

class _FeedMovimientosSocialesPageState
    extends State<FeedMovimientosSocialesPage> {
  bool feedTurma = false;
  late VideoPlayerController videoPlayerController;
  late List<String> videosList;
  late List<ChewieController> videoPlayerControllers;
  List students = [];
  late StreamController<List> _videosStreamController;
  late ChewieController chewieController;

  @override
  void initState() {
    _videosStreamController = StreamController<List>();
    startFeed();
    super.initState();
  }

  @override
  void dispose() {
    for (final controller in videoPlayerControllers) {
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
    final resultado = await TresTasksCompletedService
        .getTresMovimientosSocialesCompletedInfo();

    setState(() {
      feedTurma = resultado;
    });
  }

  Future<void> getVideos() async {
    try {
      final snapshot = await context
          .read<ProyectemosRepository>()
          .getVideosMovimientosSocialesTurma();
      final studentsList = await setStudentsList(snapshot);
      _videosStreamController.add(studentsList);
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
      videosList.add(video['video_grupo']);
    }
    return videosList;
  }

  List<ChewieController> initVideoControllers() {
    videoPlayerControllers = [];

    for (final video in videosList) {
      try {
        videoPlayerController = VideoPlayerController.networkUrl(
          Uri.parse(video),
        )..initialize().then((value) => setState(() {}));

        chewieController = ChewieController(
          videoPlayerController: videoPlayerController,
        );
      } catch (error) {
        error.toString();
      }

      videoPlayerControllers.add(chewieController);
    }
    return videoPlayerControllers;
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
          StringsMovimientosSociales.title,
          style: ThemeText.paragraph16WhiteBold,
        ),
      ),
      endDrawer: DrawerMenuWidget(),
      body: StreamBuilder<List>(
        stream: _videosStreamController.stream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('Ocurrió un error al intentar cargar los videos.'),
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
                  'Videos compartidos por los estudiantes',
                  textAlign: TextAlign.center,
                  style: ThemeText.paragraph16BlueBold,
                ),
                const SizedBox(
                  height: 25,
                ),
                buildCards(students, videoPlayerControllers),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget buildCards(
    List listStudents,
    List<ChewieController> videoControllers,
  ) {
    final cards = <Widget>[];
    var i = 0;
    while (i < listStudents.length) {
      cards.add(
        Card(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8),
                child: ListTile(
                  title: Text(listStudents[i]['grupo']),
                ),
              ),
              SizedBox(
                width: 360,
                height: 400,
                child: Chewie(
                  controller: videoControllers[i],
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
