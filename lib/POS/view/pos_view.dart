import 'package:flutter/material.dart';
import 'package:multipurpose_app/POS/controller/invoice_controller.dart';
import 'package:multipurpose_app/POS/controller/pos_controller.dart';
import 'package:multipurpose_app/POS/view/invoice_view.dart';

class PosView extends StatefulWidget {
  const PosView({super.key});

  @override
  State<PosView> createState() => _PosViewState();
}

class _PosViewState extends State<PosView> {
  InvoiceController _invoiceController = InvoiceController();
  final PosController _posController = PosController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(child: InvoiceView(controller: _invoiceController)),
          Container(
            height: 200, // Adjust height as needed
            color: Colors.grey[200], // Optional background color
            child: ListView.builder(
              itemCount: _posController.previousInvoices.length,
              itemBuilder: (context, index) {
                final invoice = _posController.previousInvoices[index];
                return ListTile(
                  title: Text('Invoice #${index + 1}'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: invoice.products.map<Widget>((product) {
                      return Text(
                        '${product.name} - \$${product.price.toStringAsFixed(2)}',
                      );
                    }).toList(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          setState(() {
            _posController.addInvoice(_invoiceController.getInvoice());
            _invoiceController.resetInvoice();
          });
        },
        icon: Icon(Icons.receipt_long), // Optional icon
        label: Text('Facturar'), // Text label
      ),
    );
  }
}
