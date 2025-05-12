import 'package:intl/intl.dart';

String formatTanggal(String input) {
  try {
    final parsed = DateFormat("EEE, dd MMM yyyy HH:mm:ss 'GMT'", 'en_US')
        .parse(input, true);

    return DateFormat("d MMMM yyyy, HH:mm", 'id_ID').format(parsed);
  } catch (e) {
    return "Format tidak valid";
  }
}

String formatTanggalOnly(String input) {
  try {
    final parsed = DateFormat("EEE, dd MMM yyyy HH:mm:ss 'GMT'", 'en_US')
        .parse(input, true);

    return DateFormat("d MMMM yyyy", 'id_ID').format(parsed);
  } catch (e) {
    return "Format tidak valid";
  }
}
