part of 'shared_preferences_cubit.dart';

class TimeslotStatusData {
  final TimeslotStatus status;
  final String id;
  const TimeslotStatusData({required this.status, required this.id});
}

enum TimeslotStatus {
  free,
  booked,
  unbooked;

  getButtonProviderText() {
    switch (this) {
      case TimeslotStatus.free:
        return 'Add To Schedule: ';
      case TimeslotStatus.booked:
        return 'Cancel Appointment: ';
      case TimeslotStatus.unbooked:
        return 'Remove from Schedule: ';
    }
  }
}

@immutable
class SharedPreferencesState {
  final List<ProviderData> providers;
  final List<ClientData> clients;
  final List<TimeslotData> timeslots;

  const SharedPreferencesState({required this.providers, required this.clients, required this.timeslots});

  factory SharedPreferencesState.defaultSharedPrefs() => const SharedPreferencesState(providers: [], clients: [], timeslots: []);

  SharedPreferencesState copyWith({List<ProviderData>? updateProviders, List<ClientData>? updateClients, List<TimeslotData>? updateTimeslots}) =>
      SharedPreferencesState(providers: updateProviders ?? providers, clients: updateClients ?? clients, timeslots: updateTimeslots ?? timeslots);
}
