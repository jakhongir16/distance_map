part of 'trip_bloc.dart';

abstract class TripState extends Equatable {
  const TripState();
  @override
  List<Object> get props => [];
}

class TripInitial extends TripState {
  @override
  List<Object> get props => [];
}

class TripInProgress extends TripState {}

class TripEnded extends TripState {
  final Trip trip;
  const TripEnded(this.trip);
}