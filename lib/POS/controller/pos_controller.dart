import 'package:multipurpose_app/POS/model/pos_model.dart';
import 'package:multipurpose_app/POS/model/product_model.dart';

class PosController {
  static final PosModel posModel = PosModel(products: {});

  void agregarProducto(String id, String name, String priceStr) {
    final price = double.tryParse(priceStr);
    if (price != null) {
      final product = Product(id: id, name: name, price: price);
      if (!posModel.products.any((p) => p.id == id)) {
        print("Agregando producto: $name");
        posModel.addProduct(product);
      } else {
        print("El producto $name ya está en la lista, no se agrega de nuevo.");
      }
    } else {
      throw Exception('Precio inválido');
    }
  }

  List<Product> getProducts() {
    return List.unmodifiable(posModel.products);
  }
}
