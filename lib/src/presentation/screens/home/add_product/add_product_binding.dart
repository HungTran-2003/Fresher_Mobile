import 'package:crud_app/src/domain/repositories/product_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'add_product_controller.dart';
import 'add_product_navigator.dart';

class AddProductBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AddProductController(
      productRepository: Get.context!.read<ProductRepository>(),
      navigator: AddProductNavigator(),
    ));
  }
}
