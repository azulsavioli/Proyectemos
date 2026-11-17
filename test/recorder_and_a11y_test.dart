import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:proyectemos/app/modules/widgets/unified_record_and_play.dart';
import 'package:proyectemos/providers/acessibility_provider.dart';
import 'package:proyectemos/providers/audio_provider_interface.dart';
import 'package:proyectemos/services/permission_management.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FakeRecorder extends ChangeNotifier implements AudioProvider {
  @override
  bool isRecording = false;

  @override
  String recordedFilePath = '';

  int starts = 0;
  int stops = 0;
  int saves = 0;
  int cancels = 0;

  @override
  List<dynamic> clearOldData() => [];

  @override
  void clearAllData() {}

  @override
  Future<void> recordVoice(context) async {
    starts++;
    isRecording = true;
    recordedFilePath = '';
    notifyListeners();
  }

  @override
  Future<void> stopRecording(context) async {
    stops++;
    isRecording = false;
    recordedFilePath = '/tmp/respuesta.aac';
    notifyListeners();
  }

  @override
  void cancelRecording() {
    cancels++;
    isRecording = false;
    recordedFilePath = '';
    notifyListeners();
  }

  @override
  void saveRecording(context) {
    saves++;
    notifyListeners();
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('recorder explains, times, and confirms before saving', (
    tester,
  ) async {
    final record = FakeRecorder();
    var settingsOpened = 0;
    await tester.pumpWidget(
      ScreenUtilInit(
        designSize: const Size(360, 690),
        builder: (context, _) => MaterialApp(
        home: UnifiedRecordAndPlay(
          record: record,
          title: 'Frida Kahlo',
          question: 'Describe lo que ves',
          background: null,
          isPlaying: false,
          onTogglePlayback: (_) async {},
          requestMicrophone: () async => MicrophoneAccess.granted,
          openSettings: () async {
            settingsOpened++;
            return true;
          },
        ),
      ),
      ),
    );
    await tester.pump();

    expect(find.text('Describe lo que ves'), findsOneWidget);
    expect(find.text('00:00'), findsOneWidget);
    expect(find.byTooltip('Gravar'), findsOneWidget);

    await tester.tap(find.byKey(const Key('record_button')));
    await tester.pumpAndSettle();
    expect(find.text('Microfone'), findsOneWidget);
    await tester.tap(find.text('Agora não'));
    await tester.pumpAndSettle();
    expect(record.starts, 0);

    await tester.tap(find.byKey(const Key('record_button')));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Continuar'));
    await tester.pump();
    expect(record.starts, 1);
    expect(find.text('Gravando'), findsOneWidget);
    expect(find.byTooltip('Parar a gravação'), findsOneWidget);

    await tester.pump(const Duration(seconds: 2));
    expect(find.text('00:02'), findsOneWidget);

    await tester.tap(find.byKey(const Key('record_button')));
    await tester.pump();
    expect(record.stops, 1);
    expect(find.text('Salvar'), findsOneWidget);
    expect(find.byTooltip('Reproduzir'), findsOneWidget);

    await tester.tap(find.byKey(const Key('save_button')));
    await tester.pumpAndSettle();
    expect(find.text('Salvar gravação?'), findsOneWidget);
    await tester.tap(find.text('Voltar'));
    await tester.pumpAndSettle();
    expect(record.saves, 0);

    await tester.tap(find.byKey(const Key('cancel_button')));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Descartar'));
    await tester.pump();
    expect(record.cancels, 1);
    expect(settingsOpened, 0);
  });

  testWidgets('permanently denied microphone offers app settings', (
    tester,
  ) async {
    final record = FakeRecorder();
    var settingsOpened = 0;
    await tester.pumpWidget(
      ScreenUtilInit(
        designSize: const Size(360, 690),
        builder: (context, _) => MaterialApp(
        home: UnifiedRecordAndPlay(
          record: record,
          title: 'Frida Kahlo',
          question: 'Describe lo que ves',
          background: null,
          isPlaying: false,
          onTogglePlayback: (_) async {},
          requestMicrophone: () async => MicrophoneAccess.permanentlyDenied,
          openSettings: () async {
            settingsOpened++;
            return true;
          },
        ),
      ),
      ),
    );
    await tester.pump();

    await tester.tap(find.byKey(const Key('record_button')));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Continuar'));
    await tester.pumpAndSettle();
    expect(find.text('Microfone bloqueado'), findsOneWidget);
    await tester.tap(find.text('Abrir configurações'));
    await tester.pumpAndSettle();
    expect(settingsOpened, 1);
    expect(record.starts, 0);
  });

  testWidgets('accessibility follows the system until the student overrides', (
    tester,
  ) async {
    SharedPreferences.setMockInitialValues({});
    final provider = AccessibilityProvider();
    await tester.pumpWidget(
      MaterialApp(
        home: ListenableBuilder(
          listenable: provider,
          builder: (context, _) {
            return MediaQuery(
              data: const MediaQueryData(accessibleNavigation: true),
              child: Builder(
                builder: (context) {
                  return Text(
                    provider.isEnabled(context) ? 'ligado' : 'desligado',
                  );
                },
              ),
            );
          },
        ),
      ),
    );
    await tester.pump();
    expect(find.text('ligado'), findsOneWidget);

    await provider.setAccessibility(false);
    await tester.pump();
    expect(find.text('desligado'), findsOneWidget);
    expect(provider.overridePreference, isFalse);

    await provider.clearOverride();
    await tester.pump();
    expect(find.text('ligado'), findsOneWidget);
    expect(provider.overridePreference, isNull);
  });
}
