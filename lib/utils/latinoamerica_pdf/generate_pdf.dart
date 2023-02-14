import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import '../../commons/strings_latinoamerica.dart';

const PdfColor red = PdfColor.fromInt(0xfff30146);
const PdfColor white = PdfColor.fromInt(0xffffffff);
const sep = 120.0;

Future<File> saveDocument({
  required String name,
  required pw.Document pdf,
}) async {
  final bytes = await pdf.save();
  final dir = await getApplicationDocumentsDirectory();
  final file = File('${dir.path}/$name');

  await file.writeAsBytes(bytes);
  return file;
}

Future<File> generatePdf(
  PdfPageFormat format,
  allAnswers,
  List<String> infoPdfHeader,
  List<String?> studentInfo,
  List latinoamericaImages,
  String dataFormatada,
) async {
  final doc = pw.Document(title: 'Atividade-Latinoamerica', author: 'Maia');

  final answerTask1 = allAnswers[0];
  final answerTask2 = allAnswers[1];
  final answerTask3 = allAnswers[2];

  final profileImage = pw.MemoryImage(
    (await rootBundle.load('assets/images/logo.png')).buffer.asUint8List(),
  );

  final pageTheme = await _myPageTheme(format);

  doc.addPage(
    pw.MultiPage(
      pageTheme: pageTheme,
      build: (pw.Context context) => [
        pw.Partitions(
          children: [
            pw.Partition(
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: <pw.Widget>[
                  pw.Container(
                    padding: const pw.EdgeInsets.only(bottom: 20),
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: <pw.Widget>[
                        pw.Text(
                          'Proyectemos',
                          textScaleFactor: 2,
                          style: pw.Theme.of(context)
                              .defaultTextStyle
                              .copyWith(fontWeight: pw.FontWeight.bold),
                        ),
                        pw.Padding(padding: const pw.EdgeInsets.only(top: 10)),
                        pw.Text(
                          'Uno - Latinoamerica',
                          textScaleFactor: 1.2,
                          style: pw.Theme.of(context).defaultTextStyle.copyWith(
                                fontWeight: pw.FontWeight.bold,
                                color: red,
                              ),
                        ),
                        pw.Padding(padding: const pw.EdgeInsets.only(top: 20)),
                        pw.Row(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                          children: <pw.Widget>[
                            pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: <pw.Widget>[
                                pw.Text('Aluno: '),
                                pw.Text('Escola: '),
                                pw.Text('Série: '),
                                pw.Text(dataFormatada),
                              ],
                            ),
                            pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: <pw.Widget>[
                                pw.Text(studentInfo[0]!),
                                pw.Text(studentInfo[1]!),
                                pw.Text(studentInfo[2]!),
                              ],
                            ),
                            pw.Padding(padding: pw.EdgeInsets.zero)
                          ],
                        ),
                      ],
                    ),
                  ),
                  _Category(title: 'Atividade 1'),
                  _Block(
                    title: StringsLationamerica.qOneLatinPageOne,
                    answer: '${answerTask1['resposta_1']}',
                  ),
                  _Block(
                    title: StringsLationamerica.qTwoLatinPageOne,
                    answer: '${answerTask1['resposta_2']}',
                  ),
                  pw.SizedBox(height: 20),
                  _Category(title: 'Atividade 2'),
                  _Block(
                    title: StringsLationamerica.qOneLationPageTwo,
                    answer: '${answerTask2['resposta_1']}',
                  ),
                  _Block(
                    title: StringsLationamerica.qTwoLatinPageTwo,
                    answer: '${answerTask2['resposta_2']}',
                  ),
                  _Block(
                    title: StringsLationamerica.qThreeLatinPageTwo,
                    answer: '${answerTask2['resposta_3']}',
                  ),
                  pw.SizedBox(height: 20),
                  _Category(title: 'Atividade 3'),
                  _Block(
                    title: 'Descrição da imagem 1:',
                    answer: '${answerTask3['resposta_1'][0]}',
                  ),
                  _ImageBlock(image: latinoamericaImages[0]),
                  _Block(
                    title: 'Descrição da imagem 2:',
                    answer: '${answerTask3['resposta_2'][0]}',
                  ),
                  _ImageBlock(image: latinoamericaImages[1]),
                  _Block(
                    title: 'Descrição da imagem 3:',
                    answer: '${answerTask3['resposta_3'][0]}',
                  ),
                  _ImageBlock(image: latinoamericaImages[2]),
                  _Block(
                    title: 'Descrição da imagem 4:',
                    answer: '${answerTask3['resposta_4'][0]}',
                  ),
                  _ImageBlock(image: latinoamericaImages[3]),
                  _Block(
                    title: 'Descrição da imagem 5:',
                    answer: '${answerTask3['resposta_5'][0]}',
                  ),
                  _ImageBlock(image: latinoamericaImages[4]),
                  _Block(
                    title: 'Descrição da imagem 6:',
                    answer: '${answerTask3['resposta_6'][0]}',
                  ),
                  _ImageBlock(image: latinoamericaImages[5]),
                  _Block(
                    title: 'Descrição da imagem 7:',
                    answer: '${answerTask3['resposta_7'][0]}',
                  ),
                  _ImageBlock(image: latinoamericaImages[6]),
                  _Block(
                    title: 'Descrição da imagem 8:',
                    answer: '${answerTask3['resposta_8'][0]}',
                  ),
                  _ImageBlock(image: latinoamericaImages[7]),
                  _Block(
                    title: 'Descrição da imagem 9:',
                    answer: '${answerTask3['resposta_9'][0]}',
                  ),
                  _ImageBlock(image: latinoamericaImages[8]),
                  _Block(
                    title: 'Descrição da imagem 10:',
                    answer: '${answerTask3['resposta_10'][0]}',
                  ),
                  _ImageBlock(image: latinoamericaImages[9]),
                ],
              ),
            ),
            pw.Partition(
              width: sep,
              child: pw.Column(
                children: [
                  pw.Container(
                    height: pageTheme.pageFormat.availableHeight,
                    child: pw.Column(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: <pw.Widget>[
                        pw.ClipOval(
                          child: pw.Container(
                            width: 50,
                            height: 50,
                            color: red,
                            child: pw.Image(profileImage),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    ),
  );
  return saveDocument(name: 'Atividade-Latinoamerica.pdf', pdf: doc);
}

Future<pw.PageTheme> _myPageTheme(PdfPageFormat format) async {
  final bgShape = await rootBundle.loadString('assets/images/detalhered.svg');

  format.applyMargin(
    left: 2.0 * PdfPageFormat.cm,
    top: 4.0 * PdfPageFormat.cm,
    right: 2.0 * PdfPageFormat.cm,
    bottom: 2.0 * PdfPageFormat.cm,
  );

  return pw.PageTheme(
    pageFormat: format,
    theme: pw.ThemeData.withFont(
      base: await PdfGoogleFonts.openSansRegular(),
      bold: await PdfGoogleFonts.openSansBold(),
      icons: await PdfGoogleFonts.materialIcons(),
    ),
    buildBackground: (pw.Context context) {
      return pw.FullPage(
        ignoreMargins: true,
        child: pw.Stack(
          children: [
            pw.Positioned(
              child: pw.SvgImage(svg: bgShape),
              left: 0,
              top: 0,
            ),
            pw.Positioned(
              child: pw.Transform.rotate(
                angle: pi,
                child: pw.SvgImage(svg: bgShape),
              ),
              right: 0,
              bottom: 0,
            ),
          ],
        ),
      );
    },
  );
}

class _Block extends pw.StatelessWidget {
  _Block({
    required this.title,
    required this.answer,
  });

  final String title;
  final String answer;

  @override
  pw.Widget build(pw.Context context) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: <pw.Widget>[
        pw.Row(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: <pw.Widget>[
            pw.Container(
              width: 6,
              height: 6,
              margin: const pw.EdgeInsets.only(top: 5.5, left: 2, right: 5),
              decoration: const pw.BoxDecoration(
                color: red,
                shape: pw.BoxShape.circle,
              ),
            ),
            pw.Text(
              title,
              style: pw.Theme.of(context)
                  .defaultTextStyle
                  .copyWith(fontWeight: pw.FontWeight.bold),
            ),
            pw.Spacer(),
          ],
        ),
        pw.Container(
          width: 800,
          decoration: const pw.BoxDecoration(
            border: pw.Border(left: pw.BorderSide(color: red, width: 2)),
          ),
          padding: const pw.EdgeInsets.only(left: 10, top: 5, bottom: 5),
          margin: const pw.EdgeInsets.only(left: 5),
          child: pw.Text(answer),
        ),
      ],
    );
  }
}

class _ImageBlock extends pw.StatelessWidget {
  _ImageBlock({
    required this.image,
  });

  final pw.ImageProvider image;

  @override
  pw.Widget build(pw.Context context) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: <pw.Widget>[
        pw.Container(
          decoration: const pw.BoxDecoration(
            border: pw.Border(
              left: pw.BorderSide(color: red, width: 2),
            ),
          ),
          padding: const pw.EdgeInsets.only(left: 10, top: 5, bottom: 5),
          margin: const pw.EdgeInsets.only(left: 5),
          child: pw.Column(
            children: [
              pw.Image(
                image,
                width: 300,
                height: 300,
              ),
              pw.SizedBox(height: 30),
            ],
          ),
        ),
      ],
    );
  }
}

class _Category extends pw.StatelessWidget {
  _Category({required this.title});

  final String title;

  @override
  pw.Widget build(pw.Context context) {
    return pw.Container(
      decoration: const pw.BoxDecoration(
        color: red,
        borderRadius: pw.BorderRadius.all(pw.Radius.circular(6)),
      ),
      margin: const pw.EdgeInsets.only(bottom: 10, top: 20),
      padding: const pw.EdgeInsets.fromLTRB(10, 4, 10, 4),
      child: pw.Text(
        style: const pw.TextStyle(color: white),
        title,
        textScaleFactor: 1.5,
      ),
    );
  }
}
