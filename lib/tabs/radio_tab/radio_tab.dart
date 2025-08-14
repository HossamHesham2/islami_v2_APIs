import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islami_v2/core/assets_manager.dart';
import 'package:islami_v2/core/colors_manager.dart';
import 'package:islami_v2/core/controller/radio_cubit/radio_cubit.dart';
import 'package:islami_v2/core/controller/reciters_cubit/reciters_cubit.dart';
import 'package:islami_v2/models/radio_model.dart';

import '../../core/styles_manager.dart';

class RadioTab extends StatefulWidget {
  const RadioTab({super.key});

  @override
  State<RadioTab> createState() => _RadioTabState();
}

class _RadioTabState extends State<RadioTab> {
  RadioModel radioModel = RadioModel(
    id: 1,
    name: "Radio Name",
    url: "url",
    recent_date: "date",
  );
  int selectedIndex = 0;
  int? currentIndex;
  bool isPlaying = false;
  bool isMuted = false;

  @override
  void dispose() {
    playAudio.dispose();
    super.dispose();
  }

  final AudioPlayer playAudio = AudioPlayer();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: ColorsManager.black.withOpacity(0.6),
            ),
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      selectedIndex = 0;
                      setState(() {});
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 8.h),
                      decoration: BoxDecoration(
                        color: selectedIndex == 0
                            ? ColorsManager.gold
                            : ColorsManager.transParentColor,
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        "Radio",
                        style: selectedIndex == 0
                            ? StylesManager.bold16Black
                            : StylesManager.bold16White,
                      ),
                    ),
                  ),
                ),

                Expanded(
                  child: InkWell(
                    onTap: () {
                      selectedIndex = 1;
                      setState(() {});
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 8.h),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.r),
                        color: selectedIndex == 1
                            ? ColorsManager.gold
                            : ColorsManager.transParentColor,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        "Reciters",
                        style: selectedIndex == 1
                            ? StylesManager.bold16Black
                            : StylesManager.bold16White,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20.h),
          selectedIndex == 0
              ? Expanded(
            child: BlocProvider(
              create: (context) => RadioCubit()..getRadio(),
              child: BlocBuilder<RadioCubit, RadioState>(
                builder: (context, state) {
                  if (state is RadioLoading) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: ColorsManager.gold,
                      ),
                    );
                  } else if (state is RadioFailure) {
                    return Center(child: Text(state.errorMessage));
                  } else if (state is RadioSuccess) {
                    return ListView.separated(
                      itemBuilder: (context, index) {
                        return Container(
                          padding: EdgeInsets.symmetric(vertical: 13.h),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: ColorsManager.gold,
                            borderRadius: BorderRadius.circular(20.r),
                            image: DecorationImage(
                              image: AssetImage(
                                isPlaying && currentIndex == index
                                    ? AssetsManager.soundWave
                                    : AssetsManager.radioComponentBg,
                              ),
                              alignment: Alignment.bottomCenter,
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                state.radioList[index].name,
                                style: StylesManager.bold20Black,
                              ),
                              SizedBox(height: 30.h),
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.center,
                                children: [
                                  Row(
                                    children: [
                                      InkWell(
                                        onTap: () async {
                                          if (isPlaying &&
                                              currentIndex == index) {
                                            await playAudio.stop();
                                            setState(() {
                                              isPlaying = false;
                                            });
                                          } else {
                                            await playAudio
                                                .stop(); // نوقف أي صوت شغال حاليًا
                                            await playAudio.play(
                                              UrlSource(
                                                state
                                                    .radioList[index]
                                                    .url,
                                              ),
                                            );
                                            setState(() {
                                              isPlaying = true;
                                              currentIndex = index;
                                            });
                                          }
                                        },
                                        child: Icon(
                                          isPlaying &&
                                              currentIndex == index
                                              ? Icons.pause
                                              : Icons.play_arrow,
                                          size: 40.sp,
                                          color: ColorsManager.black,
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          if (isMuted) {
                                            playAudio.setVolume(1);
                                          } else {
                                            playAudio.setVolume(0);
                                          }
                                          setState(() {
                                            isMuted = !isMuted;
                                          });
                                        },
                                        child: Icon(
                                          isMuted && currentIndex == index
                                              ? Icons.volume_off
                                              : Icons.volume_up,
                                          size: 40.sp,
                                          color: ColorsManager.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (context, index) =>
                          SizedBox(height: 20.h),
                      itemCount: state.radioList.length,
                    );
                  } else {
                    return Container();
                  }
                },
              ),
            ),
          )
              : Expanded(
            child: BlocProvider(
              create: (context) => RecitersCubit()..getReciters(),
              child: BlocBuilder<RecitersCubit, RecitersState>(
                builder: (context, state) {
                  if (state is RecitersLoading) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: ColorsManager.gold,
                      ),
                    );
                  } else if (state is RecitersFailure) {
                    return Center(child: Text(state.errorMessage));
                  } else if (state is RecitersSuccess) {
                    return ListView.separated(
                      itemBuilder: (context, index) {
                        return Container(
                          padding: EdgeInsets.symmetric(vertical: 13.h),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: ColorsManager.gold,
                            borderRadius: BorderRadius.circular(20.r),
                            image: DecorationImage(
                              image: AssetImage(
                                  isPlaying && currentIndex == index
                                      ? AssetsManager.soundWave
                                      : AssetsManager.radioComponentBg
                              ),
                              alignment: Alignment.bottomCenter,
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                state.recitersList[index].name,
                                style: StylesManager.bold20Black,
                              ),
                              SizedBox(height: 30.h),
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.center,
                                children: [
                                  Row(
                                    children: [
                                      InkWell(
                                        onTap: () async {
                                          if (isPlaying &&
                                              currentIndex == index) {
                                            await playAudio.stop();
                                            setState(() {
                                              isPlaying = false;
                                            });
                                          } else {
                                            String baseUrl = state
                                                .recitersList[index]
                                                .moshaf[index]
                                                .server; // server6.mp3quran.net/akdr/
                                            String fullUrl =
                                                "${baseUrl}001.mp3";
                                            await playAudio.stop();
                                            await playAudio.play(
                                              UrlSource(fullUrl),
                                            );
                                            setState(() {
                                              isPlaying = true;
                                              currentIndex = index;
                                            });
                                          }
                                        },
                                        child: Icon(
                                          isPlaying && currentIndex == index ?Icons.pause:Icons.play_arrow,
                                          size: 40.sp,
                                          color: ColorsManager.black,
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          if (isMuted) {
                                            playAudio.setVolume(1);
                                          } else {
                                            playAudio.setVolume(0);
                                          }
                                          setState(() {
                                            isMuted = !isMuted;
                                          });
                                        },
                                        child: Icon(
                                          isMuted && currentIndex == index
                                              ? Icons.volume_off
                                              : Icons.volume_up,
                                          size:40.sp,
                                          color: ColorsManager.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (context, index) =>
                          SizedBox(height: 20.h),
                      itemCount: state.recitersList.length,
                    );
                  } else {
                    return Container();
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
