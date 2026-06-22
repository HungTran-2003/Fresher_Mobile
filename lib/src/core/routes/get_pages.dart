import 'package:crud_app/src/presentation/screens/home/add_product/add_product_binding.dart';
import 'package:crud_app/src/presentation/screens/home/add_product/add_product_page.dart';
import 'package:crud_app/src/presentation/screens/home/home_binding.dart';
import 'package:crud_app/src/presentation/screens/home/product_detail/product_detail_binding.dart';
import 'package:crud_app/src/presentation/screens/home/product_detail/product_detail_page.dart';
import 'package:crud_app/src/presentation/screens/login/login_binding.dart';
import 'package:crud_app/src/presentation/screens/setting/setting_binding.dart';
import 'package:crud_app/src/presentation/screens/setting/setting_page.dart';
import 'package:crud_app/src/presentation/screens/splash/splash_binding.dart';
import 'package:crud_app/src/presentation/screens/splash/splash_page.dart';
import 'package:crud_app/src/presentation/screens/login/login_page.dart';
import 'package:crud_app/src/presentation/screens/main/main_page.dart';
import 'package:get/get.dart';
import 'router.dart';

class GetAppPages {
  GetAppPages._();

  static final routes = [
    GetPage(
      name: AppRouters.splash,
      page: () => const SplashPage(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: AppRouters.welcome,
      page: () => const LoginPage(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: AppRouters.home,
      page: () => const MainPage(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: AppRouters.profile,
      page: () => const SettingPage(),
      binding: SettingBinding(),
    ),
    GetPage(
      name: AppRouters.addProduct,
      page: () => const AddProductPage(),
      binding: AddProductBinding(),
    ),
    GetPage(
      name: AppRouters.productDetail,
      page: () => const ProductDetailPage(argument: null),
      binding: ProductDetailBinding(),
    ),
  ];
}
