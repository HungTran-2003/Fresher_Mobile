part of 'add_product_cubit.dart';

class AddProductState extends Equatable {
  final LoadStatus status;
  final String name;
  final String code;
  final String price;
  final String stock;
  final CategoryEntity? category;
  final List<CategoryEntity> categories;
  final List<String> tags;
  final ProductStatusFilter statusFilter;
  final String description;
  final File? imageFile;
  final bool isFirstSubmit;
  final Set<String> existingCodes;
  final String? error;

  const AddProductState({
    this.status = LoadStatus.initial,
    this.name = '',
    this.code = '',
    this.price = '',
    this.stock = '',
    this.category,
    this.categories = const [],
    this.tags = const [],
    this.statusFilter = ProductStatusFilter.active,
    this.description = '',
    this.imageFile,
    this.isFirstSubmit = false,
    this.existingCodes = const {},
    this.error,
  });

  AddProductState copyWith({
    LoadStatus? status,
    String? name,
    String? code,
    String? price,
    String? stock,
    CategoryEntity? category,
    List<CategoryEntity>? categories,
    List<String>? tags,
    ProductStatusFilter? statusFilter,
    String? description,
    File? imageFile,
    bool? isFirstSubmit,
    Set<String>? existingCodes,
    String? error,
    bool clearImage = false,
  }) {
    return AddProductState(
      status: status ?? this.status,
      name: name ?? this.name,
      code: code ?? this.code,
      price: price ?? this.price,
      stock: stock ?? this.stock,
      category: category ?? this.category,
      categories: categories ?? this.categories,
      tags: tags ?? this.tags,
      statusFilter: statusFilter ?? this.statusFilter,
      description: description ?? this.description,
      imageFile: clearImage ? null : (imageFile ?? this.imageFile),
      isFirstSubmit: isFirstSubmit ?? this.isFirstSubmit,
      existingCodes: existingCodes ?? this.existingCodes,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [
        status,
        name,
        code,
        price,
        stock,
        category,
        categories,
        tags,
        statusFilter,
        description,
        imageFile,
        isFirstSubmit,
        existingCodes,
        error,
      ];
}
