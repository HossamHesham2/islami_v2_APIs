import 'package:flutter/material.dart';
import 'package:islami_v2/core/assets_manager.dart';
import 'package:islami_v2/core/colors_manager.dart';
import 'package:islami_v2/core/routes_manager.dart';
import 'package:islami_v2/core/styles_manager.dart';
import 'package:islami_v2/models/on_board_screen_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  late int currentIndex = 0;
  final PageController controller = PageController();

  @override
  void initState() {
    super.initState();

    controller;
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<OnBoardScreenModel> boardList = [
      OnBoardScreenModel(
        image: AssetsManager.onBoard1,
        title: "Welcome To Islmi App",
        description: "",
      ),
      OnBoardScreenModel(
        image: AssetsManager.onBoard2,
        title: "Welcome To Islmi ",
        description: "We Are Very Excited To Have You In Our Community",
      ),
      OnBoardScreenModel(
        image: AssetsManager.onBoard3,
        title: "Reading the Quran ",
        description: "Read, and your Lord is the Most Generous",
      ),
      OnBoardScreenModel(
        image: AssetsManager.onBoard4,
        title: "Bearish ",
        description: "Praise the name of your Lord, the Most High",
      ),
      OnBoardScreenModel(
        image: AssetsManager.onBoard5,
        title: "Holy Quran Radio ",
        description:
            "You can listen to the Holy Quran Radio through the application for free and easily",
      ),
    ];
    return Scaffold(
      backgroundColor: ColorsManager.black,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,

        children: [
          SizedBox(height: 25),
          Image.asset(AssetsManager.islamiLogo),
          SizedBox(height: 25),
          Expanded(
            flex: 6,
            child: PageView.builder(
              onPageChanged: (index) => setState(() {
                currentIndex = index;
              }),
              controller: controller,
              itemCount: boardList.length,
              itemBuilder: (context, index) => _buildOnBoardScreen(
                boardList[index].image,
                boardList[index].title,
                boardList[index].description,
              ),
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: currentIndex > 0
                      ? () {
                          controller.previousPage(
                            duration: Duration(milliseconds: 300),
                            curve: Curves.ease,
                          );
                        }
                      : null,
                  child: currentIndex > 0
                      ? Text("Back", style: StylesManager.bold16Gold)
                      : Text(""),
                ),
                Row(
                  children: [
                    CustomIndicator(active: currentIndex == 0),
                    SizedBox(width: 10),
                    CustomIndicator(active: currentIndex == 1),
                    SizedBox(width: 10),
                    CustomIndicator(active: currentIndex == 2),
                    SizedBox(width: 10),
                    CustomIndicator(active: currentIndex == 3),
                    SizedBox(width: 10),
                    CustomIndicator(active: currentIndex == 4),
                  ],
                ),

                TextButton(
                  onPressed: () async {
                    if (currentIndex < boardList.length - 1) {
                      controller.nextPage(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.ease,
                      );
                    } else {
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      prefs.setBool('isOnBoardingSeen', true);
                      Navigator.pushReplacementNamed(
                        context,
                        RoutesManager.homeScreen,
                      );
                    }
                  },
                  child: Text(
                    currentIndex < boardList.length - 1 ? "Next" : "Finish",
                    style: StylesManager.bold16Gold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOnBoardScreen(String image, String title, String description) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Image.asset(image),
          SizedBox(height: 25),

          Text(
            title,
            style: StylesManager.bold24Gold,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 25),

          Text(
            description,
            style: StylesManager.bold20Gold.copyWith(height: 1.8),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class CustomIndicator extends StatelessWidget {
  final bool active;

  const CustomIndicator({super.key, required this.active});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      decoration: BoxDecoration(
        color: active ? ColorsManager.gold : ColorsManager.gray,
        borderRadius: BorderRadius.circular(50),
      ),
      width: active ? 18 : 7,
      height: 7,
      duration: Duration(milliseconds: 300),
    );
  }
}
