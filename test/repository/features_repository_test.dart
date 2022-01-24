import 'package:test/test.dart';

import 'test_repository_factory.dart';

void main() {
  test('load features en', () async {
    final repository = await createFeaturesRepository();
    final features = await repository.getFeatures("en");

    expect(features.length, 377);
  });

  test('load features ru', () async {
    final repository = await createFeaturesRepository();
    final features = await repository.getFeatures("ru");

    expect(features.length, 377);
  });
}
