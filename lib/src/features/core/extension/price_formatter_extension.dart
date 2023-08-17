import 'package:intl/intl.dart';

extension IntPriceFormat on num {
  String toPriceFormat() {
    final formatter = NumberFormat("#,##0.00", "en_US");
    return formatter.format(toDouble());
  }
}
