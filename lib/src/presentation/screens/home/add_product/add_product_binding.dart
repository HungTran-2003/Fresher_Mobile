import 'package:crud_app/src/domain/repositories/product_repository.dart';
import 'package:crud_app/src/domain/repositories/upload_repository.dart';
import 'package:get/get.dart';
import 'add_product_controller.dart';
import 'add_product_navigator.dart';

class AddProductBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => AddProductController(
        productRepository: Get.find<ProductRepository>(),
        uploadRepository: Get.find<UploadRepository>(),
        navigator: AddProductNavigator(),
      ),
    );
  }
}
