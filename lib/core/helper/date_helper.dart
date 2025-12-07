import 'package:intl/intl.dart';

String formatOrderDate(String? rawDate) {
  if (rawDate == null || rawDate.isEmpty) return '';

  try {
    final parsedDate = DateFormat("EEE, dd MMM yyyy HH:mm:ss 'GMT'")
        .parse(rawDate, true)
        .toLocal();

    return DateFormat('dd MMM yyyy • hh:mm a').format(parsedDate);
  } catch (e) {
    return rawDate;
  }
}
