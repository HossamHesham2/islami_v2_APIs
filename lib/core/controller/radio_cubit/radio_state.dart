part of 'radio_cubit.dart';

@immutable
sealed class RadioState extends Equatable {}

final class RadioInitial extends RadioState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
final class RadioLoading extends RadioState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
final class RadioSuccess extends RadioState {
  List<RadioModel> radioList = [] ;
  RadioSuccess(this.radioList);

  @override
  // TODO: implement props
  List<Object?> get props => [radioList];
}
final class RadioFailure extends RadioState {
  String errorMessage ;
  RadioFailure({required this.errorMessage});

  @override
  // TODO: implement props
  List<Object?> get props => [errorMessage];
}
