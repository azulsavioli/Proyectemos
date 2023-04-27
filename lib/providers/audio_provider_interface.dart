abstract class AudioProvider {
  List<dynamic> clearOldData();

  Future<void> recordVoice();

  Future<void> stopRecording();

  void clearAllData();

  void cancelRecording();

  void saveRecording();
}
