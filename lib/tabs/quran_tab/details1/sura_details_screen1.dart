import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:islami_v2/core/assets_manager.dart';
import 'package:islami_v2/core/colors_manager.dart';
import 'package:islami_v2/core/styles_manager.dart';
import 'package:islami_v2/models/sura_model.dart';

class SuraDetailsScreen1 extends StatefulWidget {
  const SuraDetailsScreen1({super.key});

  @override
  State<SuraDetailsScreen1> createState() => _SuraDetailsScreen1State();
}

class _SuraDetailsScreen1State extends State<SuraDetailsScreen1> {
  String suraContent = "";
  late int index;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    index = ModalRoute.of(context)?.settings.arguments as int;
    super.didChangeDependencies();
    loadSuraContent(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.black,

      appBar: AppBar(
        title: Text(
          SuraModel.allSurahs[index - 1].suraNameEn,
          style: StylesManager.bold20Gold,
        ),
      ),
      body: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(AssetsManager.cornerLeft),
                  Image.asset(AssetsManager.cornerRight),
                ],
              ),
              Text(
                SuraModel.allSurahs[index - 1].suraNameAr,
                style: StylesManager.bold24Gold,
              ),
            ],
          ),
          Expanded(
            child: suraContent.isEmpty
                ? Center(
                    child: CircularProgressIndicator(color: ColorsManager.gold),
                  )
                : SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        suraContent,
                        style: StylesManager.bold20Gold,
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.ltr,
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  loadSuraContent(int index) async {
    String filePath = "assets/files/suras/$index.txt";
    String fileContent = await rootBundle.loadString(filePath);
    List<String> suraLines = fileContent.trim().split('\n');

    for (int i = 0; i < suraLines.length; i++) {
      suraLines[i] += "[${i + 1}]";
    }
    suraContent = suraLines.join('\n');
    Future.delayed(const Duration(seconds: 1), () => setState(() {}));
  }
}
