import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:proyectemos/app/modules/home/proyectos_page.dart';
import 'package:proyectemos/app/modules/login/login_page.dart';
import 'package:proyectemos/app/modules/proyecto_dos/como_crear_podcast/tarea_uno/tarea_uno_como_crear_podcast.dart';
import 'package:proyectemos/app/modules/widgets/card_button.dart';
import 'package:proyectemos/app/modules/widgets/feed_status_view.dart';
import 'package:proyectemos/commons/google_sign_in.dart';
import 'package:proyectemos/commons/strings/strings.dart';
import 'package:proyectemos/commons/styles.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  test('interface colors meet WCAG AA for text', () {
    expect(
      ThemeColors.contrastRatio(ThemeColors.white, ThemeColors.blue),
      greaterThanOrEqualTo(4.5),
    );
    expect(
      ThemeColors.contrastRatio(ThemeColors.white, ThemeColors.green),
      greaterThanOrEqualTo(4.5),
    );
    expect(
      ThemeColors.contrastRatio(ThemeColors.white, ThemeColors.red),
      greaterThanOrEqualTo(4.5),
    );
    expect(
      ThemeColors.contrastRatio(ThemeColors.nearBlack, ThemeColors.yellow),
      greaterThanOrEqualTo(4.5),
    );
    expect(
      ThemeColors.contrastRatio(ThemeColors.gray, ThemeColors.white),
      greaterThanOrEqualTo(4.5),
    );
    expect(
      ThemeColors.contrastRatio(ThemeColors.grayLight, ThemeColors.white),
      greaterThanOrEqualTo(4.5),
    );
  });

  test('google cancellation is silent and other errors are not', () {
    expect(
      isGoogleSignInCancellation(
        const GoogleSignInException(code: GoogleSignInExceptionCode.canceled),
      ),
      isTrue,
    );
    expect(isGoogleSignInCancellation(Exception('network down')), isFalse);
    expect(
      isGoogleSignInCancellation(
        const GoogleSignInException(
          code: GoogleSignInExceptionCode.unknownError,
          description: 'sign_in_canceled',
        ),
      ),
      isTrue,
    );
  });

  testWidgets('home cards and title do not overflow at text scale 2', (
    tester,
  ) async {
    for (final size in const [Size(360, 640), Size(412, 915)]) {
      for (final scale in const [1.0, 2.0]) {
        await _pump(
          tester,
          size: size,
          textScale: scale,
          home: const ProyectosPage(),
        );
        await tester.pump();
        expect(tester.takeException(), isNull);
        final title = tester.widget<Text>(find.text(Strings.title));
        expect(title.maxLines, 1);
        expect(title.softWrap, isFalse);
        final paragraph = tester.renderObject<RenderParagraph>(
          find.text(Strings.title),
        );
        expect(paragraph.didExceedMaxLines, isFalse);
      }
    }
  });

  testWidgets('card buttons wrap instead of overflowing at text scale 2', (
    tester,
  ) async {
    await _pump(
      tester,
      size: const Size(360, 640),
      textScale: 2,
      home: Scaffold(
        body: SingleChildScrollView(
          child: CardButton(
            text: 'Creación y divulgación de un evento cultural',
            cardWidth: 320,
            cardHeight: 72,
            namedRoute: null,
            backgroundColor: ThemeColors.yellow,
            icon: Icons.celebration,
            shadowColor: ThemeColors.yellow,
            iconSize: 24,
          ),
        ),
      ),
    );
    expect(tester.takeException(), isNull);
    expect(
      find.text('Creación y divulgación de un evento cultural'),
      findsOneWidget,
    );
  });

  testWidgets('google button label wraps at 360dp and text scale 2', (
    tester,
  ) async {
    await _pump(
      tester,
      size: const Size(360, 640),
      textScale: 2,
      home: const LoginPage(),
    );
    expect(tester.takeException(), isNull);
    expect(find.text(Strings.iniciaSessao), findsOneWidget);
  });

  testWidgets('send stays hidden until the last accessible page', (
    tester,
  ) async {
    SharedPreferences.setMockInitialValues({'isAccessible': true});
    await _pump(
      tester,
      size: const Size(800, 2400),
      textScale: 1,
      home: const TareaUnoEscucharPodcast(),
    );
    await tester.pump();
    expect(find.text('Enviar'), findsNothing);
    expect(find.text('Próximo'), findsOneWidget);
    expect(find.byTooltip('Voltar'), findsOneWidget);

    for (var i = 0; i < 9; i++) {
      await tester.tap(find.text('Próximo'));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 450));
    }

    expect(find.text('Enviar'), findsOneWidget);
    expect(find.text('Próximo'), findsNothing);
    expect(tester.takeException(), isNull);
  });

  testWidgets('send is on the second page when accessibility mode is off', (
    tester,
  ) async {
    SharedPreferences.setMockInitialValues({'isAccessible': false});
    await _pump(
      tester,
      size: const Size(800, 2400),
      textScale: 1,
      home: const TareaUnoEscucharPodcast(),
    );
    await tester.pump();
    expect(find.text('Enviar'), findsNothing);
    await tester.tap(find.text('Próximo'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 450));
    expect(find.text('Enviar'), findsOneWidget);
  });

  testWidgets('empty feed offers a reload action', (tester) async {
    var reloads = 0;
    await _pump(
      tester,
      size: const Size(360, 640),
      textScale: 1,
      home: Scaffold(
        body: FeedStatusView(
          message: 'Todavía no hay podcasts compartidos.',
          onReload: () => reloads++,
        ),
      ),
    );
    expect(find.text('Todavía no hay podcasts compartidos.'), findsOneWidget);
    await tester.ensureVisible(find.text('Reintentar'));
    await tester.pump();
    await tester.tap(find.text('Reintentar'));
    await tester.pump();
    expect(reloads, 1);
  });
}

Future<void> _pump(
  WidgetTester tester, {
  required Size size,
  required double textScale,
  required Widget home,
}) async {
  await tester.binding.setSurfaceSize(size);
  tester.view.devicePixelRatio = 1;
  addTearDown(() => tester.binding.setSurfaceSize(null));
  await tester.pumpWidget(
    ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      builder: (context, _) {
        return MaterialApp(
          theme: ThemeData(
            appBarTheme: const AppBarTheme(
              backgroundColor: ThemeColors.blue,
              foregroundColor: ThemeColors.white,
            ),
          ),
          builder: (context, child) {
            return MediaQuery(
              data: MediaQuery.of(context)
                  .copyWith(textScaler: TextScaler.linear(textScale)),
              child: child!,
            );
          },
          home: home,
        );
      },
    ),
  );
  await tester.pump();
}
