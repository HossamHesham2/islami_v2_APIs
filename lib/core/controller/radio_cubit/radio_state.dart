part of 'radio_cubit.dart';

@immutable
sealed class RadioState {}

final class RadioInitial extends RadioState {}
final class RadioLoading extends RadioState {}
final class RadioSuccess extends RadioState {
  List<RadioModel> radioList = [] ;
  RadioSuccess(this.radioList);
}
final class RadioFailure extends RadioState {
  String errorMessage ;
  RadioFailure({required this.errorMessage});
}
