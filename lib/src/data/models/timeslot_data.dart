/// [0(9am) 1(9:20) 2(9:40) 3(10) 4(10:15) 5(10:20) 6(10:40)]

class TimeslotData {
  final String id;
  final int startTime;
  final DateTime date;
  final bool isBooked;
  final String providerID;
  final String clientID;
  const TimeslotData(
      {required this.id, required this.date, required this.startTime, required this.isBooked, required this.providerID, required this.clientID});

  TimeslotData copyWith({required String updateClient, required bool updateBooking}) =>
      TimeslotData(id: id, date: date, providerID: providerID, startTime: startTime, clientID: updateClient, isBooked: updateBooking);
}
