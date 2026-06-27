import 'package:crud_app/src/data/models/product/product_model.dart';
import 'package:hive_ce/hive.dart';

class HiveProductService {
  static const String _boxName = 'productsBox';

  Future<Box<ProductModel>> get _box async => await Hive.openBox<ProductModel>(_boxName);

  Future<void> saveProducts(List<ProductModel> products) async {
    final box = await _box;
    final Map<int, ProductModel> productMap = {
      for (var p in products) p.id: p
    };
    await box.putAll(productMap);
  }

  Future<List<ProductModel>> getProducts() async {
    final box = await _box;
    return box.values.toList();
  }

  Future<void> clearProducts() async {
    final box = await _box;
    await box.clear();
  }
}
