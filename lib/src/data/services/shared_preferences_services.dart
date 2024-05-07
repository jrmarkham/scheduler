// Dart imports:
import 'dart:async';

import 'package:scheduler/src/data/models/client_data.dart';
import 'package:scheduler/src/data/models/provider_data.dart';
import 'package:scheduler/src/globals/consts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/timeslot_data.dart';

// data management
const String _providerList = 'providerList';
const String _clientList = 'clientList';
const String _timeslotList = 'scheduleList';
//
const String _itemSplitter = '##';

abstract class BaseSharedPreferencesServices {
  // init
  Future<void> initSharedPreferences();

  List<ProviderData> getProviders();

  void addProvider(ProviderData provider);

  List<ClientData> getClients();

  void addClient(ClientData client);

  List<TimeslotData> getTimeslots();

  void addTimeslotData(TimeslotData timeslot);

  // update timeslots
  void removeTimeslotData(String timeslotID);

  void bookTimeslotData({required String timeslotID, required String clientID});

  void cancelAppointmentData(String timeslotID);
}

class SharedPreferencesServices extends BaseSharedPreferencesServices {
  static final SharedPreferencesServices _instance = SharedPreferencesServices.internal();

  factory SharedPreferencesServices() => _instance;

  SharedPreferencesServices.internal();

  late final SharedPreferences prefs;
  bool isInit = false;

  @override
  Future<void> initSharedPreferences() async {
    if (isInit) return;
    isInit = true;
    prefs = await SharedPreferences.getInstance();
  }

  @override
  List<ProviderData> getProviders() => _stringListToProvider(prefs.getStringList(_providerList) ?? []);

  @override
  void addProvider(ProviderData provider) {
    final List<ProviderData> providers = getProviders();
    providers.add(provider);
    prefs.setStringList(_providerList, _providerListToStrings(providers));
  }

  @override
  List<ClientData> getClients() => _stringListToClient(prefs.getStringList(_clientList) ?? []);

  @override
  void addClient(ClientData client) {
    final List<ClientData> clients = getClients();
    clients.add(client);
    prefs.setStringList(_clientList, _clientListToStrings(clients));
  }

  @override
  List<TimeslotData> getTimeslots() => _stringListToTimeslot(prefs.getStringList(_timeslotList) ?? []);

  @override
  void addTimeslotData(TimeslotData timeslot) {
    final List<TimeslotData> timeslots = getTimeslots();
    timeslots.add(timeslot);
    prefs.setStringList(_timeslotList, _timeslotListToStrings(timeslots));
  }

  // update timeslots
  @override
  void removeTimeslotData(String timeslotID) {
    final List<TimeslotData> timeslots = getTimeslots();
    timeslots.removeWhere((TimeslotData tsd) => tsd.id == timeslotID);
    prefs.setStringList(_timeslotList, _timeslotListToStrings(timeslots));
  }

  @override
  void bookTimeslotData({required String timeslotID, required String clientID}) {
    final List<TimeslotData> timeslots = getTimeslots();
    final int idx = timeslots.indexWhere((TimeslotData tsd) => tsd.id == timeslotID);

    final TimeslotData tsd = timeslots[idx];

    timeslots.replaceRange(idx, idx + 1, [tsd.copyWith(updateClient: clientID, updateBooking: true)]);

    prefs.setStringList(_timeslotList, _timeslotListToStrings(timeslots));
  }

  @override
  void cancelAppointmentData(String timeslotID) {
    final List<TimeslotData> timeslots = getTimeslots();
    final int idx = timeslots.indexWhere((TimeslotData tsd) => tsd.id == timeslotID);

    final TimeslotData tsd = timeslots[idx];
    // could use copy
    timeslots.replaceRange(idx, idx + 1, [tsd.copyWith(updateClient: emptyClientID, updateBooking: false)]);

    prefs.setStringList(_timeslotList, _timeslotListToStrings(timeslots));
  }

  List<String> _providerListToStrings(List<ProviderData> providerData) {
    List<String> returnData = [];
    for (final ProviderData item in providerData) {
      returnData.add(item.id);
    }
    return returnData;
  }

  List<ProviderData> _stringListToProvider(List<String> data) {
    List<ProviderData> returnData = [];
    for (final String item in data) {
      returnData.add(ProviderData(id: item));
    }
    return returnData;
  }

  List<String> _clientListToStrings(List<ClientData> clientData) {
    List<String> returnData = [];
    for (final ClientData item in clientData) {
      returnData.add(item.id);
    }
    return returnData;
  }

  List<ClientData> _stringListToClient(List<String> data) {
    List<ClientData> returnData = [];
    for (final String item in data) {
      returnData.add(ClientData(id: item));
    }
    return returnData;
  }

  List<String> _timeslotListToStrings(List<TimeslotData> timeslotData) {
    List<String> returnData = [];
    for (final TimeslotData item in timeslotData) {
      returnData.add(item.id +
          _itemSplitter +
          item.date.toString() +
          _itemSplitter +
          item.startTime.toString() +
          _itemSplitter +
          item.providerID +
          _itemSplitter +
          item.isBooked.toString() +
          _itemSplitter +
          item.clientID);
    }
    return returnData;
  }

  List<TimeslotData> _stringListToTimeslot(List<String> data) {
    List<TimeslotData> returnData = [];
    for (final String item in data) {
      final List<String> dataList = item.split(_itemSplitter);

      returnData.add(TimeslotData(
          id: dataList[0],
          date: DateTime.parse(dataList[1]),
          startTime: int.parse(dataList[2]),
          providerID: dataList[3],
          isBooked: dataList[4] == 'true',
          clientID: dataList[5]));
    }
    return returnData;
  }
}
