import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart' hide Table hide Image;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:provider/provider.dart';
import 'package:proyectemos/utils/get_user.dart';
import 'package:proyectemos/utils/latinoamerica_pdf/generate_pdf.dart';

import '../../repository/proyectemos_repository.dart';
import '../../services/storage_service.dart';

class TextAnswers {
  const TextAnswers({required this.question, required this.answer});

  final String answer;
  final String question;
}

class LatinoamericaPdf {
  LatinoamericaPdf(
    this.context,
  );

  List answers = [];
  BuildContext context;
  List listImagesLatinoamerica = [];
  late String proyectemosTitle;
  late String sectionTitle;
  late String? studentInfo;
  late String taskTitle;

  Future<dynamic> getLatinoamericaTaskThreeImages() async {
    final imageList = [];
    final currentUser = getCurrentUser(context);

    final storage = StorageService();

    final latinoamericaImage1 = await storage
        .downloadLatinoamericaUrlImg('${currentUser?.email}-img-1.jpeg');
    final latinoamericaImage2 = await storage
        .downloadLatinoamericaUrlImg('${currentUser?.email}-img-2.jpeg');
    final latinoamericaImage3 = await storage
        .downloadLatinoamericaUrlImg('${currentUser?.email}-img-3.jpeg');
    final latinoamericaImage4 = await storage
        .downloadLatinoamericaUrlImg('${currentUser?.email}-img-4.jpeg');
    final latinoamericaImage5 = await storage
        .downloadLatinoamericaUrlImg('${currentUser?.email}-img-5.jpeg');
    final latinoamericaImage6 = await storage
        .downloadLatinoamericaUrlImg('${currentUser?.email}-img-6.jpeg');
    final latinoamericaImage7 = await storage
        .downloadLatinoamericaUrlImg('${currentUser?.email}-img-7.jpeg');
    final latinoamericaImage8 = await storage
        .downloadLatinoamericaUrlImg('${currentUser?.email}-img-8.jpeg');
    final latinoamericaImage9 = await storage
        .downloadLatinoamericaUrlImg('${currentUser?.email}-img-9.jpeg');
    final latinoamericaImage10 = await storage
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
        await storage
            .deleteLatinoamericaImageFiles('${currentUser?.email}-img-$i.jpeg');
      }
      return imageList;
    } catch (e) {
      return 'Error de conversão para ImageProvider: $e';
    }
  }

  Future<File> createPDF() async {
    proyectemosTitle = 'Proyectemos';
    sectionTitle = 'Uno';
    taskTitle = 'Latinoamerica';
    final studentInfo =
        await context.read<ProyectemosRepository>().getUserInfo();
    final studentInformation = studentInfo.split('/');

    final allAnswers = await getAnswersFromFirebase();

    final data = DateTime.now();
    final formatter = DateFormat('dd/MM/yyyy');
    final dataFormatada = formatter.format(data);
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
      studentInformation[2]
    ];

    return generatePdf(
      PdfPageFormat.a4,
      allAnswers,
      infoPdfHeader,
      allStudentInfo,
      imageAnswersTaskThree,
      dataFormatada,
    );
  }

  Future<List> getAnswersFromFirebase() async {
    const doc3 = 'uno/latinoamerica/atividade_3';

    final repository = context.read<ProyectemosRepository>();

    try {
      final answers1 = await repository.getAnswers(doc3);
      answers.addAll([
        ...answers1,
      ]);
    } on FirebaseException catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
    return answers;
  }
}
