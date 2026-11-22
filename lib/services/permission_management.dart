import 'package:permission_handler/permission_handler.dart';

enum MicrophoneAccess { granted, denied, permanentlyDenied }

class PermissionManagement {
  static Future<bool> storagePermission() async {
    final status = await Permission.storage.request();
    return status == PermissionStatus.granted;
  }

  static Future<bool> recordingPermission() async {
    final access = await microphoneAccess();
    return access == MicrophoneAccess.granted;
  }

  /// Asks for the microphone only after the caller has explained why.
  /// A permanent denial is reported without showing the system dialog again.
  static Future<MicrophoneAccess> microphoneAccess() async {
    var status = await Permission.microphone.status;
    if (status.isPermanentlyDenied || status.isRestricted) {
      return MicrophoneAccess.permanentlyDenied;
    }
    if (!status.isGranted) {
      status = await Permission.microphone.request();
    }
    if (status.isGranted) return MicrophoneAccess.granted;
    if (status.isPermanentlyDenied || status.isRestricted) {
      return MicrophoneAccess.permanentlyDenied;
    }
    return MicrophoneAccess.denied;
  }

  static Future<bool> openSettings() => openAppSettings();
}
