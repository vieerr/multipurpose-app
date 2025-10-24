import 'package:multipurpose_app/POS/model/invoice_model.dart';
import 'package:multipurpose_app/POS/model/pos_model.dart';

class PosController {
  static final PosModel posModel = PosModel(invoices: []);
  void addInvoice(InvoiceModel invoice) {
    posModel.addInvoice(invoice);
  }

  List<InvoiceModel> get previousInvoices {
    return List.unmodifiable(posModel.invoices);
  }
}
