part of 'trashmap_cubit.dart';

sealed class TrashmapState {}

final class TrashmapInitial extends TrashmapState {}

final class TrashmapLoading extends TrashmapState {}

final class TrashmapLoaded extends TrashmapState {
  final List<DocumentSnapshot> maps;

  TrashmapLoaded(this.maps);
}
