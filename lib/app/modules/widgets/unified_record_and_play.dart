import 'dart:async';

import 'package:flutter/material.dart';
import 'package:proyectemos/commons/styles.dart';
import 'package:proyectemos/providers/audio_provider_interface.dart';
import 'package:proyectemos/services/permission_management.dart';
import 'package:simple_ripple_animation/simple_ripple_animation.dart';

import 'spanish_text.dart';

/// Shared recorder used by every oral task.
///
/// Chrome is pt-BR. The spoken prompt stays in Spanish and is exposed to
/// screen readers with locale `es`.
class UnifiedRecordAndPlay extends StatefulWidget {
  final AudioProvider record;
  final String title;
  final String question;
  final ImageProvider? background;
  final bool isPlaying;
  final Future<void> Function(String path) onTogglePlayback;
  final Future<MicrophoneAccess> Function() requestMicrophone;
  final Future<bool> Function() openSettings;

  const UnifiedRecordAndPlay({
    super.key,
    required this.record,
    required this.title,
    required this.question,
    required this.background,
    required this.isPlaying,
    required this.onTogglePlayback,
    this.requestMicrophone = PermissionManagement.microphoneAccess,
    this.openSettings = PermissionManagement.openSettings,
  });

  @override
  State<UnifiedRecordAndPlay> createState() => _UnifiedRecordAndPlayState();
}

class _UnifiedRecordAndPlayState extends State<UnifiedRecordAndPlay> {
  Timer? _ticker;
  Duration _elapsed = Duration.zero;

  @override
  void initState() {
    super.initState();
    _listen();
    _syncTimer(widget.record.isRecording);
  }

  @override
  void didUpdateWidget(covariant UnifiedRecordAndPlay oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.record != widget.record) {
      if (oldWidget.record is Listenable) {
        (oldWidget.record as Listenable).removeListener(_onRecord);
      }
      _listen();
    }
    _syncTimer(widget.record.isRecording);
  }

  void _listen() {
    if (widget.record is Listenable) {
      (widget.record as Listenable).addListener(_onRecord);
    }
  }

  void _onRecord() {
    if (!mounted) return;
    setState(() => _syncTimer(widget.record.isRecording));
  }

  void _syncTimer(bool recording) {
    if (recording && _ticker == null) {
      _ticker = Timer.periodic(const Duration(seconds: 1), (_) {
        if (!mounted) return;
        setState(() => _elapsed += const Duration(seconds: 1));
      });
    } else if (!recording && _ticker != null) {
      _ticker?.cancel();
      _ticker = null;
    }
  }

  @override
  void dispose() {
    _ticker?.cancel();
    if (widget.record is Listenable) {
      (widget.record as Listenable).removeListener(_onRecord);
    }
    super.dispose();
  }

  String get _clock {
    final minutes = _elapsed.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = _elapsed.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  Future<void> _startRecording() async {
    final proceed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Microfone'),
        content: const Text(
          'O microfone será usado só para gravar a sua resposta. O áudio fica neste aparelho até você confirmar que quer salvar.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Agora não'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Continuar'),
          ),
        ],
      ),
    );
    if (proceed != true || !mounted) return;

    final access = await widget.requestMicrophone();
    if (!mounted) return;
    if (access == MicrophoneAccess.permanentlyDenied) {
      final open = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Microfone bloqueado'),
          content: const Text(
            'A permissão do microfone foi negada de forma permanente. Abra as configurações do aplicativo para permitir a gravação.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Fechar'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Abrir configurações'),
            ),
          ],
        ),
      );
      if (open == true) await widget.openSettings();
      return;
    }
    if (access != MicrophoneAccess.granted || !mounted) return;

    setState(() => _elapsed = Duration.zero);
    await widget.record.recordVoice(context);
  }

  Future<void> _stopRecording() async {
    await widget.record.stopRecording(context);
  }

  Future<void> _save() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Salvar gravação?'),
        content: const Text(
          'A resposta em áudio será guardada nesta atividade. Você pode gravar de novo antes de confirmar.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Voltar'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Salvar'),
          ),
        ],
      ),
    );
    if (confirm != true || !mounted) return;
    widget.record.saveRecording(context);
    if (mounted) Navigator.of(context).pop();
  }

  Future<void> _cancel() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Descartar gravação?'),
        content: const Text('O áudio gravado será apagado e não será enviado.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Voltar'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Descartar'),
          ),
        ],
      ),
    );
    if (confirm != true || !mounted) return;
    widget.record.cancelRecording();
    setState(() => _elapsed = Duration.zero);
  }

  @override
  Widget build(BuildContext context) {
    final recording = widget.record.isRecording;
    final hasAudio = widget.record.recordedFilePath.isNotEmpty && !recording;
    final reduceMotion = MediaQuery.disableAnimationsOf(context);

    return Scaffold(
      backgroundColor: ThemeColors.white,
      appBar: AppBar(
        leading: IconButton(
          tooltip: 'Voltar',
          icon: const Icon(Icons.arrow_back_ios, color: ThemeColors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
        title: Text(widget.title, style: ThemeText.paragraph16WhiteBold),
      ),
      body: DecoratedBox(
        decoration: BoxDecoration(
          color: ThemeColors.white,
          image: widget.background == null
              ? null
              : DecorationImage(
                  opacity: 0.2,
                  fit: BoxFit.cover,
                  image: widget.background!,
                ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                SpanishText(
                  widget.question,
                  textAlign: TextAlign.center,
                  style: ThemeText.h3title20Gray,
                ),
                const SizedBox(height: 24),
                Text(
                  recording
                      ? 'Gravando'
                      : hasAudio
                      ? 'Ouça antes de salvar'
                      : 'Gravar resposta',
                  style: ThemeText.paragraph16GrayBold,
                ),
                const SizedBox(height: 8),
                Text(
                  _clock,
                  key: const Key('record_timer'),
                  style: ThemeText.h2title35Blue,
                ),
                const SizedBox(height: 16),
                if (!hasAudio)
                  _recordButton(recording, reduceMotion)
                else ...[
                  IconButton(
                    key: const Key('listen_button'),
                    tooltip: widget.isPlaying ? 'Pausar' : 'Reproduzir',
                    iconSize: 48,
                    color: ThemeColors.blue,
                    onPressed: () =>
                        widget.onTogglePlayback(widget.record.recordedFilePath),
                    icon: Icon(
                      widget.isPlaying ? Icons.pause : Icons.play_arrow_rounded,
                    ),
                  ),
                  Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 12,
                    runSpacing: 12,
                    children: [
                      OutlinedButton(
                        key: const Key('rerecord_button'),
                        onPressed: _startRecording,
                        child: const Text('Gravar de novo'),
                      ),
                      OutlinedButton(
                        key: const Key('cancel_button'),
                        onPressed: _cancel,
                        child: const Text('Cancelar'),
                      ),
                      FilledButton(
                        key: const Key('save_button'),
                        onPressed: _save,
                        child: const Text('Salvar'),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _recordButton(bool recording, bool reduceMotion) {
    final label = recording ? 'Parar a gravação' : 'Gravar';
    final core = Container(
      width: 100,
      height: 100,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: recording ? ThemeColors.red : ThemeColors.green,
        shape: BoxShape.circle,
      ),
      child: Icon(
        recording ? Icons.stop : Icons.keyboard_voice_rounded,
        color: ThemeColors.white,
        size: 48,
      ),
    );
    final button = Tooltip(
      message: label,
      excludeFromSemantics: true,
      child: Semantics(
        button: true,
        label: label,
        excludeSemantics: true,
        child: InkWell(
          key: const Key('record_button'),
          onTap: recording ? _stopRecording : _startRecording,
          customBorder: const CircleBorder(),
          child: recording && !reduceMotion
              ? RippleAnimation(
                  repeat: true,
                  color: ThemeColors.green,
                  minRadius: 40,
                  ripplesCount: 6,
                  child: core,
                )
              : core,
        ),
      ),
    );
    return button;
  }
}
