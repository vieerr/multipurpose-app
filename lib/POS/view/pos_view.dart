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
  final InvoiceController _invoiceController = InvoiceController();
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
            _invoiceController.resetInvoice();
            _posController.resetInvoices();
            _showHistory = false;
          });
        },
      );
    }

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: InvoiceView(
              controller: _invoiceController,
              invoiceNumber: _posController.previousInvoices.length + 1,
            ),
          ),
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
              final invoiceAdded = _posController.addInvoice(
                _invoiceController.getInvoice(),
              );
              setState(() {
                _invoiceController.resetInvoice();
              });
              if (invoiceAdded) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Factura creada exitosamente',
                      style: TextStyle(color: Colors.white),
                    ),
                    duration: Duration(seconds: 2),
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    margin: EdgeInsets.only(top: 10, left: 10, right: 10),
                    elevation: 0,
                  ),
                );
              }
            },
            icon: Icon(Icons.receipt_long),
            label: Text('Facturar'),
          ),
        ],
      ),
    );
  }
}
