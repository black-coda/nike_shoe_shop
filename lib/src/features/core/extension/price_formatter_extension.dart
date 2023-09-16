import 'package:intl/intl.dart';

extension PriceFormatter on num {
  String  toPriceForm() {
    final formatter = NumberFormat("#,##0.00", "en_US");
    return formatter.format(toDouble());
  }
}
