part of 'app_pages.dart';

abstract class Routes {
  Routes._();
  static const PRODUCT = _Paths.PRODUCT;
  static const PRODUCT_DETAIL = _Paths.PRODUCT_DETAIL;

}

abstract class _Paths {
  _Paths._();
  static const PRODUCT = '/product';
  static const PRODUCT_DETAIL = '/product_detail';

}