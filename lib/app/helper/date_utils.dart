import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

String formatTanggal(String input) {
  try {
    // Pastikan locale Indonesia telah diinisialisasi
    initializeDateFormatting('id_ID', null);

    final parsed = DateFormat("EEE, dd MMM yyyy HH:mm:ss zzz", 'en_US')
        .parseUTC(input)
        .toLocal();

    return DateFormat("dd MMMM yyyy, HH:mm", 'id_ID').format(parsed);
  } catch (e) {
    return "Format tidak valid";
  }
}
