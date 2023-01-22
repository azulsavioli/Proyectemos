import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart' hide Table hide Image;
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:provider/provider.dart';
import 'package:proyectemos/utils/latinoamerica_pdf/generate_pdf.dart';
import '../../app/proyectemos_repository.dart';
import '../../services/storage_service.dart';
import '../../commons/google_sign_in.dart';
import 'package:flutter/material.dart';

class TextAnswers {
  final String question;
  final String answer;

  const TextAnswers({required this.question, required this.answer});
}

class LatinoamericaPdf {
  BuildContext context;

  LatinoamericaPdf(
    this.context,
  );

  late String? studentInfo;
  late String proyectemosTitle;
  late String sectionTitle;
  late String taskTitle;
  List answers = [];
  List listImagesLatinoamerica = [];

  getLatinoamericaTaskThreeImages() async {
    final imageList = [];
    final provider = Provider.of<GoogleSignInProvider>(context, listen: false);
    var currentUser = provider.googleSignIn.currentUser;

    if (currentUser == null) {
      provider.googleSignIn.signIn();
      currentUser = provider.googleSignIn.currentUser;
    }

    var storage = StorageService();

    var latinoamericaImage1 = await storage
        .downloadLatinoamericaUrlImg('${currentUser?.email}-img-1.jpeg');
    var latinoamericaImage2 = await storage
        .downloadLatinoamericaUrlImg('${currentUser?.email}-img-2.jpeg');
    var latinoamericaImage3 = await storage
        .downloadLatinoamericaUrlImg('${currentUser?.email}-img-3.jpeg');
    var latinoamericaImage4 = await storage
        .downloadLatinoamericaUrlImg('${currentUser?.email}-img-4.jpeg');
    var latinoamericaImage5 = await storage
        .downloadLatinoamericaUrlImg('${currentUser?.email}-img-5.jpeg');
    var latinoamericaImage6 = await storage
        .downloadLatinoamericaUrlImg('${currentUser?.email}-img-6.jpeg');
    var latinoamericaImage7 = await storage
        .downloadLatinoamericaUrlImg('${currentUser?.email}-img-7.jpeg');
    var latinoamericaImage8 = await storage
        .downloadLatinoamericaUrlImg('${currentUser?.email}-img-8.jpeg');
    var latinoamericaImage9 = await storage
        .downloadLatinoamericaUrlImg('${currentUser?.email}-img-9.jpeg');
    var latinoamericaImage10 = await storage
        .downloadLatinoamericaUrlImg('${currentUser?.email}-img-10.jpeg');

    try {
      final netImage1 =
          await flutterImageProvider(NetworkImage(latinoamericaImage1));
      final netImage2 =
          await flutterImageProvider(NetworkImage(latinoamericaImage2));
      final netImage3 =
          await flutterImageProvider(NetworkImage(latinoamericaImage3));
      final netImage4 =
          await flutterImageProvider(NetworkImage(latinoamericaImage4));
      final netImage5 =
          await flutterImageProvider(NetworkImage(latinoamericaImage5));
      final netImage6 =
          await flutterImageProvider(NetworkImage(latinoamericaImage6));
      final netImage7 =
          await flutterImageProvider(NetworkImage(latinoamericaImage7));
      final netImage8 =
          await flutterImageProvider(NetworkImage(latinoamericaImage8));
      final netImage9 =
          await flutterImageProvider(NetworkImage(latinoamericaImage9));
      final netImage10 =
          await flutterImageProvider(NetworkImage(latinoamericaImage10));

      imageList.addAll([
        netImage1,
        netImage2,
        netImage3,
        netImage4,
        netImage5,
        netImage6,
        netImage7,
        netImage8,
        netImage9,
        netImage10,
      ]);

      for (var i = 1; i <= 10; i++) {
        storage
            .deleteLatinoamericaImageFiles('${currentUser?.email}-img-$i.jpeg');
      }
      return imageList;
    } catch (e) {
      return "Error de conversão para ImageProvider: ${e.toString()}";
    }
  }

  createPDF() async {
    proyectemosTitle = "Proyectemos";
    sectionTitle = 'Uno';
    taskTitle = "Latinoamerica";
    final studentInfo = context.read<ProyectemosRepository>().getUserInfo();
    var studentInformation = studentInfo.split('/');

    var allAnswers = await getAnswersFromFirebase();

    final DateTime data = DateTime.now();
    final DateFormat formatter = DateFormat('dd/MM/yyyy');
    final String dataFormatada = formatter.format(data);
    final imageAnswersTaskThree = await getLatinoamericaTaskThreeImages();

    final infoPdfHeader = [
      proyectemosTitle,
      sectionTitle,
      taskTitle,
    ];

    final allStudentInfo = [
      studentInformation[3],
      studentInformation[0],
      studentInformation[1],
    ];

    return await generatePdf(
      PdfPageFormat.a4,
      allAnswers,
      infoPdfHeader,
      allStudentInfo,
      imageAnswersTaskThree,
      dataFormatada,
    );
  }

  Future<List> getAnswersFromFirebase() async {
    String doc1 = 'uno/latinoamerica/atividade_1';
    String doc2 = 'uno/latinoamerica/atividade_2';
    String doc3 = 'uno/latinoamerica/atividade_3';

    var repository = context.read<ProyectemosRepository>();

    try {
      var answers1 = await repository.getAnswers(doc1);
      var answers2 = await repository.getAnswers(doc2);
      var answers3 = await repository.getAnswers(doc3);

      answers.addAll([...answers1, ...answers2, ...answers3]);
    } on FirebaseException catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
    return answers;
  }
}
