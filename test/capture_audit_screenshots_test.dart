import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:proyectemos/app/modules/home/proyectos_page.dart';
import 'package:proyectemos/app/modules/login/login_page.dart';
import 'package:proyectemos/app/modules/proyecto_dos/como_crear_podcast/tarea_uno/question_como_crear_podcast.dart';
import 'package:proyectemos/app/modules/proyecto_dos/como_crear_podcast/tarea_uno/tarea_uno_como_crear_podcast.dart';
import 'package:proyectemos/app/modules/widgets/card_proyects.dart';
import 'package:proyectemos/app/modules/widgets/unified_record_and_play.dart';
import 'package:proyectemos/providers/acessibility_provider.dart';
import 'package:proyectemos/providers/audio_provider_interface.dart';
import 'package:provider/provider.dart';
import 'package:proyectemos/commons/strings/strings.dart';
import 'package:proyectemos/commons/styles.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Opt-in visual capture. Skipped unless CAPTURE_SCREENSHOTS is set.
void main() {
  final prefix = Platform.environment['CAPTURE_SCREENSHOTS'];
  if (prefix == null || prefix.isEmpty) {
    test('screenshot capture stays opt-in', () {
      expect(
        Platform.environment['CAPTURE_SCREENSHOTS'],
        anyOf(isNull, isEmpty),
      );
    });
    return;
  }

  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    SharedPreferences.setMockInitialValues({'isAccessible': true});
  });

  testWidgets('capture audit screens', (tester) async {
    File('/workspace/shot-stage.txt').writeAsStringSync('test-start\n');
    final out = Directory('/workspace/audit-shots');
    out.createSync(recursive: true);
    Future<void> shoot(
      String name,
      Size size,
      double scale,
      Widget home,
    ) async {
      File('/workspace/shot-stage.txt')
          .writeAsStringSync('shoot $name\n', mode: FileMode.append);
      tester.view.physicalSize = size;
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(
        ScreenUtilInit(
          designSize: const Size(360, 690),
          minTextAdapt: true,
          builder: (context, _) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: appTheme(),
              builder: (context, child) {
                return MediaQuery(
                  data: MediaQuery.of(context)
                      .copyWith(textScaler: TextScaler.linear(scale)),
                  child: RepaintBoundary(
                    key: const ValueKey('shot'),
                    child: child,
                  ),
                );
              },
              home: ChangeNotifierProvider(
                create: (_) => AccessibilityProvider(),
                child: home,
              ),
            );
          },
        ),
      );
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));
      File('/workspace/shot-stage.txt')
          .writeAsStringSync('layout-ready $name\n', mode: FileMode.append);

      final boundary = tester.renderObject<RenderRepaintBoundary>(
        find.byKey(const ValueKey('shot')),
      );
      File('/workspace/shot-stage.txt')
          .writeAsStringSync('toImage-start $name\n', mode: FileMode.append);
      final image = await boundary.toImage(pixelRatio: 1);
      File('/workspace/shot-stage.txt')
          .writeAsStringSync('toImage-done $name\n', mode: FileMode.append);
      final bytes = await tester.runAsync(
        () => image.toByteData(format: ui.ImageByteFormat.png),
      );
      File('/workspace/shot-stage.txt').writeAsStringSync(
        'bytes ${bytes?.lengthInBytes} $name\n',
        mode: FileMode.append,
      );
      final file = File('${out.path}/${prefix}_$name.png');
      file.writeAsBytesSync(bytes!.buffer.asUint8List());
      // ignore: avoid_print
      print('wrote ${file.path} (${file.lengthSync()} bytes)');
    }

    const phone = Size(360, 640);
    await shoot('home_360x640_x1.0', phone, 1, const _HomeShot());
    await shoot('home_360x640_x2.0', phone, 2, const _HomeShot());
    await shoot('login_360x640_x1.0', phone, 1, const LoginPage());
    await shoot('login_360x640_x2.0', phone, 2, const LoginPage());
    await shoot('tarea_360x640_x1.0', phone, 1, const _TaskShot());
    await shoot('tarea_360x640_x2.0', phone, 2, const _TaskShot());

    SharedPreferences.setMockInitialValues({
      'isAccessible': true,
      'latinoamericaTareaUnoCompleted': true,
      'latinoamericaTareaDosCompleted': true,
      'artistasTareaUnoCompleted': true,
      'artistasTareaDosCompleted': true,
      'eventoTareaUnoCompleted': true,
      'divulgationTareaUnoCompleted': true,
    });
    await shoot('home_checks_360x640_x1.0', phone, 1, const ProyectosPage());
    await shoot('tarea_paso_360x640_x1.0', phone, 1, const TareaUnoEscucharPodcast());
    await shoot('recorder_idle_360x640_x1.0', phone, 1, const _RecorderShot());
    await shoot(
      'recorder_review_360x640_x1.0',
      phone,
      1,
      const _RecorderShot(hasAudio: true),
    );
  });
}

class _HomeShot extends StatelessWidget {
  const _HomeShot();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColors.white,
      appBar: AppBar(
        toolbarHeight: 64,
        backgroundColor: ThemeColors.white,
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.all(8),
          child: Image.asset('assets/images/logo.png', height: 10, width: 10),
        ),
        title: Platform.environment['CAPTURE_SCREENSHOTS'] == 'after'
            ? FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(Strings.title, style: ThemeText.h3title20BlueBold),
              )
            : Text(Strings.title, style: ThemeText.h3title20BlueBold),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 8),
            child: Icon(Icons.menu, color: ThemeColors.gray),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
          child: Column(
            children: [
              CardProyecto(
                image: Strings.imageUno,
                title: Strings.titleCardUno,
                titleColor: ThemeText.h3title20Red,
                description: Strings.descriptionCardUno,
                descriptionColor: ThemeText.paragraph12Gray,
                backgroundColor: ThemeColors.red,
                namedRoute: '/proyecto_uno',
                icon: Icons.check,
              ),
              const SizedBox(height: 16),
              CardProyecto(
                image: Strings.imageDos,
                title: Strings.titleCardDos,
                titleColor: ThemeText.h3title20Blue,
                description: Strings.descriptionCardDos,
                descriptionColor: ThemeText.paragraph12Gray,
                backgroundColor: ThemeColors.blue,
                namedRoute: '/proyecto_dos',
                icon: null,
              ),
              const SizedBox(height: 16),
              CardProyecto(
                image: Strings.imageTres,
                title: Strings.titleCardTres,
                titleColor: ThemeText.h3title20yellow,
                description: Strings.descriptionCardTres,
                descriptionColor: ThemeText.paragraph12Gray,
                backgroundColor: ThemeColors.yellow,
                namedRoute: '/proyecto_tres',
                icon: null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ShotRecorder extends ChangeNotifier implements AudioProvider {
  _ShotRecorder({this.hasAudio = false});
  final bool hasAudio;
  @override
  bool isRecording = false;
  @override
  String get recordedFilePath => hasAudio ? '/tmp/respuesta.aac' : '';
  @override
  List<dynamic> clearOldData() => [];
  @override
  void clearAllData() {}
  @override
  Future<void> recordVoice(context) async {}
  @override
  Future<void> stopRecording(context) async {}
  @override
  void cancelRecording() {}
  @override
  void saveRecording(context) {}
}

class _RecorderShot extends StatelessWidget {
  const _RecorderShot({this.hasAudio = false});
  final bool hasAudio;

  @override
  Widget build(BuildContext context) {
    return UnifiedRecordAndPlay(
      record: _ShotRecorder(hasAudio: hasAudio),
      title: 'Frida Kahlo',
      question: 'Describe lo que ves',
      background: null,
      isPlaying: false,
      onTogglePlayback: (_) async {},
    );
  }
}

class _TaskShot extends StatelessWidget {
  const _TaskShot();

  @override
  Widget build(BuildContext context) {
    final focus = List.generate(6, (_) => FocusNode());
    final texts = List.generate(6, (_) => TextEditingController());
    return Scaffold(
      backgroundColor: ThemeColors.white,
      appBar: AppBar(
        leading: const Icon(Icons.arrow_back_ios, color: ThemeColors.white),
        centerTitle: true,
        title: Text(
          Strings.titleElContenidoDelPodcast,
          style: ThemeText.paragraph14WhiteBold,
        ),
      ),
      body: QuestionComoCrearPodcast(
        focusNodeList: focus,
        textControllerList: texts,
      ),
    );
  }
}
