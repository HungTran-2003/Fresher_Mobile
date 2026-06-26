import 'package:crud_app/src/domain/models/entities/category_entity.dart';
import 'package:crud_app/src/domain/repositories/product_repository.dart';
import 'package:crud_app/src/domain/usecases/product/get_categories_use_case.dart';
import 'package:crud_app/src/domain/usecases/use_case.dart';
import 'package:dart_either/dart_either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockProductRepository extends Mock implements ProductRepository {}

void main() {
  late GetCategoriesUseCase useCase;
  late MockProductRepository mockRepository;

  setUp(() {
    mockRepository = MockProductRepository();
    useCase = GetCategoriesUseCase(mockRepository);
  });

  final tCategories = [
    const CategoryEntity(
      id: 1,
      name: 'Cat 1',
      status: 1,
      createdAt: '',
      updatedAt: '',
    ),
  ];

  test('should call getCategories on the repository', () async {
    // arrange
    when(() => mockRepository.getCategories())
        .thenAnswer((_) async => Either.right(tCategories));

    // act
    final result = await useCase(NoParams());

    // assert
    expect(result, Either.right(tCategories));
    verify(() => mockRepository.getCategories()).called(1);
    verifyNoMoreInteractions(mockRepository);
  });
}
