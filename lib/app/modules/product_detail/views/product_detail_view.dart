import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:uniconnect/app/data/constant/double_extensions.dart';
import '../../../data/models/product_details_model.dart';
import '../controllers/product_detail_controller.dart';
import 'package:photo_view/photo_view.dart';

class ProductDetailView extends GetView<ProductDetailController> {
  const ProductDetailView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( title: 
      const Text(
        "Product Details",
        style: TextStyle(
          fontWeight: FontWeight.bold, 
          color: Colors.deepPurple),
      )),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        
        ProductDetailsModel? product = controller.productDetailsModel.value;

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // Display image with zoom in/out by tapping
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.deepPurple),
                  borderRadius: BorderRadius.circular(50),
                ),
                height: 400,
                child: PhotoView(
                  imageProvider: NetworkImage(product.image ?? ''),
                  errorBuilder: (_, __, ___) =>
                      const Center(child: Icon(Icons.broken_image, size: 100)),
                  loadingBuilder: (context, event) =>
                      const Center(child: CircularProgressIndicator()),
                  backgroundDecoration: const BoxDecoration(color: Colors.transparent),
                  minScale: PhotoViewComputedScale.contained * 1.0,
                  maxScale: PhotoViewComputedScale.covered * 2.0,
                  initialScale: PhotoViewComputedScale.contained,
                ),
              ),
              16.0.height,

              Text(
                product.title ?? '',
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              8.0.height,

              Text(
                "\$${product.price?.toStringAsFixed(2) ?? '0.00'}",
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.blue,
                  fontWeight: FontWeight.w600,
                ),
              ),
              8.0.height,

              if (product.rating != null) ...[
                RatingBarIndicator(
                  rating: product.rating!.rate!,
                  itemBuilder: (context, _) => const Icon(Icons.star, color: Colors.amber),
                  itemCount: 5,
                  itemSize: 24.0,
                  direction: Axis.horizontal,
                ),
                Text(
                  "${product.rating!.count} reviews",
                  style: const TextStyle(
                    fontSize: 12, 
                    color: Colors.grey),
                ),
              ],
              16.0.height,

              Text(
                "Description".toUpperCase(),
                style: const TextStyle(
                  color: Colors.deepPurple,
                  fontSize: 16, 
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                  decoration: TextDecoration.underline),
              ),
              8.0.height,
              Text(
                product.description ?? '',
                style: const TextStyle(fontSize: 14),
              ),
            ],
          ),
        );
      }),
    );
  }
}
