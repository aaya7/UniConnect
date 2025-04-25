class EndpointsConstant {
  static const String productList = "/products";
  static String productDetail({required int id}) => "/products/$id";
}