// Dart imports:
// Package imports:
import 'package:random_string/random_string.dart' show randomAlphaNumeric;
import 'package:intl/intl.dart';

import '../globals/consts.dart';

//  Id
String getRandomProviderID() => 'Provider-${randomAlphaNumeric(10)}';

String getRandomClientID() => 'Client-${randomAlphaNumeric(10)}';

String getRandomTimeslotID() => 'TS-${randomAlphaNumeric(25)}';

String getTimeSlotDisplay(int idx) => idx < timeslotsDisplay.length ? timeslotsDisplay[idx] : 'Error Bad Index';

String getDateDisplay(DateTime dateTime) => DateFormat.yMMMMd().format(dateTime);
