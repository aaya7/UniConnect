import 'package:get/get.dart';

import '../modules/product/views/product_view.dart';
import '../modules/product/bindings/product_binding.dart';


part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.PRODUCT;

  static final routes = [
    GetPage (
      name: _Paths.PRODUCT,
      page: () => const ProductView(),
      binding: ProductBinding(),
      transition: Transition.native,
    ),
  ];
}