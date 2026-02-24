import 'package:intl/intl.dart';

String formatDateBydMMMyyyy(DateTime dateTime){
  return DateFormat("d MMM, yyyy").format(dateTime);
}