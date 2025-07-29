import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'pray_time_state.dart';

class PrayTimeCubit extends Cubit<PrayTimeState> {
  PrayTimeCubit() : super(PrayTimeInitial());
}
