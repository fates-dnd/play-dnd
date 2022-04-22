import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

import 'test_repository_factory.dart';

void main() {
  test("load traits", () async {
    final repository = await createTraitsRepository();
    final features = await repository.getTraits("en");

    expect(features.length, 38);
  });
}
