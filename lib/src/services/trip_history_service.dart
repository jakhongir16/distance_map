import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../model/trip.dart';

class TripHistoryService {
  Future<void> saveTripHistory(Trip trip) async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? tripHistory = prefs.getStringList('tripHistory') ?? [];

    // Convert trip to JSON and save it
    tripHistory.add(jsonEncode(trip.toJson()));

    await prefs.setStringList('tripHistory', tripHistory);
  }

  Future<List<Trip>> loadTripHistory() async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? tripHistory = prefs.getStringList('tripHistory') ?? [];

    return tripHistory.map((tripJson) => Trip.fromJson(jsonDecode(tripJson))).toList();
  }
}