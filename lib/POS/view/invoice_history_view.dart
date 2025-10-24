import 'package:flutter/material.dart';
import 'package:multipurpose_app/POS/model/invoice_model.dart';

class InvoiceHistoryView extends StatelessWidget {
  final List<InvoiceModel> invoices;
  final VoidCallback onNewDay;
  final VoidCallback onOpenNewCaja;

  const InvoiceHistoryView({
    super.key,
    required this.invoices,
    required this.onNewDay,
    required this.onOpenNewCaja,
  });

  double _calculateTotalValue() {
    double total = 0;
    for (final invoice in invoices) {
      for (final product in invoice.products) {
        total += product.price * product.quantity;
      }
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    final totalValue = _calculateTotalValue();

    return Scaffold(
      appBar: AppBar(title: Text('Cierre de Caja')),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(16),
            color: Colors.blue[50],
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Total del Día',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                SizedBox(height: 8),
                Text(
                  '\$${totalValue.toStringAsFixed(2)}',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Facturas: ${invoices.length}',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: invoices.length,
              itemBuilder: (context, index) {
                final invoice = invoices[index];
                double invoiceTotal = 0;
                for (final product in invoice.products) {
                  invoiceTotal += product.price * product.quantity;
                }

                return Card(
                  margin: EdgeInsets.all(8),
                  child: ExpansionTile(
                    title: Text('Factura #${index + 1}'),
                    subtitle: Text('\$${invoiceTotal.toStringAsFixed(2)}'),
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: invoice.products.length,
                        itemBuilder: (context, productIndex) {
                          final product = invoice.products.elementAt(
                            productIndex,
                          );
                          return ListTile(
                            title: Text(product.name),
                            subtitle: Text(
                              'Cantidad: ${product.quantity} x \$${product.price.toStringAsFixed(2)}',
                            ),
                            trailing: Text(
                              '\$${(product.price * product.quantity).toStringAsFixed(2)}',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          );
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
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton.icon(
                onPressed: onNewDay,
                icon: Icon(Icons.arrow_back),
                label: Text('Volver'),
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: ElevatedButton.icon(
                onPressed: onOpenNewCaja,
                icon: Icon(Icons.add),
                label: Text('Nueva Caja'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
