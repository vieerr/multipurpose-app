import 'package:flutter/material.dart';
import 'package:multipurpose_app/POS/model/product_model.dart';

class ProductsDropdown extends StatefulWidget {
  const ProductsDropdown({super.key, required this.onChanged});

  final ValueChanged<Product?> onChanged;

  @override
  State<StatefulWidget> createState() => _ProductsDropdownState();
}

class _ProductsDropdownState extends State<ProductsDropdown> {
  Product? selectedProduct;

  final List<DropdownMenuItem<Product>> productItems = [
    DropdownMenuItem(
      value: Product(id: "1", name: "Camiseta Roja", price: 13),
      child: Text("Camiseta Roja"),
    ),
    DropdownMenuItem(
      value: Product(id: "2", name: "Pantalón Azul", price: 25),
      child: Text("Pantalón Azul"),
    ),
    DropdownMenuItem(
      value: Product(id: "3", name: "Zapatos Negros", price: 45),
      child: Text("Zapatos Negros"),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return DropdownButton<Product>(
      value: selectedProduct,
      items: productItems,
      hint: Text("Seleccione un producto"),
      onChanged: (value) {
        setState(() {
          selectedProduct = value;
        });
        widget.onChanged(value);
      },
    );
  }
}
