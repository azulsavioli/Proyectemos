import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:proyectemos/commons/styles.dart';
import 'package:proyectemos/providers/record_audio_provider_evento_cultural_impl.dart';
import 'package:simple_ripple_animation/simple_ripple_animation.dart';

import '../../../../commons/strings.dart';
import '../../../../providers/play_audio_provider.dart';
import '../../widgets/drawer_menu.dart';

class RecordAndPlayPropuestaScreen extends StatefulWidget {
  const RecordAndPlayPropuestaScreen({Key? key}) : super(key: key);

  @override
  State<RecordAndPlayPropuestaScreen> createState() =>
      _RecordAndPlayPropuestaScreenState();
}

class _RecordAndPlayPropuestaScreenState
    extends State<RecordAndPlayPropuestaScreen> {
  void customizeStatusAndNavigationBar() {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.white,
        statusBarColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
    );
  }

  @override
  void initState() {
    customizeStatusAndNavigationBar();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final recordProvider =
        Provider.of<RecordAudioProviderEventoCulturalImpl>(context);
    final playProvider = Provider.of<PlayAudioProvider>(context);

    final arguments = ModalRoute.of(context)?.settings.arguments;
    final question = arguments;

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
        title: Text(
          Strings.titleEventoCulturalUno,
          style: ThemeText.paragraph16WhiteBold,
        ),
      ),
      endDrawer: DrawerMenuWidget(),
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              opacity: 0.1,
              fit: BoxFit.fitHeight,
              image: NetworkImage(
                'https://media.istockphoto.com/id/623702486/pt/foto/south-america-map-3d-illustration.jpg?s=612x612&w=0&k=20&c=5hPtUPLSwnQktWO2fPhEa1JsuPNNo1lcvJCwvmwNnE0=',
              ),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  question.toString(),
                  style: ThemeText.paragraph16GrayBold,
                ),
              ),
              if (recordProvider.recordedFilePath.isEmpty)
                _recordHeading()
              else
                _playAudioHeading(),
              const SizedBox(height: 20),
              if (recordProvider.recordedFilePath.isEmpty)
                _recordingSection()
              else
                _audioPlayingSection(),
              if (recordProvider.recordedFilePath.isNotEmpty &&
                  !playProvider.isSongPlaying)
                const SizedBox(height: 20),
              if (recordProvider.recordedFilePath.isNotEmpty &&
                  !playProvider.isSongPlaying)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _resetButton(),
                    const SizedBox(
                      width: 20,
                    ),
                    _saveButton(),
                  ],
                ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Center _recordHeading() {
    return Center(
      child: Text(
        'Grabar Audio',
        style: ThemeText.h3title20Gray,
      ),
    );
  }

  Center _playAudioHeading() {
    return Center(
      child: Text(
        'Tocar Audio',
        style: ThemeText.h3title20Gray,
      ),
    );
  }

  InkWell _recordingSection() {
    final recordProvider =
        Provider.of<RecordAudioProviderEventoCulturalImpl>(context);
    final recordProviderWithoutListener =
        Provider.of<RecordAudioProviderEventoCulturalImpl>(
      context,
      listen: false,
    );

    if (recordProvider.isRecording) {
      return InkWell(
        onTap: () async => recordProviderWithoutListener.stopRecording(),
        child: RippleAnimation(
          repeat: true,
          color: ThemeColors.green,
          minRadius: 40,
          ripplesCount: 6,
          child: _commonIconSection(),
        ),
      );
    }

    return InkWell(
      onTap: () async => recordProviderWithoutListener.recordVoice(),
      child: _commonIconSection(),
    );
  }

  Container _commonIconSection() {
    final recordProvider =
        Provider.of<RecordAudioProviderEventoCulturalImpl>(context);

    return Container(
      width: 100,
      height: 100,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: ThemeColors.green,
        borderRadius: BorderRadius.circular(100),
      ),
      child: Icon(
        recordProvider.isRecording ? Icons.stop : Icons.keyboard_voice_rounded,
        color: Colors.white,
        size: 60,
      ),
    );
  }

  Container _audioPlayingSection() {
    final recordProvider =
        Provider.of<RecordAudioProviderEventoCulturalImpl>(context);

    return Container(
      width: MediaQuery.of(context).size.width - 110,
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
      ),
      child: Row(
        children: [
          _audioControllingSection(recordProvider.recordedFilePath),
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

        await playProviderWithoutListen.playAudio(File(songPath));
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

  InkWell _resetButton() {
    final recordProvider = Provider.of<RecordAudioProviderEventoCulturalImpl>(
      context,
      listen: false,
    );

    return InkWell(
      onTap: recordProvider.cancelRecording,
      child: Center(
        child: Container(
          width: 140,
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          decoration: BoxDecoration(
            color: ThemeColors.red,
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Text(
            'Cancelar',
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
        ),
      ),
    );
  }

  InkWell _saveButton() {
    final recordProvider = Provider.of<RecordAudioProviderEventoCulturalImpl>(
      context,
      listen: false,
    );

    return InkWell(
      onTap: () => {recordProvider.saveRecording(), Navigator.pop(context)},
      child: Center(
        child: Container(
          width: 140,
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          decoration: BoxDecoration(
            color: ThemeColors.green,
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Text(
            'Salvar',
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
