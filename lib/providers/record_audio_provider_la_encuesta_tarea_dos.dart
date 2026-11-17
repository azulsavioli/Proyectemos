import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:proyectemos/commons/styles.dart';
import 'package:proyectemos/services/permission_management.dart';
import '../services/storage_management.dart';
import '../services/toast_services.dart';
import 'audio_provider_interface.dart';

class RecordAudioLaEncuestaTareaDosProviderImpl extends ChangeNotifier
    implements AudioProvider {
  final FlutterSoundRecorder _record = FlutterSoundRecorder();
  String _afterRecordingFilePath = '';
  static List<String> recordingsPaths = [];

  late bool isRecording = false;
  bool _recordsDeleted = false;
  bool _isRecorderOpen = false;

  bool get recordsDeleted => _recordsDeleted;
  String get recordedFilePath => _afterRecordingFilePath;

  @override
  List<dynamic> clearOldData() {
    _afterRecordingFilePath = '';
    if (recordingsPaths.length > 3) {
      return recordingsPaths = [];
    }
    notifyListeners();
    return recordingsPaths;
  }

  @override
  void clearAllData() {
    _afterRecordingFilePath = '';
    recordingsPaths = [];
    notifyListeners();
  }

  @override
  Future<void> recordVoice(context) async {
    try {
      final isPermitted = await _checkPermissions();
      if (!isPermitted) {
        showToast(
          context,
          'Permissões de gravação não concedidas.',
          ThemeColors.red,
          ThemeColors.white,
        );
        return;
      }

      // Inicializar o recorder se necessário
      if (!_isRecorderOpen) {
        await _record.openRecorder();
        _isRecorderOpen = true;
      }

      final voiceDirPath = await StorageManagement.getAudioDir;
      final voiceFilePath = StorageManagement.createRecordAudioPath(
        dirPath: voiceDirPath,
        fileName: 'audio_message',
      );

      _afterRecordingFilePath = voiceFilePath;

      await _record.startRecorder(
        toFile: voiceFilePath,
        codec: Codec.aacADTS, // ou Codec.pcm16WAV dependendo do formato desejado
      );

      isRecording = true;
      notifyListeners();
      showToast(
        context,
        'Comenzó la grabación',
        ThemeColors.green,
        ThemeColors.white,
      );
    } catch (e) {
      print('Erro ao gravar áudio: $e');
      showToast(
        context,
        'Erro ao iniciar a gravação de áudio.',
        ThemeColors.red,
        ThemeColors.white,
      );
    }
  }

  Future<bool> _checkPermissions() async {
    final recordingPermission =
    await PermissionManagement.recordingPermission();
    return recordingPermission;
  }

  @override
  Future<void> stopRecording(context) async {
    try {
      if (_record.isRecording) {
        await _record.stopRecorder();
        showToast(
          context,
          'Grabación detenida',
          ThemeColors.green,
          ThemeColors.white,
        );
      }
      isRecording = false;
      notifyListeners();
    } catch (e) {
      print('Erro ao parar gravação: $e');
      showToast(
        context,
        'Erro ao parar a gravação.',
        ThemeColors.red,
        ThemeColors.white,
      );
    }
  }

  @override
  void cancelRecording() {
    _recordsDeleted = true;
    clearOldData();
    notifyListeners();
  }

  @override
  void saveRecording(context) {
    if (_afterRecordingFilePath.isNotEmpty) {
      recordingsPaths.add(_afterRecordingFilePath);
      clearOldData();
      showToast(
        context,
        'Grabación guardada',
        ThemeColors.green,
        ThemeColors.white,
      );
      notifyListeners();
    }
  }

  // Método para liberar recursos quando não for mais necessário
  Future<void> disposeRecorder() async {
    if (_record.isRecording) {
      await _record.stopRecorder();
    }
    if (_isRecorderOpen) {
      await _record.closeRecorder();
      _isRecorderOpen = false;
    }
  }
}

// import 'package:flutter/material.dart';
// import 'package:proyectemos/commons/styles.dart';
// import 'package:proyectemos/services/permission_management.dart';
// // import 'package:record/record.dart';
// import '../services/storage_management.dart';
// import '../services/toast_services.dart';
// import 'audio_provider_interface.dart';
//
// class RecordAudioLaEncuestaTareaDosProviderImpl extends ChangeNotifier
//     implements AudioProvider {
//   final AudioRecorder _record = AudioRecorder();
//   String _afterRecordingFilePath = '';
//   static List<String> recordingsPaths = [];
//
//   late bool isRecording = false;
//   bool _recordsDeleted = false;
//
//   bool get recordsDeleted => _recordsDeleted;
//   String get recordedFilePath => _afterRecordingFilePath;
//
//   @override
//   List<dynamic> clearOldData() {
//     _afterRecordingFilePath = '';
//     if (recordingsPaths.length > 3) {
//       return recordingsPaths = [];
//     }
//     notifyListeners();
//     return recordingsPaths;
//   }
//
//   @override
//   void clearAllData() {
//     _afterRecordingFilePath = '';
//     recordingsPaths = [];
//     notifyListeners();
//   }
//
//   @override
//   Future<void> recordVoice(context) async {
//     try {
//       final isPermitted = await _checkPermissions();
//       if (!isPermitted) {
//         showToast(
//           context,
//           'Permissões de gravação não concedidas.',
//           ThemeColors.red,
//           ThemeColors.white,
//         );
//         return;
//       }
//
//       final voiceDirPath = await StorageManagement.getAudioDir;
//       final voiceFilePath = StorageManagement.createRecordAudioPath(
//         dirPath: voiceDirPath,
//         fileName: 'audio_message',
//       );
//
//       await _record.start(const RecordConfig(), path: voiceFilePath);
//       isRecording = true;
//       notifyListeners();
//       showToast(
//         context,
//         'Comenzó la grabación',
//         ThemeColors.green,
//         ThemeColors.white,
//       );
//     } catch (e) {
//       print('Erro ao gravar áudio: $e');
//       showToast(
//         context,
//         'Erro ao iniciar a gravação de áudio.',
//         ThemeColors.red,
//         ThemeColors.white,
//       );
//     }
//   }
//
//   Future<bool> _checkPermissions() async {
//     final recordingPermission =
//         await PermissionManagement.recordingPermission();
//     return recordingPermission;
//   }
//
//   @override
//   Future<void> stopRecording(context) async {
//     String? audioFilePath;
//
//     if (await _record.isRecording()) {
//       audioFilePath = await _record.stop();
//       showToast(
//         context,
//         'Grabación detenida',
//         ThemeColors.green,
//         ThemeColors.white,
//       );
//     }
//     isRecording = false;
//     _afterRecordingFilePath = audioFilePath ?? '';
//     notifyListeners();
//   }
//
//   @override
//   void cancelRecording() {
//     _recordsDeleted = true;
//     clearOldData();
//     notifyListeners();
//   }
//
//   @override
//   void saveRecording(context) {
//     recordingsPaths.add(_afterRecordingFilePath);
//     clearOldData();
//     showToast(
//       context,
//       'Grabación guardada',
//       ThemeColors.green,
//       ThemeColors.white,
//     );
//     notifyListeners();
//   }
// }
