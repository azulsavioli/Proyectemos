import 'dart:io';

import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class StorageService {
  final firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  Future uploadFile(
    String filePath,
    String filename,
  ) async {
    final file = File(filePath);
    try {
      await storage.ref('images/$filename').putFile(file);
    } on firebase_core.FirebaseException catch (e) {
      return 'Firebase Exception ${e.message} ';
    }
  }

  Future<firebase_storage.ListResult> listImageFiles() async {
    final results = await storage.ref('proyectemos_assets/').listAll();

    return results;
  }

  Future<String> downloadDefaultUrlImg(String imageName) async {
    final downloadUrl =
        await storage.ref('proyectemos_assets/$imageName').getDownloadURL();
    return downloadUrl;
  }

  Future<firebase_storage.ListResult> listLatinoamericaImageFiles() async {
    final results = await storage.ref('uno-latinoamerica-images/').listAll();

    return results;
  }

  Future<String> downloadLatinoamericaUrlImg(String imageName) async {
    final downloadUrl = await storage
        .ref('uno-latinoamerica-images/$imageName')
        .getDownloadURL();
    return downloadUrl;
  }

  Future<void> deleteLatinoamericaImageFiles(String imageName) async {
    // Create a reference to the file to delete
    final desertRef =
        storage.ref().child('uno-latinoamerica-images/$imageName');
    // Delete the file
    await desertRef.delete();
  }
}
