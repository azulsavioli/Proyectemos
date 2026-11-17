import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyectemos/commons/strings/strings.dart';
import 'package:proyectemos/providers/play_audio_provider.dart';
import 'package:proyectemos/providers/record_audio_provider_evento_cultural_impl.dart';

import '../../widgets/unified_record_and_play.dart';

class RecordAndPlayPropuestaScreen extends StatelessWidget {
  const RecordAndPlayPropuestaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final record = context.watch<RecordAudioProviderEventoCulturalImpl>();
    final play = context.watch<PlayAudioProvider>();
    final question = ModalRoute.of(context)?.settings.arguments?.toString() ?? '';
    return UnifiedRecordAndPlay(
      record: record,
      title: Strings.titleEventoCulturalUno,
      question: question,
      background: const NetworkImage(Strings.propuestaImage),
      isPlaying: play.isSongPlaying,
      onTogglePlayback: (path) => play.playAudio(File(path)),
    );
  }
}
