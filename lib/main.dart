import 'dart:developer';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:uniconnect/app/core/http_services.dart';
import 'package:uniconnect/app/modules/product_detail/controllers/product_detail_controller.dart';
import 'package:uniconnect/app/routes/app_pages.dart';
import 'package:uniconnect/app/data/repositories/product_repository.dart';
import 'package:uniconnect/app/modules/product/controllers/product_controller.dart';
import 'package:flutter_downloader/flutter_downloader.dart';

void main() async {
WidgetsFlutterBinding.ensureInitialized();
await FlutterDownloader.initialize();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await initDependencies();

  runApp(
    GetMaterialApp(
      title: "UNICONNECT",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
     
    ),
  );
}

Future<void> initDependencies() async {
  try {
    /**
     * enable this for firebase notification
     */

    Get.put(APIService(), permanent: true);

    /**
     * Screen Controller Dependencies
     */

    Get.lazyPut<ProductController>(() => ProductController(), fenix: true);
    Get.lazyPut<ProductDetailController>(() => ProductDetailController(), fenix: true);

    /**
     * Repositories Dependencies
     */
    Get.lazyPut<ProductRepository>(() => ProductRepository(), fenix: true);
  } catch (error) {
    log("Init Dependencies Error : $error");
  }
}
