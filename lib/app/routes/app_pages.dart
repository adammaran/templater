import 'package:get/get.dart';

import '../home/bindings/home_binding.dart';
import '../home/bindings/home_binding.dart';
import '../home/views/home_view.dart';
import '../home/views/home_view.dart';
import '../sample/bindings/sample_binding.dart';
import '../sample/views/sample_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const home = Routes.HOME;
  static const sample = Routes.SAMPLE;

  static final routes = [
    GetPage(
      name: _Paths.SAMPLE,
      page: () => const SampleView(),
      binding: SampleBinding(),
    ),
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
  ];
}
