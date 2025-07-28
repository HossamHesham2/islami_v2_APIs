import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/services.dart';
import 'package:islami_v2/core/assets_manager.dart';
import 'package:islami_v2/core/colors_manager.dart';
import 'package:islami_v2/models/hadith_model.dart';
import '../../core/styles_manager.dart';

class HadithTab extends StatefulWidget {
  const HadithTab({super.key});

  @override
  State<HadithTab> createState() => _HadithTabState();
}

class _HadithTabState extends State<HadithTab> {
  List<HadithModel> hadithList = [];

  @override
  void initState() {
    super.initState();
    _loadAllAhadith();
  }

  @override
  Widget build(BuildContext context) {
    return hadithList.isEmpty
        ? Center(child: CircularProgressIndicator())
        : CarouselSlider(
            options: CarouselOptions(
              height: MediaQuery.sizeOf(context).height * 0.66,
              enlargeCenterPage: true,
            ),
            items: hadithList.map((hadith) {
              return Container(
                margin: EdgeInsets.symmetric(vertical: 20),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(AssetsManager.hadithCardBackGround),
                  ),
                  color: ColorsManager.gold,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Image.asset(
                                AssetsManager.cornerLeft,
                                color: ColorsManager.black,
                              ),
                              Image.asset(
                                AssetsManager.cornerRight,
                                color: ColorsManager.black,
                              ),
                            ],
                          ),
                        ),
                        Text(hadith.title, style: StylesManager.bold24Black),
                      ],
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.all(16),
                        child: Text(
                          hadith.content,
                          style: StylesManager.bold24Black,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Image.asset(
                      AssetsManager.mosque2,
                      width: double.infinity,
                      fit: BoxFit.fill,
                    ),
                  ],
                ),
              );
            }).toList(),
          );
  }

  void _loadAllAhadith() async {
    List<HadithModel> tempList = [];
    for (int i = 0; i < 50; i++) {
      String filePath = "assets/files/hadith/h${i + 1}.txt";
      String fileContent = await rootBundle.loadString(filePath);
      List<String> lines = fileContent.trim().split("\n");
      String title = lines[0];
      lines.removeAt(0);
      String content = lines.join("\n");
      tempList.add(HadithModel(title: title, content: content));
    }
    setState(() {
      hadithList = tempList;
    });
  }
}
