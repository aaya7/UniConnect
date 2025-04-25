import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart' as getx;
import 'package:dio/dio.dart';
import 'package:uniconnect/app/core/http_services.dart';
import 'package:uniconnect/app/data/constant/endpoints_constant.dart';
import 'package:uniconnect/app/data/models/product_details_model.dart';
import '../models/product_models.dart';

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

    Future<ProductDetailsModel> getProductDetails({required int id}) async {
    try {
      Response response = await APIService.instance.get(endpoint: EndpointsConstant.productDetail(id: id));

      var str = jsonEncode(response.data);

      return productDetailsModelFromJson(str);
    } catch (error, st) {
      log("xxx getProductDetails $error $st");
      throw Exception(error);
    }
  }
}
