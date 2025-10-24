import 'package:flutter/material.dart';
import 'package:multipurpose_app/POS/controller/invoice_controller.dart';
import 'package:multipurpose_app/POS/controller/pos_controller.dart';
import 'package:multipurpose_app/POS/view/invoice_view.dart';
import 'package:multipurpose_app/POS/view/invoice_history_view.dart';

class PosView extends StatefulWidget {
  const PosView({super.key});

  @override
  State<PosView> createState() => _PosViewState();
}

class _PosViewState extends State<PosView> {
  InvoiceController _invoiceController = InvoiceController();
  final PosController _posController = PosController();
  bool _showHistory = false;

  @override
  Widget build(BuildContext context) {
    if (_showHistory) {
      return InvoiceHistoryView(
        invoices: _posController.previousInvoices,
        onNewDay: () {
          setState(() {
            _showHistory = false;
          });
        },
        onOpenNewCaja: () {
          setState(() {
            _invoiceController = InvoiceController();
            _showHistory = false;
          });
        },
      );
    }

    return Scaffold(
      body: Column(
        children: [
          Expanded(child: InvoiceView(controller: _invoiceController)),
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton.extended(
            onPressed: () {
              setState(() {
                _showHistory = true;
              });
            },
            icon: Icon(Icons.close),
            label: Text('Cerrar Caja'),
          ),
          SizedBox(height: 16),
          FloatingActionButton.extended(
            onPressed: () {
              setState(() {
                _posController.addInvoice(_invoiceController.getInvoice());
                _invoiceController.resetInvoice();
              });
            },
            icon: Icon(Icons.receipt_long),
            label: Text('Facturar'),
          ),
        ],
      ),
    );
  }
}
