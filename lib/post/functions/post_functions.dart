import 'package:intl/intl.dart';

String convertDate(String date) {
  DateTime _dateTime = DateTime.tryParse(date)!;
  Duration _diff = DateTime.now().difference(_dateTime);

  if (_diff.inDays < 1 && _dateTime.day == DateTime.now().day) {
    date = 'Today';
  } else if (_diff.inDays < 2 && _dateTime.day == DateTime.now().day - 1) {
    date = 'Yesterday';
  } else if (_diff.inDays < 365) {
    date = DateFormat.MMMd().format(_dateTime);
  } else {
    date = DateFormat('dd.MM.yyyy').format(_dateTime);
  }

  date = date + DateFormat(' \u2022 HH:mm').format(_dateTime);
  return date;
}

String convertCount(int count) {
  String _countString = count.toString();
  if (_countString.length < 5) {
    return _countString;
  } else if (_countString.length < 6 && count.remainder(1000) > 0) {
    return (count ~/ 1000).toString() +
        '.' +
        count.remainder(1000).toString()[0] +
        'K';
  } else if (_countString.length < 7) {
    return (count ~/ 1000).toString() + 'K';
  } else if (_countString.length < 9 && count.remainder(1000000) > 0) {
    return (count ~/ 1000000).toString() +
        '.' +
        count.remainder(1000000).toString()[0] +
        'M';
  } else {
    return (count ~/ 1000000).toString() + 'M';
  }

  
}
