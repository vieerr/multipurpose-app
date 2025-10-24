import 'package:flutter/material.dart';
import 'package:multipurpose_app/POS/controller/invoice_controller.dart';
import 'package:multipurpose_app/POS/model/product_model.dart';
import 'package:multipurpose_app/POS/view/components/products_dropdown.dart';

class InvoiceView extends StatefulWidget {
  const InvoiceView({super.key});

  @override
  State<InvoiceView> createState() => _InvoiceViewState();
}

class _InvoiceViewState extends State<InvoiceView> {
  final controller = InvoiceController();

  // void _calcular() {
  //   final resultado = controller.calcularSueldo(
  //     venta1Ctrl.text,
  //     venta2Ctrl.text,
  //     venta3Ctrl.text,
  //   );
  //   Navigator.pushNamed(context, '/resultado', arguments: resultado);
  // }

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
    return Scaffold(
      appBar: AppBar(title: Text('Punto de venta')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
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
        ),
      ),
    );
  }
}
