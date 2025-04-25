import 'package:get/get.dart';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:uniconnect/app/data/repositories/product_repository.dart';
import '../../../data/models/product_details_model.dart';

class ProductDetailController extends GetxController {
  final isLoading = true.obs;
  final productDetailsModel = ProductDetailsModel().obs;

  int? id;

  final formKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      if (Get.arguments["id"] != null) {
        id = Get.arguments["id"];
      }
    }
    fetchProductDetails();
  }

    @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }


  Future<void> fetchProductDetails() async {
    try {
      isLoading(true);
      productDetailsModel( await ProductRepository.instance.getProductDetails(id: id ?? 0));
    } catch (error, st) {
      log("Error fetching product details: $error $st");
    } finally {
      isLoading(false);
    }
  }
}
