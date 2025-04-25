import 'package:get/get.dart';

import '../modules/product/views/product_view.dart';
import '../modules/product/bindings/product_binding.dart';
import '../modules/product_detail/views/product_detail_view.dart';
import '../modules/product_detail/bindings/product_detail_binding.dart';

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
    GetPage (
      name: _Paths.PRODUCT_DETAIL,
      page: () => const ProductDetailView(),
      binding: ProductDetailBinding(),
      transition: Transition.native,
    )
  ];
}