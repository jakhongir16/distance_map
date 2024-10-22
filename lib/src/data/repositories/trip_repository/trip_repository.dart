import 'package:shared_preferences/shared_preferences.dart';

import '../../../model/trip.dart';

class TripRepository {
  Future<List<Trip>> getTrips() async {
    final preps = await SharedPreferences.getInstance();
    final tripData = preps.getStringList('trips') ?? [];
    return tripData.map((trip){
        final parts = trip.split(',');
        return Trip(
          date: DateTime.parse(parts[0]),
          distance: double.parse(parts[1]),
          totalAmount: double.parse(parts[2])
        );
    }).toList();
  }


  Future<void> saveTrip (Trip trip) async {
    final preps = await SharedPreferences.getInstance();
    final tripData = preps.getStringList('trips') ?? [];
    tripData.add('${trip.date.toIso8601String()},${trip.distance},${trip.totalAmount}');
    await preps.setStringList('trips', tripData);
  }
}