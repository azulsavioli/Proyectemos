import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';

class EmailSender {
  Future sendEmailToTeacher(
      currentUser, attachment, email, subject, text) async {
    var currentUserEmail = currentUser.email;
    var currentUserName = currentUser.displayName;

    final recipients = email.map((e) => Address(e)).toList();

    final auth = await currentUser.authentication;
    final token = auth.accessToken!;
    final smtpServer = gmailSaslXoauth2(currentUserEmail, token);
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
