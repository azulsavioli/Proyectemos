// abstract class AudioProvider {
//   List<dynamic> clearOldData();
//
//   Future<void> recordVoice(context);
//
//   Future<void> stopRecording(context);
//
//   void clearAllData();
//
//   void cancelRecording();
//
//   void saveRecording(context);
// }

abstract class AudioProvider {
  List<dynamic> clearOldData();

  Future<void> recordVoice(context);

  Future<void> stopRecording(context);

  void clearAllData();

  void cancelRecording();

  void saveRecording(context);
}