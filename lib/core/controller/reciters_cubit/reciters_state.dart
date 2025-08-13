part of 'reciters_cubit.dart';

@immutable
sealed class RecitersState extends Equatable  {}

final class RecitersInitial extends RecitersState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
final class RecitersLoading extends RecitersState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
final class RecitersSuccess extends RecitersState {
  List<ReciterModel> recitersList = [];
  RecitersSuccess(this.recitersList);

  @override
  // TODO: implement props
  List<Object?> get props => [recitersList];
}
final class RecitersFailure extends RecitersState {
  String errorMessage;
  RecitersFailure({required this.errorMessage});

  @override
  // TODO: implement props
  List<Object?> get props => [errorMessage];
}
