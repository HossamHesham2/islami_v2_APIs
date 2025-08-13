import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:islami_v2/models/reciters_model.dart';
import 'package:flutter/material.dart';

part 'reciters_state.dart';

class RecitersCubit extends Cubit<RecitersState> {
  RecitersCubit() : super(RecitersInitial());
  getReciters() async {
    try {
      emit(RecitersLoading());
      final Response response = await Dio().get(
        "https://www.mp3quran.net/api/v3/reciters?language=en",
      );
      final dynamic data = response.data;
      List<ReciterModel> recitersList = [];
      for (var reciters in data["reciters"]) {
        recitersList.add(ReciterModel.fromJson(reciters));
      }
      emit(RecitersSuccess(recitersList));
    } catch (e) {
      emit(RecitersFailure(errorMessage: e.toString()));
    }
  }
}
