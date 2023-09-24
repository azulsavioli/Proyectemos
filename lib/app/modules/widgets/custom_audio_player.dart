import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:proyectemos/commons/styles.dart';

import '../../../providers/play_audio_provider.dart';

class CustomAudioPlayer extends StatefulWidget {
  final String audioPath;
  const CustomAudioPlayer({required this.audioPath, super.key});

  @override
  State<CustomAudioPlayer> createState() => _CustomAudioPlayerState();
}

class _CustomAudioPlayerState extends State<CustomAudioPlayer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 50,
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
      ),
      child: Row(
        children: [
          _audioControllingSection(widget.audioPath),
          _audioProgressSection(),
        ],
      ),
    );
  }

  IconButton _audioControllingSection(String songPath) {
    final playProvider = Provider.of<PlayAudioProvider>(context);
    final playProviderWithoutListen =
        Provider.of<PlayAudioProvider>(context, listen: false);

    return IconButton(
      onPressed: () async {
        if (songPath.isEmpty) return;

        await playProviderWithoutListen.playAssetAudio(songPath);
      },
      icon: Icon(
        playProvider.isSongPlaying ? Icons.pause : Icons.play_arrow_rounded,
      ),
      color: ThemeColors.blue,
      iconSize: 30,
    );
  }

  Expanded _audioProgressSection() {
    final playProvider = Provider.of<PlayAudioProvider>(context);

    return Expanded(
      child: Container(
        width: double.maxFinite,
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: LinearPercentIndicator(
          percent: playProvider.currLoadingStatus,
          backgroundColor: Colors.black26,
          progressColor: ThemeColors.blue,
        ),
      ),
    );
  }
}
