import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../commons/strings.dart';
import '../../../../commons/styles.dart';
import '../../../proyectemos_repository.dart';
import '../../widgets/drawer_menu.dart';

class FeedbackPage extends StatefulWidget {
  const FeedbackPage({
    super.key,
  });

  @override
  State<FeedbackPage> createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  String feedback = '';

  Future<List> getFeedbackFromFirebase() async {
    final feedback = [];
    const doc = 'uno/feedback/evento_cultural';
    final repository = context.read<ProyectemosRepository>();

    try {
      final data = await repository.getAnswers(doc);
      feedback.addAll(data);
    } on FirebaseException catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
    return feedback;
  }

  @override
  void initState() {
    startFeedback();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: ThemeColors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: Color.fromRGBO(250, 251, 250, 1),
        ),
        title: const Text(
          Strings.titleFeedbackEventoUno,
          style: ThemeText.paragraph16WhiteBold,
        ),
      ),
      endDrawer: const DrawerMenuWidget(),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 30, 16, 16),
        child: Column(
          children: [
            const Center(
              child: Text(
                Strings.titleEventoCulturalUno,
                style: ThemeText.paragraph16BlueBold,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              feedback,
              style: ThemeText.paragraph16GrayNormal,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> startFeedback() async {
    final feedbackFirebase = await getFeedbackFromFirebase();
    final feedbackItem = feedbackFirebase[0];
    setState(() {
      feedback = feedbackItem.values.first;
    });
  }
}
