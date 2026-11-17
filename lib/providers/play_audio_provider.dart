import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class PlayAudioProvider extends ChangeNotifier {
  final _justAudioPlayer = AudioPlayer();
  double _currAudioPlaying = 0;
  bool _isSongPlaying = false;
  String _audioFilePath = '';
  bool _listenersAttached = false;

  bool get isSongPlaying => _isSongPlaying;

  String get currSongPath => _audioFilePath;

  void setAudioFilePath(String filePath) {
    _audioFilePath = filePath;
    notifyListeners();
  }

  void clearCurrAudioPath() {
    _audioFilePath = '';
    notifyListeners();
  }

  void _ensureListeners() {
    if (_listenersAttached) return;
    _listenersAttached = true;

    _justAudioPlayer.positionStream.listen((event) {
      _currAudioPlaying = event.inMicroseconds.ceilToDouble();
      notifyListeners();
    });

    _justAudioPlayer.playerStateStream.listen((event) {
      if (event.processingState == ProcessingState.completed) {
        _justAudioPlayer.stop();
        _reset();
      }
    });
  }

  Future<void> _toggleSource({
    required bool isNewSource,
    required Future<void> Function() load,
  }) async {
    _ensureListeners();
    if (isNewSource ||
        _justAudioPlayer.processingState == ProcessingState.idle ||
        _justAudioPlayer.processingState == ProcessingState.completed) {
      await load();
      updateSongPlayingStatus(true);
      await _justAudioPlayer.play();
      return;
    }

    if (_justAudioPlayer.playing) {
      updateSongPlayingStatus(false);
      await _justAudioPlayer.pause();
      return;
    }

    updateSongPlayingStatus(true);
    await _justAudioPlayer.play();
  }

  Future<String?> playAssetAudio(String assetPath, {bool update = true}) async {
    try {
      final isNewSource = _audioFilePath != assetPath;
      await _toggleSource(
        isNewSource: isNewSource,
        load: () async {
          setAudioFilePath(assetPath);
          await _justAudioPlayer.setAsset(assetPath);
        },
      );
      return null;
    } catch (e) {
      debugPrint('Erro ao tocar asset de áudio: $e');
      updateSongPlayingStatus(false);
      return e.toString();
    }
  }

  Future<String?> playAudio(
    File incomingAudioFile, {
    bool update = true,
  }) async {
    try {
      final path = incomingAudioFile.path;
      final isNewSource = _audioFilePath != path;
      await _toggleSource(
        isNewSource: isNewSource,
        load: () async {
          setAudioFilePath(path);
          await _justAudioPlayer.setFilePath(path);
        },
      );
      return null;
    } catch (e) {
      debugPrint('Erro ao tocar áudio gravado: $e');
      updateSongPlayingStatus(false);
      return e.toString();
    }
  }

  void _reset() {
    _currAudioPlaying = 0.0;
    notifyListeners();
    updateSongPlayingStatus(false);
  }

  void updateSongPlayingStatus(bool update) {
    _isSongPlaying = update;
    notifyListeners();
  }

  double get currLoadingStatus {
    final duration = _justAudioPlayer.duration?.inMicroseconds.ceilToDouble();
    if (duration == null || duration == 0) return 0;
    final currTime = _currAudioPlaying / duration;
    if (currTime < 0) return 0;
    return currTime > 1.0 ? 1.0 : currTime;
  }

  @override
  void dispose() {
    _justAudioPlayer.dispose();
    super.dispose();
  }
}
