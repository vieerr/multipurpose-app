import 'product_model.dart';

class PosModel {
  Set<Product> products = {};

  PosModel({required this.products});

  void addProduct(Product product) {
    products.add(product);
  }
}
