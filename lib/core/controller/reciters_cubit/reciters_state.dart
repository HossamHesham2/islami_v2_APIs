part of 'reciters_cubit.dart';

@immutable
sealed class RecitersState {}

final class RecitersInitial extends RecitersState {}
final class RecitersLoading extends RecitersState {}
final class RecitersSuccess extends RecitersState {
  List<ReciterModel> recitersList = [];
  RecitersSuccess(this.recitersList);
}
final class RecitersFailure extends RecitersState {
  String errorMessage;
  RecitersFailure({required this.errorMessage});
}
