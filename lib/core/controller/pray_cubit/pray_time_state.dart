part of 'pray_time_cubit.dart';

@immutable
sealed class PrayTimeState {}

final class PrayTimeInitial extends PrayTimeState {}
final class PrayTimeLoading extends PrayTimeState {}
final class PrayTimeSuccess extends PrayTimeState {
  PrayResponse prayResponse;
  PrayTimeSuccess({required this.prayResponse});
}
final class PrayTimeFailure extends PrayTimeState {
  String errorMessage;
  PrayTimeFailure({required this.errorMessage});
}
