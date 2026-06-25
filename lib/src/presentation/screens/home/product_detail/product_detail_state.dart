part of 'product_detail_cubit.dart';

class ProductDetailState extends Equatable {
  final LoadStatus status;
  final ProductEntity product;
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
  final String? imageUrl;
  final bool isFirstSubmit;
  final String? error;
  final Set<String> existingCodes;

  const ProductDetailState({
    this.status = LoadStatus.initial,
    required this.product,
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
    this.imageUrl,
    this.isFirstSubmit = false,
    this.error,
    this.existingCodes = const {},
  });

  ProductDetailState copyWith({
    LoadStatus? status,
    ProductEntity? product,
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
    String? imageUrl,
    bool? isFirstSubmit,
    String? error,
    Set<String>? existingCodes,
    bool clearImage = false,
  }) {
    return ProductDetailState(
      status: status ?? this.status,
      product: product ?? this.product,
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
      imageUrl: clearImage ? null : (imageUrl ?? this.imageUrl),
      isFirstSubmit: isFirstSubmit ?? this.isFirstSubmit,
      error: error,
      existingCodes: existingCodes ?? this.existingCodes,
    );
  }

  @override
  List<Object?> get props => [
        status,
        product,
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
        imageUrl,
        isFirstSubmit,
        error,
        existingCodes,
      ];
}
