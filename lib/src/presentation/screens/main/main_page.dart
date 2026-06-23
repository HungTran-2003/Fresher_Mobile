import 'package:crud_app/src/presentation/screens/home/home_page.dart';
import 'package:crud_app/src/presentation/screens/main/main_controller.dart';
import 'package:crud_app/src/presentation/screens/main/widgets/app_bottom_nav.dart';
import 'package:crud_app/src/presentation/screens/setting/setting_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<MainController>();

    final pages = [
      const HomePage(),
      const SettingPage(),
    ];

    return Scaffold(
      body: Obx(() => IndexedStack(
            index: controller.currentIndex.value,
            children: pages,
          )),
      bottomNavigationBar: SafeArea(
        top: false,
        child: Obx(() => AppBottomNav(
              selectedIndex: controller.currentIndex.value,
              onIndexChanged: (index) => controller.changeIndex(index),
            )),
      ),
    );
  }
}
