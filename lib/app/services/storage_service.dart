import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_core/firebase_core.dart' as firebase_core;

class StorageService {
  final firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  Future<void> uploadFile(
    String filePath,
    String filename,
  ) async {
    File file = File(filePath);
    try {
      await storage.ref('images/$filename').putFile(file);
    } on firebase_core.FirebaseException catch (e) {
      print(e);
    }
  }

  Future<firebase_storage.ListResult> listVideosFiles() async {
    firebase_storage.ListResult results =
        await storage.ref('proyectemos_videos/').listAll();

    return results;
  }

  Future<firebase_storage.ListResult> listImageFiles() async {
    firebase_storage.ListResult results =
        await storage.ref('proyectemos_assets/').listAll();

    return results;
  }

  Future<String> downloadUrlImg(String imageName) async {
    String downloadUrl =
        await storage.ref('proyectemos_assets/$imageName').getDownloadURL();
    return downloadUrl;
  }

  Future<String> downloadUrlVideo(String videoName) async {
    String downloadUrl =
        await storage.ref('proyectemos_videos/$videoName').getDownloadURL();
    return downloadUrl;
  }

  Future<String> getVideo() async {
    String video = await downloadUrlVideo('LosCoyotes.mp4');
    return video;
  }
}
