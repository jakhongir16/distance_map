import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:latlong2/latlong.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/repositories/trip_repository/trip_repository.dart';
import '../../model/trip.dart';

part 'trip_event.dart';
part 'trip_state.dart';

class TripBloc extends Bloc<TripEvent, TripState> {
  final TripRepository tripRepository;
  TripBloc(this.tripRepository) : super(TripInitial()) {
    on<StartTrip>((event, emit) {
      emit(TripInProgress());
    });
    on<EndTrip>((event, emit) async {
      final trip = Trip(
        date: DateTime.now(),
        distance: event.distance,
        totalAmount: event.totalAmount
      );

      await tripRepository.saveTrip(trip);
      _saveTripHistory(trip);
      emit(TripEnded(trip));
    });
  }

  void _saveTripHistory(Trip trip) async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? tripHistory = prefs.getStringList('tripHistory') ?? [];

    // Convert trip to JSON and save it
    tripHistory.add(jsonEncode(trip.toJson()));
    await prefs.setStringList('tripHistory', tripHistory);
  }
}
