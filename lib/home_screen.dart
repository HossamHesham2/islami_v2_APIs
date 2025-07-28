import 'package:flutter/material.dart';
import 'package:islami_v2/core/assets_manager.dart';
import 'package:islami_v2/core/colors_manager.dart';
import 'package:islami_v2/tabs/hadith_tab/hadith_tab.dart';
import 'package:islami_v2/tabs/quran_tab/quran_tab.dart';
import 'package:islami_v2/tabs/radio_tab/radio_tab.dart';
import 'package:islami_v2/tabs/sebha_tab/sebha_tab.dart';
import 'package:islami_v2/tabs/time_tab/time_tab.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;
  List<String> backgroundImageList = [
    AssetsManager.quranBg,
    AssetsManager.hadithBg,
    AssetsManager.sebhaBg,
    AssetsManager.radioBg,
    AssetsManager.timeBg,
  ];
  List<Widget> tabs = [
    QuranTab(),
    HadithTab(),
    SebhaTab(),
    RadioTab(),
    TimeTab(),
  ];
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          backgroundImageList[selectedIndex],
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.fill,
        ),
        Scaffold(
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: selectedIndex,
            onTap: (index) {
              setState(() {
                selectedIndex = index;
              });
            },

            items: [
              BottomNavigationBarItem(
                icon: _buildBottomNavigationBarItem(
                  index: 0,
                  iconPath: AssetsManager.quranIc,
                ),

                label: "Quran",
              ),
              BottomNavigationBarItem(
                icon: _buildBottomNavigationBarItem(
                  index: 1,
                  iconPath: AssetsManager.hadithIc,
                ),
                label: "Hadith",
              ),
              BottomNavigationBarItem(
                icon: _buildBottomNavigationBarItem(
                  index: 2,
                  iconPath: AssetsManager.sebhaIc,
                ),
                label: "Sebha",
              ),
              BottomNavigationBarItem(
                icon: _buildBottomNavigationBarItem(
                  index: 3,
                  iconPath: AssetsManager.radioIc,
                ),
                label: "Radio",
              ),
              BottomNavigationBarItem(
                icon: _buildBottomNavigationBarItem(
                  index: 4,
                  iconPath: AssetsManager.timeIc,
                ),
                label: "Time",
              ),
            ],
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset(AssetsManager.islamiLogo),
              Expanded(child: tabs[selectedIndex]),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBottomNavigationBarItem({
    required int index,
    required String iconPath,
  }) {
    return selectedIndex == index
        ? Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(66),
              color: ColorsManager.black.withOpacity(0.6),
            ),
            child: ImageIcon(AssetImage(iconPath)),
          )
        : ImageIcon(AssetImage(iconPath));
  }
}
