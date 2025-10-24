import 'package:multipurpose_app/POS/model/invoice_model.dart';
import 'package:multipurpose_app/POS/model/pos_model.dart';

class PosController {
  static final PosModel posModel = PosModel(invoices: []);
  bool addInvoice(InvoiceModel invoice) {
    if (invoice.products.isEmpty) return false;
    posModel.addInvoice(invoice);
    return true;
  }

  List<InvoiceModel> get previousInvoices {
    return List.unmodifiable(posModel.invoices);
  }

  void resetInvoices() {
    posModel.invoices.clear();
  }
}
