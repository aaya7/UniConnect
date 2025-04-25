import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart' as getx;
import 'package:dio/dio.dart';
import '../models/product_models.dart';
import '../constant/endpoints_constant.dart';
import '../../core/http_services.dart';

class ProductRepository {
  static ProductRepository get instance => getx.Get.find<ProductRepository>();

  Future<List<ProductListModel>> fetchProducts() async {
    try {
      Response response = await APIService.instance.get(endpoint: EndpointsConstant.productList);

      var str = jsonEncode(response.data);
      return productListModelFromJson(str);

    } catch (error, st) {
      log("xxxx getProductList repo $error $st");
      throw Exception(error);
    }
  }
}
