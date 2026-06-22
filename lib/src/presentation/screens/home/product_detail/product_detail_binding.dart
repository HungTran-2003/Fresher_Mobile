import 'package:crud_app/src/domain/repositories/product_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'product_detail_controller.dart';
import '../add_product/add_product_navigator.dart';

class ProductDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProductDetailController(
      productRepository: Get.context!.read<ProductRepository>(),
      navigator: AddProductNavigator(),
    ));
  }
}
