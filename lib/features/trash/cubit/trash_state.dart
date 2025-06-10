part of 'trash_cubit.dart';

sealed class TrashState {}

final class TrashInitial extends TrashState {}

final class TrashLoading extends TrashState {}

final class TrashLoaded extends TrashState {
  final List<DocumentSnapshot> maps;

  TrashLoaded(this.maps);
}
