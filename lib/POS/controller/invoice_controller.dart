import 'package:multipurpose_app/POS/model/invoice_model.dart';
import 'package:multipurpose_app/POS/model/product_model.dart';

class InvoiceController {
  static final InvoiceModel invoiceModel = InvoiceModel(products: {});

  void agregarProducto(String id, String name, String priceStr) {
    final price = double.tryParse(priceStr);
    if (price != null) {
      final product = Product(id: id, name: name, price: price);
      invoiceModel.addProduct(product);
    } else {
      throw Exception('Precio inválido');
    }
  }

  void disminuirCantidadProducto(String productId) {
    invoiceModel.decreaseProductQuantity(productId);
  }

  List<Product> getProducts() {
    return List.unmodifiable(invoiceModel.products);
  }

  InvoiceModel getInvoice() {
    return InvoiceModel(products: Set.from(invoiceModel.products));
  }

  void resetInvoice() {
    invoiceModel.products.clear();
  }
}
