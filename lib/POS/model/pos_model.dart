import 'package:multipurpose_app/POS/model/invoice_model.dart';

class PosModel {
  List<InvoiceModel> invoices = [];
  PosModel({required this.invoices});
  void addInvoice(InvoiceModel invoice) {
    invoices.add(invoice);
  }
}
