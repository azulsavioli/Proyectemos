import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  test('app source has no LinkedIn link, icon, or reference', () {
    final hits = <String>[];
    for (final entity in Directory('lib').listSync(recursive: true)) {
      if (entity is! File) continue;
      final path = entity.path;
      if (!path.endsWith('.dart') && !path.endsWith('.yaml')) continue;
      final text = entity.readAsStringSync().toLowerCase();
      if (text.contains('linkedin')) hits.add(path);
    }
    expect(hits, isEmpty);
  });
}
