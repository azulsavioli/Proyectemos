import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FirebaseConverter {
  static Future convertFileToFirebase(
    List<String> filePaths,
    BuildContext context,
    String filename,
  ) async {
    final firebaseStorage = FirebaseStorage.instance;
    final firebasePaths = [];

    try {
      for (final item in filePaths) {
        if (filePaths.isEmpty) return;
        final file = File(item);

        final snapshot = await firebaseStorage
            .ref()
            .child(
              filename,
            )
            .putFile(file)
            .whenComplete(() => null);

        final downloadUrl = await snapshot.ref.getDownloadURL();

        firebasePaths.add(downloadUrl);
      }
      return firebasePaths;
    } on PlatformException catch (e) {
      return 'Failed to convert image: ${e.message}';
    }
  }
}
