import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_core/firebase_core.dart' as firebase_core;

class StorageService {
  final firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  Future uploadFile(
    String filePath,
    String filename,
  ) async {
    File file = File(filePath);
    try {
      await storage.ref('images/$filename').putFile(file);
    } on firebase_core.FirebaseException catch (e) {
      return 'Firebase Exception ${e.toString()} ';
    }
  }

  Future<firebase_storage.ListResult> listImageFiles() async {
    firebase_storage.ListResult results =
        await storage.ref('proyectemos_assets/').listAll();

    return results;
  }

  Future<String> downloadDefaultUrlImg(String imageName) async {
    String downloadUrl =
        await storage.ref('proyectemos_assets/$imageName').getDownloadURL();
    return downloadUrl;
  }

  Future<firebase_storage.ListResult> listLatinoamericaImageFiles() async {
    firebase_storage.ListResult results =
        await storage.ref('uno-latinoamerica-images/').listAll();

    return results;
  }

  Future<String> downloadLatinoamericaUrlImg(String imageName) async {
    String downloadUrl = await storage
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
