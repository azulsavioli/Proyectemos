import 'package:google_sign_in/google_sign_in.dart';
import 'package:mailer/mailer.dart';

abstract class Repository<T, U, V> {
  Map<T, T> createJson(
    List<T> answersList,
  );
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
  Future<List<String>> getEmailTeacherFromFirebase();
  Future<List<String>>? getSchoolsInfo();
  Future<List<String>>? getClassRoomInfo(String schoolName);
  Future<List> getTeachersInfo();
  Future<List> getClassesInfo();
}
