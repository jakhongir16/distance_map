part of 'trip_bloc.dart';

abstract class TripEvent extends Equatable {
  const TripEvent();

  @override
  List<Object> get props => [];
}


class StartTrip extends TripEvent {
  final LatLng startLocation;
  final LatLng endLocation;

  StartTrip(this.startLocation, this.endLocation);
}

class EndTrip extends TripEvent {
  final double distance;
  final double totalAmount;

  const EndTrip(this.totalAmount, this.distance);
}