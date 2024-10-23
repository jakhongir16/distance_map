import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:map_distance/src/bloc/auth_bloc/auth_bloc.dart';
import 'package:map_distance/src/bloc/trip/trip_bloc.dart';
import 'package:map_distance/src/ui/screens/history_page/dart/history_page.dart';

import '../../../model/trip.dart';


class MainPage extends StatefulWidget {
  const MainPage({super.key});
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  LatLng? startLocation;
  LatLng? endLocation;
  double totalDistance = 0.0; // Distance in kilometers
  double totalAmount = 0.0; // Fare amount

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess &&
            state.message == "Signed Out Successfully") {
          Navigator.of(context).pushReplacementNamed('/login');
        }
      },
      child: BlocListener<TripBloc, TripState>(
        listener: (context, state) {
          if (state is TripEnded) {
            _showTripSummary(context, state.trip);
          }
        },
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Main Page'),
            actions: [
              _buildPopupMenu(context),
            ],
          ),
          body: Column(
            children: [
              Expanded(
                child: _buildMap(),
              ),
              _buildTripControls(context),
              _buildTripStatus(),
              // Add a widget to display real-time distance and amount
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMap() {
    return FlutterMap(
      options: MapOptions(
        initialCenter: const LatLng(41.2995, 69.2401),
        initialZoom: 13.0,
        onTap: (tapPosition, point) {
          if (startLocation == null) {
            setState(() {
              startLocation = point;
            });
          } else {
            // Update distance whenever endLocation is tapped or changed
            setState(() {
              endLocation = point;
              _updateDistanceAndAmount(); // Real-time update
            });
          }
        },
      ),
      children: [
        openStreetMapTileLayer,
        MarkerLayer(
          markers: [
            if (startLocation != null)
              Marker(
                point: startLocation!,
                width: 60,
                height: 60,
                child: const Icon(
                    Icons.location_pin, size: 60, color: Colors.green),
              ),
            if (endLocation != null)
              Marker(
                point: endLocation!,
                width: 60,
                height: 60,
                child: const Icon(
                    Icons.location_pin, size: 60, color: Colors.red),
              ),
          ],
        ),
      ],
    );
  }

  void _updateDistanceAndAmount() {
    if (startLocation != null && endLocation != null) {
      final distance = Distance().as(
          LengthUnit.Kilometer, startLocation!, endLocation!);

      if (distance >= 0.01) { // Every 10 meters
        setState(() {
          totalDistance += distance;
          totalAmount = totalDistance * 5000; // Amount per kilometer
        });
      }
    }
  }

  Widget _buildTripStatus() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Distance: ${totalDistance.toStringAsFixed(2)} km'),
          Text('Amount: ${totalAmount.toStringAsFixed(0)} sum'),
        ],
      ),
    );
  }

  Widget _buildTripControls(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ElevatedButton(
            onPressed: () {
              if (startLocation != null && endLocation != null) {
                context.read<TripBloc>().add(
                    StartTrip(startLocation!, endLocation!));
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text(
                      'Please select both start and end locations')),
                );
              }
            },
            child: const Text('Start Trip'),
          ),
          ElevatedButton(
            onPressed: () {
              if (startLocation != null && endLocation != null) {
                context.read<TripBloc>().add(
                    EndTrip(totalAmount, totalDistance));
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text(
                      'Please select both start and end locations')),
                );
              }
            },
            child: const Text('End Trip'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TripHistoryPage()),
              );
            },
            child: const Text('View Trip History'),
          ),
        ],
      ),
    );
  }

  void _showTripSummary(BuildContext context, Trip trip) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Trip Summary'),
          content: Text('Distance: ${trip.distance} km\nTotal Amount: ${trip
              .totalAmount} sum'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  startLocation = null;
                  endLocation = null;
                  totalDistance = 0;
                  totalAmount = 0;
                });
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildPopupMenu(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        final user = FirebaseAuth.instance.currentUser;
        return PopupMenuButton<int>(
          onSelected: (item) => _onMenuSelected(item, context),
          itemBuilder: (context) =>
          [
            PopupMenuItem<int>(
              value: 0,
              child: Text('User: ${user?.email ?? 'Guest'}'),
            ),
            const PopupMenuDivider(),
            PopupMenuItem<int>(
              value: 1,
              child: const Text('Sign Out'),
              onTap: () {
                Navigator.of(context).pushReplacementNamed('/');
              },
            ),
          ],
        );
      },
    );
  }
  void _onMenuSelected(int item, BuildContext context) {
    if (item == 1) {
      context.read<AuthBloc>().add(SignOutRequested());
    }
  }
}
 TileLayer get openStreetMapTileLayer =>
      TileLayer(
        urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
        userAgentPackageName: 'dev.fleaflet.flutter_map.example',
      );
