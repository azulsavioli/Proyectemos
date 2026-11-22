import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyectemos/commons/strings/strings.dart';
import 'package:proyectemos/providers/play_audio_provider.dart';
import 'package:proyectemos/providers/record_audio_provider_la_sociedad_impl.dart';

import '../../../widgets/unified_record_and_play.dart';

class RecordAndPlayLaSociedad extends StatelessWidget {
  const RecordAndPlayLaSociedad({super.key});

  @override
  Widget build(BuildContext context) {
    final record = context.watch<RecordAudioLaSociedadProviderImpl>();
    final play = context.watch<PlayAudioProvider>();
    final question = ModalRoute.of(context)?.settings.arguments?.toString() ?? '';
    return UnifiedRecordAndPlay(
      record: record,
      title: Strings.titleLaSociedad,
      question: question,
      background: NetworkImage(Strings.laSociedadGrabacionImage),
      isPlaying: play.isSongPlaying,
      onTogglePlayback: (path) => play.playAudio(File(path)),
    );
  }
}
