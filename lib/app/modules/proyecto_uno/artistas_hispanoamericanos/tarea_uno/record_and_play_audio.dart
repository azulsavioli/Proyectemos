import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyectemos/commons/strings/strings.dart';
import 'package:proyectemos/providers/play_audio_provider.dart';
import 'package:proyectemos/providers/record_audio_provider_artistas_impl.dart';

import '../../../widgets/unified_record_and_play.dart';

class RecordAndPlayScreen extends StatelessWidget {
  const RecordAndPlayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final record = context.watch<RecordAudioArtistasProviderImpl>();
    final play = context.watch<PlayAudioProvider>();
    final question = ModalRoute.of(context)?.settings.arguments?.toString() ?? '';
    return UnifiedRecordAndPlay(
      record: record,
      title: Strings.titleArtistasHispanoamericanosUno,
      question: question,
      background: const NetworkImage(
        'https://citaliarestauro.com/wp-content/uploads/2021/07/Imagem1.jpg',
      ),
      isPlaying: play.isSongPlaying,
      onTogglePlayback: (path) => play.playAudio(File(path)),
    );
  }
}
