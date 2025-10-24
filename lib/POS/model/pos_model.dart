import 'product_model.dart';

class PosModel {
  Set<Product> products = {};

  PosModel({required this.products});

  void addProduct(Product product) {
    if (products.any((p) => p.id == product.id)) {
      products.firstWhere((p) => p.id == product.id).increaseQuantity(1);
      return;
    }
    products.add(product);
  }

  void decreaseProductQuantity(String productId) {
    final product = products.firstWhere(
      (p) => p.id == productId,
      orElse: () => throw Exception('Producto no encontrado'),
    );
    product.decreaseQuantity(1);
    if (product.quantity == 0) {
      products.removeWhere((p) => p.id == productId);
    }
  }
}
