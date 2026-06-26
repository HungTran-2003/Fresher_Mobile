import 'package:crud_app/src/domain/repositories/product_repository.dart';
import 'package:crud_app/src/domain/repositories/upload_repository.dart';
import 'package:crud_app/src/domain/usecases/product/get_categories_use_case.dart';
import 'package:crud_app/src/domain/usecases/product/update_product_use_case.dart';
import 'package:crud_app/src/domain/usecases/upload/upload_image_use_case.dart';
import 'package:get/get.dart';
import '../add_product/add_product_navigator.dart';
import 'product_detail_controller.dart';

class ProductDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AddProductNavigator(Get.context!));
    Get.lazyPut(() => UpdateProductUseCase(Get.find<ProductRepository>()));
    Get.lazyPut(() => GetCategoriesUseCase(Get.find<ProductRepository>()));
    Get.lazyPut(() => UploadImageUseCase(Get.find<UploadRepository>()));

    Get.lazyPut(
      () => ProductDetailController(
        updateProductUseCase: Get.find<UpdateProductUseCase>(),
        getCategoriesUseCase: Get.find<GetCategoriesUseCase>(),
        uploadImageUseCase: Get.find<UploadImageUseCase>(),
        navigator: Get.find<AddProductNavigator>(),
      ),
    );
  }
}
