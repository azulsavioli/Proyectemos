import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mailer/mailer.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../commons/strings.dart';
import '../../../../commons/strings_divulgacao.dart';
import '../../../../commons/styles.dart';
import '../../../../repository/proyectemos_repository.dart';
import '../../../../services/firebase/firebase_converter.dart';
import '../../../../services/tasks_completed.dart';
import '../../../../services/toast_services.dart';
import '../../../../utils/email_sender.dart';
import '../../../../utils/get_user.dart';
import '../../widgets/drawer_menu.dart';

class DivulgacaoPage extends StatefulWidget {
  const DivulgacaoPage({super.key});

  @override
  State<DivulgacaoPage> createState() => _DivulgacaoPageState();
}

enum OpcoesCompartilhamento { turma, todos }

class _DivulgacaoPageState extends State<DivulgacaoPage> {
  bool divulgacao = false;

  OpcoesCompartilhamento? sendingType = OpcoesCompartilhamento.todos;

  bool isButtonDisabled = false;

  bool buttonFileSelected = false;
  Icon buttonFileIcon = const Icon(Icons.file_copy);
  Color buttonFileColor = ThemeColors.blue;

  PlatformFile? pickedFile;

  Future selectFile() async {
    final fileSelected = await FilePicker.platform.pickFiles();
    if (fileSelected == null) return;

    setState(() {
      pickedFile = fileSelected.files.first;
      buttonFileColor = ThemeColors.green;
      buttonFileIcon = const Icon(Icons.check);
      buttonFileSelected = true;
    });

    return pickedFile;
  }

  Future makeJson() async {
    final user = getCurrentUser(context);
    final email = user?.email;
    final path = pickedFile?.path;

    final firebasePaths = await FirebaseConverter.convertFileToFirebase(
      [path!],
      context,
      'uno-video_divulgacao/$email-video.jpeg',
    );
    final json = {
      'aluno': user?.displayName,
      'resposta_1': firebasePaths[0],
    };
    return json;
  }

  Future<dynamic> sendAnswers(OpcoesCompartilhamento sendingType) async {
    final json = await makeJson();

    try {
      if (sendingType == OpcoesCompartilhamento.todos) {
        return context.read<ProyectemosRepository>().saveVideosPublic(json);
      } else {
        return context.read<ProyectemosRepository>().saveVideosTurma(json);
      }
    } on FirebaseException catch (e) {
      return e.toString();
    }
  }

  Future<List> getEmailTeacherFromFirebase() async {
    final emails = [];
    const doc = 'professora';
    final repository = context.read<ProyectemosRepository>();

    try {
      final data = await repository.getTeacherEmail(doc);
      emails.addAll(data);
    } on FirebaseException catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
    return emails;
  }

  List<String?> setFiles() {
    final filePaths = <String?>[];
    if (pickedFile != null) {
      filePaths.add(pickedFile?.path);
    }
    return filePaths;
  }

  Future<void> sendEmail(GoogleSignInAccount currentUser) async {
    final email = await getEmailTeacherFromFirebase();

    final studentInfo =
        await context.read<ProyectemosRepository>().getUserInfo();
    final studentInformation = studentInfo.split('/');

    final filePathList = setFiles();

    final firstArchive = File(filePathList[0]!);

    final allStudentInfo = [
      studentInformation[3],
      studentInformation[0],
      studentInformation[1],
      studentInformation[2]
    ];

    final attachment = [
      FileAttachment(firstArchive, fileName: 'Video_evento_cultural'),
    ];

    const subject = 'Video evento cultural';
    final text = '''
Proyectemos\n
${allStudentInfo[0]} - ${allStudentInfo[1]} - ${allStudentInfo[2]} - ${allStudentInfo[3]}\n\n 
Video do Evento Cultural ''';
    final emailSender = EmailSender();

    await emailSender.sendEmailToTeacher(
      currentUser,
      attachment,
      [email.first.values.first],
      subject,
      text,
    );
  }

  @override
  Widget build(BuildContext context) {
    Future<void> getTaskCompleted() async {
      final resultado =
          await TasksCompletedService.getUnoDivulgationCompletedInfo();

      setState(() {
        divulgacao = resultado[0];
      });
    }

    final currentUser = getCurrentUser(context);

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
          Strings.titleDivulgacionUno,
          style: ThemeText.paragraph16WhiteBold,
        ),
      ),
      endDrawer: const DrawerMenuWidget(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
          child: Column(
            children: [
              Text(
                StringsDivulgacao.descricaoDivulgacaoTarea,
                style: ThemeText.paragraph16GrayNormal,
              ),
              Text(
                StringsDivulgacao.descricaoDibulgacaoCompartir,
                style: ThemeText.paragraph16GrayNormal,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: RadioListTile<OpcoesCompartilhamento>(
                        title: const Text('Todos'),
                        value: OpcoesCompartilhamento.todos,
                        groupValue: sendingType,
                        onChanged: (OpcoesCompartilhamento? value) {
                          setState(() {
                            sendingType = value;
                          });
                        },
                      ),
                    ),
                    Expanded(
                      child: RadioListTile<OpcoesCompartilhamento>(
                        title: const Text('Turma'),
                        value: OpcoesCompartilhamento.turma,
                        groupValue: sendingType,
                        onChanged: (OpcoesCompartilhamento? value) {
                          setState(() {
                            sendingType = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              SizedBox(
                height: 60,
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton.icon(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      buttonFileSelected ? ThemeColors.green : ThemeColors.blue,
                    ),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  icon: buttonFileIcon,
                  onPressed: () {
                    selectFile();
                    setState(() {
                      if (pickedFile == null) {
                        isButtonDisabled = false;
                      } else {
                        isButtonDisabled = true;
                      }
                    });
                  },
                  label: Text(
                    'Subir el vídeo',
                    style: ThemeText.paragraph16White,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 60,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(ThemeColors.yellow),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  onPressed: () {
                    if (pickedFile == null) {
                      showToast(
                        '''¡No se puede compartir el video! Selecione el video!''',
                        color: ThemeColors.red,
                        textColor: ThemeColors.white,
                      );
                    } else {
                      if (pickedFile != null) {
                        sendAnswers(sendingType!);
                        sendEmail(currentUser!);
                        saveDivulgationCompleted();
                        saveDivulgationFeedType(sendingType);
                        showToast(Strings.tareaConcluida);
                        Navigator.pushNamed(context, '/proyecto_uno');
                      }
                    }
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Padding(
                        padding: EdgeInsets.all(16),
                        child: Text(
                          '¡Compartir!',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> saveDivulgationFeedType(OpcoesCompartilhamento? feedType) async {
    var feedTurma = false;
    var feedAll = false;
    if (feedType == OpcoesCompartilhamento.turma) {
      feedTurma = true;
    } else {
      feedAll = true;
    }
    final preferences = await SharedPreferences.getInstance();
    await preferences.setBool('feedTurma', feedTurma);
    await preferences.setBool('feedTodos', feedAll);
  }

  Future<void> saveDivulgationCompleted() async {
    const divulgationCompleted = true;
    final preferences = await SharedPreferences.getInstance();
    await preferences.setBool('divulgationCompleted', divulgationCompleted);
  }
}
