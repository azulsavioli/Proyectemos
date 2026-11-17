import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:proyectemos/utils/navigation.dart';

void main() {
  testWidgets('popOrReplace pops when the stack has a previous route',
      (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Builder(
          builder: (context) => TextButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (context) => TextButton(
                    onPressed: () => popOrReplace(context, '/proyectos'),
                    child: const Text('volver'),
                  ),
                ),
              );
            },
            child: const Text('abrir'),
          ),
        ),
      ),
    );

    await tester.tap(find.text('abrir'));
    await tester.pumpAndSettle();
    expect(find.text('volver'), findsOneWidget);

    await tester.tap(find.text('volver'));
    await tester.pumpAndSettle();
    expect(find.text('abrir'), findsOneWidget);
    expect(find.text('volver'), findsNothing);
  });

  testWidgets('popOrReplace replaces the route when it cannot pop',
      (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        routes: {
          '/': (context) => TextButton(
                onPressed: () => popOrReplace(context, '/proyectos'),
                child: const Text('volver'),
              ),
          '/proyectos': (_) => const Text('proyectos'),
        },
      ),
    );

    await tester.tap(find.text('volver'));
    await tester.pumpAndSettle();
    expect(find.text('proyectos'), findsOneWidget);
    expect(find.text('volver'), findsNothing);
  });
}
