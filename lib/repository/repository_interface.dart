import 'package:google_sign_in/google_sign_in.dart';
import 'package:mailer/mailer.dart';

abstract class Repository<T, U, V> {
  Map<T, T> createJson(
    List<T> answersList,
  );
  Future<void> isTaskLoading(T taskName, bool bool);
  Future<void> getStudentInfo();
  Future<void> sendAnswersToFirebase(Map<T, T> json, T doc);
  Future<void> saveTaskCompleted(T taskName);
  Future<void> sendEmail(
    GoogleSignInAccount? currentUser,
    List<T> answersList,
    T subject,
    U message,
    List<Attachment> attachment,
  );
  Future<List<String>>? getSchoolsInfo();
  Future<String> getSchoolId(String schoolNameParams);
  Future<List<String>>? getClassRoomInfo(String schoolName);
  Future<List<String>?> getClassroomStudentNames();
  Future<void> saveClassroomImagesLatinoamerica(Map<T, T> json);
  Future<void> saveClassroomImagesArtistas(Map<T, T> json);
  Future<void> savePublicVideo(Map<T, T> json);
  Future<void> saveClassroomVideo(Map<T, T> json);
  Future<void> saveClassroomStudents(Map<T, T> json);
  Future<void> saveClassroomPodcast(Map<T, T> json);
  Future<void> saveClassroomMovimientoSociale(Map<T, T> json);
  Future<void> saveClassroomMovimientosSocialesVideo(Map<T, T> json);
}
