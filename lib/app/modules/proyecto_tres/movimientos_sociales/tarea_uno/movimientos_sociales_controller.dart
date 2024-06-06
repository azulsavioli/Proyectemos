import 'dart:io';
import 'dart:math';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mailer/mailer.dart';

import '../../../../../commons/strings/strings.dart';
import '../../../../../repository/repository_impl.dart';
import '../../../../../services/toast_services.dart';

class MovimientosSocialesController extends ChangeNotifier {
  final _repository = RepositoryImpl();
  final subject = 'Atividade 1 - Movimientos Sociales';
  final doc = 'tres/movimientos_sociales/atividade_1/';
  final task = 'movimientosSocialesCompleted';
  List studentGroup = [];
  String randonMovimientos = '';
  PlatformFile? pickedFile;

  void randomMovimiento() {
    const listCountrys = [
      '#NiUnaMenos',
      '#BlackLivesMatter',
      '#MeToo',
    ];

    while (randonMovimientos.length < 1) {
      final randomNumber = Random().nextInt(3);
      final movimiento = listCountrys[randomNumber];
      randonMovimientos = movimiento;
    }
  }

  Future selectFile() async {
    final fileSelected = await FilePicker.platform.pickFiles();
    if (fileSelected == null) return;
    pickedFile = fileSelected.files.first;

    return pickedFile;
  }

  Future makeJson(currentUser) async {
    final firebasePaths = await convertVideoToFirebase();

    final json = {
      'grupo': '$studentGroup',
      'video_grupo': firebasePaths[0],
    };
    return json;
  }

  List<String?> setFiles() {
    final filePaths = <String?>[];
    if (pickedFile != null) {
      filePaths.add(pickedFile?.path);
    }
    return filePaths;
  }

  Future convertVideoToFirebase() async {
    final firebaseStorage = FirebaseStorage.instance;
    final firebasePaths = [];
    final videoPaths = pickedFile?.path;

    final email = _repository.authService.userAuth?.email;

    try {
      if (videoPaths == null || videoPaths == '') return;
      final file = File(videoPaths);

      final snapshot = await firebaseStorage
          .ref()
          .child(
            'tres-video-movimientos-sociales/$email-video.mp4',
          )
          .putFile(file)
          .whenComplete(() => null);

      final downloadUrl = await snapshot.ref.getDownloadURL();

      firebasePaths.add(downloadUrl);

      return firebasePaths;
    } on PlatformException catch (e) {
      return 'Failed to convert video: ${e.message}';
    }
  }

  Future<void> sendAnswers(
    GoogleSignInAccount? currentUser,
  ) async {
    await _repository.isTaskLoading(task, true);

    try {
      final json = await makeJson(currentUser);

      final message = createEmailMessage(
        await _repository.getStudentInfo(),
      );

      final attachment = createVideoAttachments();

      await _repository.sendEmail(
        currentUser,
        [],
        subject,
        message,
        attachment,
      );

      await _repository.sendAnswersToFirebase(json, doc);
      await _repository.saveTaskCompleted(task);
      await _repository.saveClassroomMovimientosSocialesVideo(json);
      await _repository.isTaskLoading(task, false);

      showToast(Strings.tareaEnviada);

      notifyListeners();
    } on FirebaseException catch (e) {
      e.toString();
      showToast('Ocurrio un erro no envio dos datos!');
    }
  }

  List<FileAttachment> createVideoAttachments() {
    final filePathList = setFiles();

    final firstArchive = File(filePathList[0]!);

    final attachment = [
      FileAttachment(firstArchive, fileName: 'Video_movimientos_sociales.mp4'),
    ];

    return attachment;
  }

  String createEmailMessage(
    List<String> allStudentInfo,
  ) {
    final text = '''
Proyectemos\n
Aluno: ${allStudentInfo[0]}\n
Escola: ${allStudentInfo[1]} - Turma: ${allStudentInfo[2]}\n 
Atividade Movimentos Sociais concluída!\nObs: Arquivo mp4.''';
    return text;
  }
}
