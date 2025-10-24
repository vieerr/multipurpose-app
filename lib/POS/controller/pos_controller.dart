import 'package:multipurpose_app/POS/model/pos_model.dart';
import 'package:multipurpose_app/POS/model/product_model.dart';

class PosController {
  static final PosModel posModel = PosModel(products: {});

  void agregarProducto(String id, String name, String priceStr) {
    final price = double.tryParse(priceStr);
    if (price != null) {
      final product = Product(id: id, name: name, price: price);
      posModel.addProduct(product);
    } else {
      throw Exception('Precio inválido');
    }
  }

  List<Product> getProducts() {
    return List.unmodifiable(posModel.products);
  }
}
