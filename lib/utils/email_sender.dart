import 'package:flutter_mailer/flutter_mailer.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'dart:io';

class EmailSender {
  Future<void> sendEmailToTeacher({
    required GoogleSignInAccount? currentUser,
    required List<String> recipients,
    required String subject,
    required String body,
    required List<String> attachments,
  }) async {
    const gmailSchema = 'com.google.android.gm';
    final isGmailInstalled = await FlutterMailer.isAppInstalled(gmailSchema);

    final mailOptions = MailOptions(
      body: body,
      subject: subject,
      recipients: recipients,
      isHTML: true,
      attachments: attachments,
      appSchema: isGmailInstalled ? gmailSchema : null,
    );

    try {
      final response = await FlutterMailer.send(mailOptions);

      switch (response) {
        case MailerResponse.saved:
          break;
        case MailerResponse.sent:
          break;
        case MailerResponse.cancelled:
          break;
        case MailerResponse.android:
          break;
        default:
      }
    } catch (e) {
      rethrow;
    }
  }
}



// import 'package:google_sign_in/google_sign_in.dart';
//
// class EmailSender {
//   Future sendEmailToTeacher(
//       GoogleSignInAccount? currentUser,
//       List<Attachment> attachment,
//       List<String> email,
//       String subject,
//       String text,
//       ) async {
//     var user = currentUser;
//
//     if (user == null) {
//       // Usa a instância singleton
//       user = await GoogleSignIn.instance.authenticate(
//         scopeHint: ['https://mail.google.com/'],
//       );
//     }
//
//     final currentUserEmail = user.email;
//     final currentUserName = user.displayName;
//
//     final recipients = email.map(Address.new).toList();
//
//     final authClient = user.authorizationClient;
//     final headers =
//     await authClient.authorizationHeaders(['https://mail.google.com/']);
//     final token = headers?['Authorization']?.split(' ').last;
//
//     if (token == null) {
//       throw Exception('Não foi possível obter o token OAuth2.');
//     }
//
//     final smtpServer = gmailSaslXoauth2(currentUserEmail, token);
//     final message = Message()
//       ..attachments = attachment
//       ..from = Address(currentUserEmail, currentUserName)
//       ..recipients = recipients
//       ..subject = subject
//       ..text = text;
//
//     try {
//       await send(message, smtpServer);
//     } on MailerException catch (e) {
//       return e;
//     }
//   }
// }
