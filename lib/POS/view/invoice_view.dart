import 'package:flutter/material.dart';
import 'package:multipurpose_app/POS/controller/invoice_controller.dart';
import 'package:multipurpose_app/POS/model/product_model.dart';
import 'package:multipurpose_app/POS/view/components/products_dropdown.dart';

class InvoiceView extends StatefulWidget {
  const InvoiceView({
    super.key,
    required this.controller,
    required this.invoiceNumber,
  });

  final InvoiceController controller;
  final int invoiceNumber;

  @override
  State<InvoiceView> createState() => _InvoiceViewState();
}

class _InvoiceViewState extends State<InvoiceView> {
  InvoiceController get controller => widget.controller;
  void _onProductSelected(Product? product) {
    setState(() {
      controller.agregarProducto(
        product?.id ?? "",
        product?.name ?? "",
        product?.price.toString() ?? "0",
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Factura #${widget.invoiceNumber}',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        ProductsDropdown(onChanged: _onProductSelected),
        Expanded(
          child: ListView.builder(
            itemCount: controller.getProducts().length,
            itemBuilder: (context, index) {
              final producto = controller.getProducts()[index];
              return ListTile(
                title: Text(producto.name),
                subtitle: Text(
                  'Precio: ${producto.price}, Cantidad: ${producto.quantity.toString()}',
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.remove),
                      onPressed: () {
                        setState(() {
                          controller.disminuirCantidadProducto(producto.id);
                        });
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () {
                        setState(() {
                          controller.agregarProducto(
                            producto.id,
                            producto.name,
                            producto.price.toString(),
                          );
                        });
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
