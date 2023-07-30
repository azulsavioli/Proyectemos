import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mailer/mailer.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../repository/proyectemos_repository.dart';
import '../../../../../utils/email_sender.dart';
import '../../../../providers/record_audio_provider_artistas_impl.dart';

class ArtistasLatinoamericanosController {
  bool loading = true;

  final audioProvider = RecordAudioArtistasProviderImpl();
  bool isAudioFinish = RecordAudioArtistasProviderImpl().isRecording;
  List<String> recordsPathList =
      RecordAudioArtistasProviderImpl.recordingsPaths;
  Future convertAudioToFirebase(
    List<String> audioPaths,
    GoogleSignInAccount? currentUser,
  ) async {
    final firebaseStorage = FirebaseStorage.instance;
    final firebasePaths = [];
    final email = currentUser?.email;

    var counter = 0;

    try {
      for (final audio in audioPaths) {
        if (audioPaths.isEmpty) return;
        final file = File(audio);
        counter++;

        final snapshot = await firebaseStorage
            .ref()
            .child(
              'uno-artistas-latinoamericanos-audios/$email-audio-$counter.mp3',
            )
            .putFile(file)
            .whenComplete(() => null);

        final downloadUrl = await snapshot.ref.getDownloadURL();

        firebasePaths.add(downloadUrl);
      }
      return firebasePaths;
    } on PlatformException catch (e) {
      return 'Failed to convert audio: ${e.message}';
    }
  }

  Future<dynamic> makeJson(GoogleSignInAccount? currentUser) async {
    final list = RecordAudioArtistasProviderImpl.recordingsPaths;
    final firebasePaths = await convertAudioToFirebase(list, currentUser);
    final json = setJson(firebasePaths);
    return json;
  }

  Map<String, dynamic> setJson(List<dynamic> audioList) {
    final json = {
      'resposta_1': audioList[0],
      'resposta_2': audioList[1],
      'resposta_3': audioList[2],
    };
    return json;
  }

  Future sendAnswers(
    ctx,
    GoogleSignInAccount? currentUser,
    List<String> recordsPathList,
  ) async {
    final json = await makeJson(currentUser);
    const doc = 'uno/artistas-latinoamericanos/atividade_1/';

    try {
      await ctx.read<ProyectemosRepository>().saveAnswers(doc, json);
      await Future.delayed(
        const Duration(seconds: 20),
        () => sendEmail(ctx, recordsPathList, currentUser),
      );
    } on FirebaseException catch (e) {
      return e.toString();
    }
  }

  Future<List> getEmailTeacherFromFirebase(ctx) async {
    final emails = [];
    const doc = 'professora';
    final repository = ctx.read<ProyectemosRepository>();

    try {
      final data = await repository.getTeacherEmail(doc);
      emails.addAll(data);
    } on FirebaseException catch (e) {
      ScaffoldMessenger.of(ctx)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
    return emails;
  }

  Future<void> sendEmail(
    ctx,
    List<String> recordsPathList,
    GoogleSignInAccount? currentUser,
  ) async {
    final firstAudio = File(recordsPathList[0]);
    final secondAudio = File(recordsPathList[1]);
    final thirdAudio = File(recordsPathList[2]);

    final studentInfo = ctx.read<ProyectemosRepository>().getUserInfo();
    final studentInformation = studentInfo.split('/');

    final allStudentInfo = [
      studentInformation[3],
      studentInformation[0],
      studentInformation[1],
      studentInformation[2]
    ];

    final attachment = [
      FileAttachment(
        firstAudio,
        contentType: 'audio/mp3',
        fileName: 'Primeiro Audio',
      ),
      FileAttachment(
        secondAudio,
        contentType: 'audio/mp3',
        fileName: 'Segundo Audio',
      ),
      FileAttachment(
        thirdAudio,
        contentType: 'audio/mp3',
        fileName: 'Terceiro Audio',
      )
    ];

    final email = await getEmailTeacherFromFirebase(ctx);

    const subject = 'Atividade - Artistas Latinoamericanos 1';
    final text = '''
Proyectemos\n
${allStudentInfo[0]} - ${allStudentInfo[1]} - ${allStudentInfo[2]} - ${allStudentInfo[3]}\n\n 
Atividade Artistas Latinoamericanos 1ª etapa concluída!\nObs: Arquivo mp4.''';
    final emailSender = EmailSender();

    await emailSender.sendEmailToTeacher(
      currentUser,
      attachment,
      [email.first.values.first],
      subject,
      text,
    );
  }

  Future<void> saveArtistasTareaUnoCompleted() async {
    const artistasTareaUnoCompleted = true;
    final preferences = await SharedPreferences.getInstance();
    await preferences.setBool(
      'artistasTareaUnoCompleted',
      artistasTareaUnoCompleted,
    );
  }
}
