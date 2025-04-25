import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'dart:developer';
import 'package:uniconnect/app/data/repositories/product_repository.dart';
import '../../../data/models/product_models.dart';

class ProductController extends GetxController {
  final isLoading = true.obs;
  final productList = <ProductListModel>[].obs;
  final filteredProductList = <ProductListModel>[].obs;
  final searchController = TextEditingController();
  final allCategories = <String>[].obs;
  final selectedCategory = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchProducts();

    searchController.addListener(() {
      searchProducts(searchController.text);
    });
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> searchProducts(String title) async {
    try {
      isLoading(true);
      if (title.isEmpty) {
        filteredProductList.assignAll(productList);
      } else {
        filteredProductList.assignAll(
          productList.where((product) => 
          product.title!.toLowerCase().contains(title.toLowerCase())
          ).toList()
        );
      }
    } catch (error, st) {
      log("Error search product: $error $st");
    } finally {
      isLoading(false);
    }
  }

  Future<void> fetchProducts() async {
    try {
      isLoading(true);
      productList(await ProductRepository.instance.fetchProducts());
      final categories = productList.map((p) => p.category ?? '').toSet().toList();
      allCategories.assignAll(['All', ...categories]);
      filteredProductList.assignAll(productList);

    } catch (error, st) {
      log("Error fetching product list: $error $st");
    } finally {
      isLoading(false);
    }
  }

  Future<void> setCategory(String category) async {
    selectedCategory.value = category;
    filterProductsByCategory(category);
  }

  Future<void> filterProductsByCategory(String category) async {
    if (category == 'All') {
      filteredProductList.assignAll(productList);
    } else {
      filteredProductList.assignAll(
          productList.where((product) => 
          product.category == category).toList(),
        );
    }
  }
}
