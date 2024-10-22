import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../model/trip.dart';

class TripHistoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Trip History')),
      body: FutureBuilder<List<Trip>>(
        future: _loadTripHistory(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No trips found.'));
          }

          final trips = snapshot.data!;
          return ListView.builder(
            itemCount: trips.length,
            itemBuilder: (context, index) {
              final trip = trips[index];
              return ListTile(
                title: Text('Distance: ${trip.distance} km'),
                subtitle: Text('Amount: \$${trip.totalAmount}\nDate: ${trip.date}'),
              );
            },
          );
        },
      ),
    );
  }

  Future<List<Trip>> _loadTripHistory() async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? tripHistory = prefs.getStringList('tripHistory') ?? [];

    return tripHistory.map((tripJson) => Trip.fromJson(jsonDecode(tripJson))).toList();
  }
}
