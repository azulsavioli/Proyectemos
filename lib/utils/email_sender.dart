import 'package:google_sign_in/google_sign_in.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';

class EmailSender {
  Future sendEmailToTeacher(
    GoogleSignInAccount? currentUser,
    List<FileAttachment> attachment,
    List<String> email,
    String subject,
    String text,
  ) async {
    final currentUserEmail = currentUser?.email;
    final currentUserName = currentUser?.displayName;

    final recipients = email.map(Address.new).toList();

    final auth = await currentUser?.authentication;
    final token = auth?.accessToken;
    final smtpServer = gmailSaslXoauth2(currentUserEmail!, token!);
    final message = Message()
      ..attachments = attachment
      ..from = Address(currentUserEmail, currentUserName)
      ..recipients = recipients
      ..subject = subject
      ..text = text;
    try {
      await send(message, smtpServer);
    } on MailerException catch (e) {
      return e;
    }
  }
}
