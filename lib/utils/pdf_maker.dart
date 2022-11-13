import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import '../app/proyectemos_repository.dart';

class PdfMaker {
  BuildContext context;

  PdfMaker(this.context);

  late String? studentInfo;
  late String proyectemosTitle;
  late String titleInfo;

  Future<File> createPDF() async {
    try {
      final PdfDocument document = PdfDocument();

      final pdfDocument = document.pages.add();

      studentInfo = context.read<ProyectemosRepository>().getUserInfo();

      var studentInformation = studentInfo?.split('/');

      final studentInfoString =
          "\n\nEscola: ${studentInformation?[0]} - Série: ${studentInformation?[1]} - Turma: ${studentInformation?[2]}\n\nEducando: ${studentInformation?[3]}";

      proyectemosTitle = "Proyectemos";

      titleInfo = "\n\nLatinoamerica";

      pdfDocument.graphics.drawString(
          proyectemosTitle, PdfStandardFont(PdfFontFamily.helvetica, 18));

      pdfDocument.graphics
          .drawString(titleInfo, PdfStandardFont(PdfFontFamily.helvetica, 15));

      pdfDocument.graphics.drawString(
          studentInfoString, PdfStandardFont(PdfFontFamily.helvetica, 12));

      final fileName =
          "proyectemos_${studentInformation?[0]}_${studentInformation?[1]}_${studentInformation?[2]}_${studentInformation?[3]}_latinoamerica.pdf";

      List<int> bytes = await document.save();

      final path = (await getExternalStorageDirectory())?.path;

      final file = File('$path/$fileName');

      document.dispose();

      return file.writeAsBytes(bytes, flush: true);
    } on FirebaseException catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
      rethrow;
    }
  }
}
