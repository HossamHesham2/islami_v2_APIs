import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:islami_v2/models/pray_response.dart';
import 'package:meta/meta.dart';

part 'pray_time_state.dart';

class PrayTimeCubit extends Cubit<PrayTimeState> {
  PrayTimeCubit() : super(PrayTimeInitial());
  Dio dio = Dio();

  Future<PrayResponse> getPrayTime(String date) async {
    emit(PrayTimeLoading());
    try {
      final response = await dio.get(
        "https://api.aladhan.com/v1/timingsByCity/$date?",
        queryParameters: {"city": "cairo", "country": "egypt"},
      );
      PrayResponse prayResponse = PrayResponse.fromJson(response.data);

      emit(PrayTimeSuccess(prayResponse: prayResponse));
      return prayResponse;
    } catch (e) {
      emit(PrayTimeFailure(errorMessage: e.toString()));
      rethrow;
    }
  }
}
