import 'package:test/test.dart';

import 'test_repository_factory.dart';

void main() {
  test(
    'load levels en',
    () async {
      final repository = await createLevelsRepository();
      final levelInfo = await repository.getLevels("en");

      expect(levelInfo.length, 290);
    },
  );
}
