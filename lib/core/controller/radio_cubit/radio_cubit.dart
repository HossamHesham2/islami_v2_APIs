import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:islami_v2/models/radio_model.dart';

part 'radio_state.dart';

class RadioCubit extends Cubit<RadioState> {
  RadioCubit() : super(RadioInitial());

  getRadio() async {
    try {
      emit(RadioLoading());
      final Response response = await Dio().get(
        "https://mp3quran.net/api/v3/radios?language=en",
      );
      final dynamic data = response.data ;
      List<RadioModel> radioList = [];
      for (var radio in data["radios"]) {
        radioList.add(RadioModel.fromJson(radio));
      }
      emit(RadioSuccess(radioList));
    }  catch (e) {
      emit(RadioFailure(errorMessage : e.toString()));
    }
  }
}
