import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:proyectemos/commons/strings/strings.dart';
import 'package:proyectemos/commons/styles.dart';
import '../../../../../repository/repository_impl.dart';
import '../../../../../services/toast_services.dart';

class ControllerCrearUnPodcast extends ChangeNotifier {
  final _repository = RepositoryImpl();
  final subject =
      'Atividade - Cómo crear un Podcast - Crear un Podcast\n Tarea Dos';
  final doc = 'dos/como_crear_un_podcast/atividade_2/';
  final task = 'comoCrearPodcastTareaDosCompleted';
  final studentGroup = [];
  List<PlatformFile> files = [];
  PlatformFile? pickedFile;
  String estructuraPodcast = '';

  /// Envia respostas por email e salva no Firebase
  Future<void> sendAnswers(
      BuildContext context,
      GoogleSignInAccount? currentUser,
      List<String> answersList,
      ) async {
    await _repository.isTaskLoading(task, true);

    try {
      final json = _repository.createJson(answersList);

      final message = createEmailMessage(
        await _repository.getStudentInfo(),
        answersList,
      );

      final attachments = createAttachments();

      final teacherEmails = await _repository.getTeacherEmails();
      if (teacherEmails.isEmpty) throw Exception('Nenhum email do professor');

      await _repository.sendEmail(
        currentUser: currentUser,
        subject: subject,
        answerList: [],
        body: message,
        attachments: attachments,
      );

      await _repository.sendAnswersToFirebase(json, doc);
      await _repository.saveTaskCompleted(task);
      await _repository.isTaskLoading(task, false);

      showToast(
        context,
        Strings.tareaEnviada,
        ThemeColors.green,
        ThemeColors.white,
      );

      notifyListeners();
    } catch (e) {
      showToast(
        context,
        'Ocorreu um erro no envio!',
        ThemeColors.red,
        ThemeColors.white,
      );
      debugPrint('Erro no envio do email: $e');
    }
  }

  List<dynamic> createAttachments() {
    final filePathList = setFiles();
    final attachments = <String>[];

    for (var path in filePathList) {
      final file = File(path);
      if (file.existsSync()) {
        attachments.add(file.path);
      }
    }

    return attachments;
  }

  List<String> setFiles() {
    final filePaths = files
        .map((item) => item.path)
        .whereType<String>()
        .toList();
    notifyListeners();
    return filePaths;
  }

  /// Seleciona arquivo usando FilePicker
  Future<PlatformFile?> selectFile() async {
    final fileSelected = await FilePicker.platform.pickFiles();
    if (fileSelected == null) return null;

    pickedFile = fileSelected.files.first;
    files.add(pickedFile!);
    notifyListeners();
    return pickedFile;
  }

  /// Cria lista de respostas
  List<String> makeAnswersList(
      String textOne,
      String textTwo,
      String textThree,
      String textFour,
      ) {
    return [textOne, textTwo, textThree, textFour];
  }

  /// Cria mensagem do email com informações do aluno
  String createEmailMessage(
      List<String> allStudentInfo,
      List<String> respostas,
      ) {
    String studentsNames;

    if (studentGroup.length == 2) {
      studentsNames = '''
Aluno 1: ${studentGroup[0]}
Aluno 2: ${studentGroup[1]}''';
    } else {
      studentsNames = '''
Aluno 1: ${studentGroup[0]}
Aluno 2: ${studentGroup[1]}
Aluno 3: ${studentGroup[2]}''';
    }

    final text = '''
Proyectemos
Aluno: ${allStudentInfo[0]}
Escola: ${allStudentInfo[1]} - Turma: ${allStudentInfo[2]}
Atividade Cómo crear un podcast 2ª tarefa concluída!\n
$studentsNames\n
Resposta: ${respostas[0]}
Resposta: ${respostas[1]}
Resposta: $estructuraPodcast
Resposta: ${respostas[2]}
Resposta: ${respostas[3]}
\nObs: Arquivos diversos
''';
    return text;
  }
}



// import 'dart:io';
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:proyectemos/commons/strings/strings.dart';
// import 'package:proyectemos/commons/styles.dart';
//
// import '../../../../../repository/repository_impl.dart';
// import '../../../../../services/toast_services.dart';
//
// class ControllerCrearUnPodcast extends ChangeNotifier {
//   final _repository = RepositoryImpl();
//   final subject =
//       'Atividade - Cómo crear un Podcast - Crear un Podcast\n Tarea Dos';
//   final doc = 'dos/como_crear_un_podcast/atividade_2/';
//   final task = 'comoCrearPodcastTareaDosCompleted';
//   final studentGroup = [];
//   List<PlatformFile> files = [];
//
//   PlatformFile? pickedFile;
//
//   String estructuraPodcast = '';
//
//   Future<void> sendAnswers(
//       BuildContext context,
//       GoogleSignInAccount? currentUser,
//       List<String> answersList,
//       ) async {
//     await _repository.isTaskLoading(task, true);
//
//     try {
//       final json = _repository.createJson(answersList);
//
//       final message = createEmailMessage(
//         await _repository.getStudentInfo(),
//         answersList,
//       );
//
//       final attachments = createAttachments();
//
//       final teacherEmails = await _repository.getTeacherEmails();
//       if (teacherEmails.isEmpty) throw Exception('Nenhum email do professor');
//
//       await _repository.sendEmail(
//         currentUser,
//         teacherEmails,
//         subject,
//         message,
//         attachments,
//       );
//
//       await _repository.sendAnswersToFirebase(json, doc);
//       await _repository.saveTaskCompleted(task);
//       await _repository.isTaskLoading(task, false);
//
//       showToast(
//         context,
//         Strings.tareaEnviada,
//         ThemeColors.green,
//         ThemeColors.white,
//       );
//
//       notifyListeners();
//     } catch (e) {
//       showToast(
//         context,
//         'Ocorreu um erro no envio!',
//         ThemeColors.red,
//         ThemeColors.white,
//       );
//       debugPrint('Erro no envio do email: $e');
//     }
//   }
//
//
//   // Future<void> sendAnswers(
//   //   BuildContext context,
//   //   GoogleSignInAccount? currentUser,
//   //   List<String> answersList,
//   // ) async {
//   //   await _repository.isTaskLoading(task, true);
//   //
//   //   try {
//   //     final json = _repository.createJson(
//   //       answersList,
//   //     );
//   //
//   //     final message = createEmailMessage(
//   //       await _repository.getStudentInfo(),
//   //       answersList,
//   //     );
//   //     final attachment = createAttachments();
//   //
//   //     await _repository.sendEmail(
//   //       currentUser,
//   //       answersList,
//   //       subject,
//   //       message,
//   //       attachment,
//   //     );
//   //     await _repository.sendAnswersToFirebase(json, doc);
//   //     await _repository.saveTaskCompleted(task);
//   //     await _repository.isTaskLoading(task, false);
//   //     showToast(
//   //       context,
//   //       Strings.tareaEnviada,
//   //       ThemeColors.green,
//   //       ThemeColors.white,
//   //     );
//   //
//   //     notifyListeners();
//   //   } on FirebaseException catch (e) {
//   //     e.toString();
//   //     showToast(
//   //       context,
//   //       'Ocurrio un erro no envio dos datos!',
//   //       ThemeColors.red,
//   //       ThemeColors.white,
//   //     );
//   //   }
//   // }
//
//   // List<FileAttachment> createAttachments() {
//   //   final filePathList = setFiles();
//   //   final firstArchive = File(filePathList[0]);
//   //
//   //   final attachment = [
//   //     FileAttachment(
//   //       firstArchive,
//   //       fileName: 'Identidade Visual',
//   //     ),
//   //   ];
//   //
//   //   return attachment;
//   // }
//
//   List<String> createAttachments() {
//     final filePathList = setFiles();
//     final attachments = <String>[];
//
//     for (var path in filePathList) {
//       final file = File(path);
//       if (file.existsSync()) {
//         attachments.add(file.path);
//       }
//     }
//
//     return attachments;
//   }
//
//   List setFiles() {
//     final filePaths = [];
//     for (final item in files) {
//       filePaths.add(item.path);
//     }
//     notifyListeners();
//     return filePaths;
//   }
//
//   Future selectFile() async {
//     final fileSelected = await FilePicker.platform.pickFiles();
//     if (fileSelected == null) return;
//
//     pickedFile = fileSelected.files.first;
//     files.add(pickedFile!);
//     notifyListeners();
//     return pickedFile;
//   }
//
//   List<String> makeAnswersList(
//     String textOne,
//     String textTwo,
//     String textThree,
//     String textFour,
//   ) {
//     final respostas = [
//       textOne,
//       textTwo,
//       textThree,
//       textFour,
//     ];
//     return respostas;
//   }
//
//   String createEmailMessage(
//     List<String> allStudentInfo,
//     List<String> respostas,
//   ) {
//     var studentsNames = '';
//
//     if (studentGroup.length == 2) {
//       studentsNames = '''
// Aluno 1: ${studentGroup[0]}
// Aluno 2: ${studentGroup[1]}''';
//     } else {
//       studentsNames = '''
// Aluno 1: ${studentGroup[0]}
// Aluno 2: ${studentGroup[1]}
// Aluno 3: ${studentGroup[2]}''';
//     }
//
//     final text = '''
// Proyectemos
// Aluno: ${allStudentInfo[0]}
// Escola: ${allStudentInfo[1]} - Turma: ${allStudentInfo[2]}
// Atividade Cómo crear un podcast 2ª tarefa concluída!\n
// $studentsNames\n
// Resposta: ${respostas[0]}
// Resposta: ${respostas[1]}
// Resposta: $estructuraPodcast
// Resposta: ${respostas[2]}
// Resposta: ${respostas[3]}
// \nObs: Arquivos diversos
// ''';
//     return text;
//   }
// }
