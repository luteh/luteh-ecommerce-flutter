import 'package:intl/intl.dart';

extension NumberExtention on num {
  String toIdr({int decimalDigit = 0}) {
    NumberFormat currencyFormatter = NumberFormat.currency(
      locale: 'id',
      symbol: 'Rp ',
      decimalDigits: decimalDigit,
    );
    return currencyFormatter.format(this);
  }
}
