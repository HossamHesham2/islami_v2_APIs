import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islami_v2/core/assets_manager.dart';
import 'package:islami_v2/core/colors_manager.dart';
import 'package:islami_v2/core/routes_manager.dart';
import 'package:islami_v2/core/styles_manager.dart';
import 'package:islami_v2/models/sura_model.dart';
import 'package:islami_v2/providers/most_recent_provider.dart';
import 'package:islami_v2/tabs/quran_tab/most_recent_widget.dart';
import 'package:provider/provider.dart';

class QuranTab extends StatefulWidget {
  const QuranTab({super.key});

  @override
  State<QuranTab> createState() => _QuranTabState();
}

class _QuranTabState extends State<QuranTab> {
  List<String> filteredItems = [];
  String searchQuery = '';

  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    var filteredSurahs = SuraModel.allSurahs.where((sura) {
      return sura.suraNameEn.toLowerCase().contains(
            searchQuery.toLowerCase(),
          ) ||
          sura.suraNameAr.toLowerCase().contains(searchQuery.toLowerCase()) ||
          sura.suraNum.toString() == searchQuery;
    }).toList();
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _searchController,
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
              cursorColor: ColorsManager.gold,
              style: TextStyle(
                color: ColorsManager.gold,
                fontWeight: FontWeight.w600,
              ),
              decoration: InputDecoration(
                prefixIcon: Image.asset(AssetsManager.searchIc),
                hintText: "Sura Name",
                hintStyle: StylesManager.bold16White,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16.r),
                  borderSide: BorderSide(color: ColorsManager.gold, width: 2.w),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16.r),
                  borderSide: BorderSide(color: ColorsManager.gold, width: 2.w),
                ),
              ),
            ),
            SizedBox(height: 20.h),
            MostRecentWidget(),
            SizedBox(height:20.h),
            Text("Sura List", style: StylesManager.bold16White),
            ListView.separated(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final sura = filteredSurahs[index];

                return InkWell(
                  onTap: () async {
                    Provider.of<MostRecentProvider>(
                      context,
                      listen: false,
                    ).addSura(sura.suraNum);
                    await Navigator.pushNamed(
                      context,
                      RoutesManager.suraDetails,
                      arguments: sura.suraNum,
                    );
                  },

                  child: Row(
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Image.asset(AssetsManager.numberBg),
                          Text(
                            "${sura.suraNum}",
                            style: StylesManager.bold20White,
                          ),
                        ],
                      ),
                      SizedBox(width: 10.w),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            sura.suraNameEn,
                            style: StylesManager.bold20White,
                          ),
                          Text(
                            "${sura.versesNum} Verses",
                            style: StylesManager.bold14White,
                          ),
                        ],
                      ),
                      Spacer(),
                      Text(sura.suraNameAr, style: StylesManager.bold20White),
                    ],
                  ),
                );
              },
              separatorBuilder: (context, index) => Divider(
                indent:  15.w,
                endIndent:  15.w,
                color: ColorsManager.white,
                thickness: 2.h,
              ),
              itemCount: filteredSurahs.length,
            ),
          ],
        ),
      ),
    );
  }
}
