import 'package:intl/intl.dart';

class HumanFormats {
  static String number(double value) {
    final formattedNumber =
        NumberFormat.compactCurrency(decimalDigits: 0, symbol: '', locale: 'en')
            .format(value);

    return formattedNumber;
  }

}



