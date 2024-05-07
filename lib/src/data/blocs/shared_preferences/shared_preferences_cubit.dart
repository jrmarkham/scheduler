// Flutter imports:
import 'package:flutter/foundation.dart';
// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scheduler/src/data/models/client_data.dart';
import 'package:scheduler/src/data/models/timeslot_data.dart';
import 'package:scheduler/src/globals/consts.dart';

import '../../../utils/string_utils.dart' as string_utils;
// Project imports:
import '../../models/provider_data.dart';
import '../../services/shared_preferences_services.dart';

part 'shared_preferences_state.dart';

class SharedPreferencesCubit extends Cubit<SharedPreferencesState> {
  late final BaseSharedPreferencesServices _sharedPreferencesServices;

  SharedPreferencesCubit({BaseSharedPreferencesServices? setSharedPreferencesServices}) : super(SharedPreferencesState.defaultSharedPrefs()) {
    _sharedPreferencesServices = setSharedPreferencesServices ?? SharedPreferencesServices();
    _initSharedPreferences();
  }

  void createProvider() {
    _sharedPreferencesServices.addProvider(ProviderData(id: string_utils.getRandomProviderID()));
    emit(state.copyWith(updateProviders: _sharedPreferencesServices.getProviders()));
  }

  void createClient() {
    _sharedPreferencesServices.addClient(ClientData(id: string_utils.getRandomClientID()));
    emit(state.copyWith(updateClients: _sharedPreferencesServices.getClients()));
  }

  void addTimeslot({required DateTime dateTime, required int startTime}) {
    //
    _sharedPreferencesServices.addTimeslotData(TimeslotData(
        id: string_utils.getRandomClientID(),
        isBooked: false,
        clientID: emptyClientID,
        startTime: startTime,
        providerID: state.providers.first.id,
        date: dateTime));
    emit(state.copyWith(updateTimeslots: _sharedPreferencesServices.getTimeslots()));
  }

  void removeTimeslot(String tsID) {
    _sharedPreferencesServices.removeTimeslotData(tsID);
    emit(state.copyWith(updateTimeslots: _sharedPreferencesServices.getTimeslots()));
  }

  void bookTimeslot(String tsID) {
    _sharedPreferencesServices.bookTimeslotData(timeslotID: tsID, clientID: state.clients.first.id);
    emit(state.copyWith(updateTimeslots: _sharedPreferencesServices.getTimeslots()));
  }

  void cancelBooking(String tsID) {
    _sharedPreferencesServices.cancelAppointmentData(tsID);

    emit(state.copyWith(updateTimeslots: _sharedPreferencesServices.getTimeslots()));
  }

  _initSharedPreferences() async {
    await _sharedPreferencesServices.initSharedPreferences();
    emit(state.copyWith(
        updateProviders: _sharedPreferencesServices.getProviders(),
        updateClients: _sharedPreferencesServices.getClients(),
        updateTimeslots: _sharedPreferencesServices.getTimeslots()));
  }

  // conviences
  TimeslotStatusData getTimeSlotStatus({required DateTime datetime, required int startTime}) {
    if (state.timeslots.any((TimeslotData tsd) => tsd.date == datetime && tsd.startTime == startTime)) {
      final TimeslotData timeslotData = state.timeslots.singleWhere((TimeslotData tsd) => tsd.date == datetime && tsd.startTime == startTime);
      return TimeslotStatusData(id: timeslotData.id, status: timeslotData.isBooked ? TimeslotStatus.booked : TimeslotStatus.unbooked);
    }

    return const TimeslotStatusData(status: TimeslotStatus.free, id: emptyTimeslotID);
  }

  List<TimeslotData> getBookedTimeSlots() {
    final List<TimeslotData> appointments = [];
    for (final TimeslotData timeslotData in state.timeslots) {
      if (timeslotData.isBooked) {
        appointments.add(timeslotData);
      }
    }

    return appointments;
  }
}
