import 'package:crud_app/src/domain/repositories/product_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'home_controller.dart';
import 'home_navigator.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController(
      productRepository: Get.context!.read<ProductRepository>(),
      navigator: HomeNavigator(),
    ));
  }
}
