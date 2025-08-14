import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islami_v2/core/assets_manager.dart';
import 'package:islami_v2/core/colors_manager.dart';
import 'package:islami_v2/core/shared_prefs.dart';
import 'package:islami_v2/core/styles_manager.dart';
import 'package:islami_v2/models/sura_model.dart';
import 'package:islami_v2/providers/most_recent_provider.dart';
import 'package:provider/provider.dart';

class MostRecentWidget extends StatefulWidget {
  const MostRecentWidget({super.key});

  @override
  State<MostRecentWidget> createState() => _MostRecentWidgetState();
}

class _MostRecentWidgetState extends State<MostRecentWidget> {
  List<int> mostRecentList = [];
  @override
  void initState() {
    super.initState();
    getMostRecentSuraList();
  }

  void getMostRecentSuraList() async {
    mostRecentList = await readLastSuraList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {

    var mostRecentProvider = Provider.of<MostRecentProvider>(context);
    final mostRecentList = mostRecentProvider.mostRecentList;
    return Visibility(
      visible: mostRecentList.isNotEmpty,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Most Recently", style: StylesManager.bold16White),
          SizedBox(height: 20.h),
          SizedBox(
            height: 150.h,
            width: double.infinity,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              separatorBuilder: (context, index) => SizedBox(width: 10.w),
              itemBuilder: (context, index) {
                final sura = SuraModel.allSurahs.firstWhere(
                  (sura) => sura.suraNum == mostRecentList[index],
                );

                return Container(
                  padding: EdgeInsets.symmetric(horizontal: 9.w, vertical: 7.h),
                  width: 300.w,
                  decoration: BoxDecoration(
                    color: ColorsManager.gold,
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              sura.suraNameEn,
                              style: StylesManager.bold24Black,
                            ),
                            Text(
                              sura.suraNameAr,
                              style: StylesManager.bold24Black,
                            ),
                            SizedBox(height: 20.h),
                            Text(
                              "${sura.versesNum} Verses",
                              style: StylesManager.bold14Black,
                            ),
                          ],
                        ),
                      ),
                      Expanded(child: Image.asset(AssetsManager.recentBg)),
                    ],
                  ),
                );
              },
              itemCount: mostRecentList.length,
            ),
          ),
        ],
      ),
    );
  }
}
