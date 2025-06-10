part of 'report_cubit.dart';

sealed class ReportState {}

final class ReportInitial extends ReportState {}

final class ReportLoading extends ReportState {}

final class ReportFailure extends ReportState {}

final class ReportLoaded extends ReportState {}
