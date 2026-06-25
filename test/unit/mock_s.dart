import 'package:crud_app/generated/l10n.dart';
import 'package:mocktail/mocktail.dart';

class MockS extends Mock implements S {
  @override
  String get productDeletedSuccess => 'Product deleted successfully';
  @override
  String get productAddedSuccess => 'Product added successfully';
  @override
  String get failedToUploadImage => 'Failed to upload image';
}

void setupMockS() {
  // Accessing the private _current is not possible directly, but we can call load or use a hack.
  // Actually, we can use a simple trick if we can modify the generated file, but we shouldn't.
  // Alternative: Use reflect or just use a dummy S instance if it doesn't crash.
  // But S.load requires Flutter/Intl initialization.
}
