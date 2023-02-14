import 'dart:io';
import 'dart:math';

import 'package:path_provider/path_provider.dart';

class StorageManagement {
  static Future<String> makeDirectory({required String dirName}) async {
    final directory = await getExternalStorageDirectory();

    final formattedDirName = '/$dirName/';

    final newDir = await Directory(directory!.path + formattedDirName).create();

    return newDir.path;
  }

  static Future<String> get getAudioDir async => makeDirectory(
        dirName: 'recordings',
      );

  static String createRecordAudioPath({
    required String dirPath,
    required String fileName,
  }) =>
      '''$dirPath${fileName.substring(0, min(fileName.length, 100))}_${DateTime.now()}.aac''';
}
