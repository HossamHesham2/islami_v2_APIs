import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:islami_v2/core/assets_manager.dart';
import 'package:islami_v2/core/colors_manager.dart';
import 'package:islami_v2/core/controller/pray_cubit/pray_time_cubit.dart';
import 'package:islami_v2/core/styles_manager.dart';
import 'package:islami_v2/models/pray_response.dart';

class PrayItemWidget extends StatefulWidget {
  const PrayItemWidget({super.key});

  @override
  State<PrayItemWidget> createState() => _PrayItemWidgetState();
}

class _PrayItemWidgetState extends State<PrayItemWidget> {
  PrayResponse prayResponse = PrayResponse();

  String convertHijri(String hijriDate) {
    List<String> months = [
      "Muh",
      "Saf",
      "Rab-I",
      "Rab-II",
      "Jum-I",
      "Jum-II",
      "Raj",
      "Sha",
      "Ram",
      "Shaw",
      "Dhu-Q",
      "Dhu-H",
    ];

    if (hijriDate.isEmpty || !hijriDate.contains('-')) return hijriDate;

    var parts = hijriDate.split('-');
    if (parts.length < 3) return hijriDate;

    int day = int.tryParse(parts[0]) ?? 0;
    int monthIndex = (int.tryParse(parts[1]) ?? 1) - 1;
    String year = parts[2];

    if (monthIndex < 0 || monthIndex >= months.length) monthIndex = 0;

    String newDay = day.toString().padLeft(2, '0');
    String monthName = months[monthIndex];

    return "$newDay $monthName, $year";
  }

  String _getNextPrayerTime(List<Map<String, dynamic>> prayers) {
    final now = DateTime.now();

    for (var prayer in prayers) {
      if (prayer['prayTime'] == null) continue;

      DateTime prayerTime = DateFormat("HH:mm").parse(prayer['prayTime']);
      prayerTime = DateTime(
        now.year,
        now.month,
        now.day,
        prayerTime.hour,
        prayerTime.minute,
      );

      if (prayerTime.isAfter(now)) {
        final diff = prayerTime.difference(now);
        final hours = diff.inHours;
        final minutes = diff.inMinutes % 60;
        return "${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}";
      }
    }

    final fajr = prayers.firstWhere(
      (p) => p['prayName'] == "Fajr",
      orElse: () => {},
    );
    if (fajr.isNotEmpty && fajr['prayTime'] != null) {
      DateTime fajrTime = DateFormat("HH:mm").parse(fajr['prayTime']);
      fajrTime = DateTime(
        now.year,
        now.month,
        now.day + 1,
        fajrTime.hour,
        fajrTime.minute,
      );
      final diff = fajrTime.difference(now);
      final hours = diff.inHours;
      final minutes = diff.inMinutes % 60;
      return "Fajr in ${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}";
    }

    return "";
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String currentDate = DateFormat('dd-MM-yyyy').format(now);
    String currentDateFormatted = DateFormat('dd MMM, yyyy').format(now);

    return BlocProvider(
      create: (context) => PrayTimeCubit()..getPrayTime(currentDate),
      child: BlocBuilder<PrayTimeCubit, PrayTimeState>(
        builder: (context, state) {
          if (state is PrayTimeLoading) {
            return Center(
              child: CircularProgressIndicator(color: ColorsManager.gold),
            );
          }

          if (state is PrayTimeFailure) {
            return Center(
              child: Text(state.errorMessage, style: StylesManager.bold16Gold),
            );
          }

          if (state is PrayTimeSuccess) {
            prayResponse = state.prayResponse;
          }

          String hijriDate = "";
          if (state is PrayTimeSuccess) {
            hijriDate = convertHijri(
              state.prayResponse.data?.date!.hijri!.date ?? "",
            );
          }

          List<Map<String, dynamic>> prayers = [
            {
              "prayName": "Fajr",
              "prayTime": prayResponse.data?.timings!.fajr,
              "prayWhen": "AM",
            },
            {
              "prayName": "Sunrise",
              "prayTime": prayResponse.data?.timings!.sunrise,
              "prayWhen": "AM",
            },
            {
              "prayName": "Dhuhr",
              "prayTime": prayResponse.data?.timings!.dhuhr,
              "prayWhen": "PM",
            },
            {
              "prayName": "Asr",
              "prayTime": prayResponse.data?.timings!.asr,
              "prayWhen": "PM",
            },
            {
              "prayName": "Maghrib",
              "prayTime": prayResponse.data?.timings!.maghrib,
              "prayWhen": "PM",
            },
            {
              "prayName": "Isha",
              "prayTime": prayResponse.data?.timings!.isha,
              "prayWhen": "PM",
            },
          ];

          return Container(
            width: double.infinity,
            height: 300,
            decoration: BoxDecoration(
              color: ColorsManager.brown85,
              borderRadius: BorderRadius.circular(40),
              image: DecorationImage(
                image: AssetImage(AssetsManager.prayTimeBg),
                fit: BoxFit.fill,
              ),
            ),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(width: 20),
                    Expanded(
                      child: Text(
                        currentDateFormatted,
                        style: StylesManager.bold16White.copyWith(fontSize: 20),
                        softWrap: true,
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Column(
                        children: [
                          SizedBox(height: 10),
                          Text(
                            "Pray Time",
                            style: StylesManager.bold16Black.copyWith(
                              color: ColorsManager.black.withOpacity(0.71),
                              fontSize: 20,
                            ),
                            softWrap: true,
                          ),
                          SizedBox(height: 10),
                          Text(
                            prayResponse.data?.date!.hijri!.weekday!.en ?? "",
                            style: StylesManager.bold16Black.copyWith(
                              color: ColorsManager.black.withOpacity(0.9),
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Text(
                        convertHijri(
                          prayResponse.data?.date!.hijri!.date ?? "Null",
                        ),
                        style: StylesManager.bold16White.copyWith(fontSize: 20),
                        softWrap: true,
                      ),
                    ),
                    SizedBox(width: 20),
                  ],
                ),
                SizedBox(height: 20),
                Expanded(
                  child: ListView.separated(
                    separatorBuilder: (context, index) => SizedBox(width: 10),
                    scrollDirection: Axis.horizontal,
                    itemCount: prayers.length,
                    itemBuilder: (context, index) {
                      DateTime dateTime = DateFormat(
                        "HH:mm",
                      ).parse(prayers[index]['prayTime']);
                      String time12 = DateFormat("hh:mm a").format(dateTime);
                      return Container(
                        height: 130,
                        width: 105,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              ColorsManager.black,
                              Color(0xFFB19768), // Gold
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              prayers[index]['prayName'],
                              style: StylesManager.bold16White.copyWith(
                                fontSize: 20,
                              ),
                            ),
                            Text(
                              textAlign: TextAlign.center,
                              time12,
                              style: StylesManager.bold16White.copyWith(
                                fontSize: 25,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "Next Pray - ",
                            style: StylesManager.bold16Black.copyWith(
                              color: ColorsManager.black.withOpacity(0.5),
                              fontSize: 20,
                            ),
                          ),
                          TextSpan(
                            text: _getNextPrayerTime(prayers),
                            style: StylesManager.bold16Black.copyWith(
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.volume_mute, size: 30),
                    ),
                  ],
                ),
                SizedBox(height: 15),
              ],
            ),
          );
        },
      ),
    );
  }
}
