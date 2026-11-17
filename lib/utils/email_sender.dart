import 'package:google_sign_in/google_sign_in.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';

class EmailSender {
  Future sendEmailToTeacher(
      GoogleSignInAccount? currentUser,
      List<Attachment> attachment,
      List<String> email,
      String subject,
      String text,
      ) async {
    var user = currentUser;

    if (user == null) {
      // Usa a instância singleton
      user = await GoogleSignIn.instance.authenticate(
        scopeHint: ['https://mail.google.com/'],
      );
    }

    final currentUserEmail = user.email;
    final currentUserName = user.displayName;

    final recipients = email.map(Address.new).toList();

    final authClient = user.authorizationClient;
    final headers =
    await authClient.authorizationHeaders(['https://mail.google.com/']);
    final token = headers?['Authorization']?.split(' ').last;

    if (token == null) {
      throw Exception('Não foi possível obter o token OAuth2.');
    }

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
