import 'package:flutter/material.dart';
import 'package:islami_v2/core/assets_manager.dart';
import 'package:islami_v2/core/styles_manager.dart';

class SebhaTab extends StatefulWidget {
  const SebhaTab({super.key});

  @override
  State<SebhaTab> createState() => _SebhaTabState();
}

class _SebhaTabState extends State<SebhaTab> {
  double turns = 0;
  int currentIndex = 0;
  int currentCount = 0;

  final List<Map<String, dynamic>> tasbeehList = [
    {'text': 'سبحان الله', 'count': 33},
    {'text': 'الحمد لله', 'count': 33},
    {'text': 'الله أكبر', 'count': 34},
    {'text': 'لا إله إلا الله', 'count': 100},
    {'text': 'سبحان الله وبحمده', 'count': 100},
    {'text': 'سبحان الله العظيم', 'count': 100},
    {'text': 'لا حول ولا قوة إلا بالله', 'count': null},
    {'text': 'أستغفر الله', 'count': 100},
    {'text': 'لا إله إلا الله وحده لا شريك له، له الملك وله الحمد وهو على كل شيء قدير', 'count': 100},
  ];

  @override
  Widget build(BuildContext context) {
    final currentTasbeeh = tasbeehList[currentIndex];
    final maxCount = currentTasbeeh['count'];

    return Column(
      children: [
        const SizedBox(height: 40),
        Text("سَبِّحِ اسْمَ رَبِّكَ الأعلى ", style: StylesManager.bold36White),
        const SizedBox(height: 40),
        Image.asset(AssetsManager.sebhaHead),
        Stack(
          alignment: Alignment.center,
          children: [
            AnimatedRotation(
              duration: const Duration(milliseconds: 250),
              turns: turns,
              child: GestureDetector(
                onTap: () => setState(() {
                  turns += 0.1;
                  currentCount++;
                  if (maxCount != null && currentCount >= maxCount) {
                    currentIndex = (currentIndex + 1) % tasbeehList.length;
                    currentCount = 0;
                  }
                }),
                child: Image.asset(AssetsManager.sebhaBody),
              ),
            ),
            Column(
              children: [
                Text(currentTasbeeh['text'], style: StylesManager.bold36White),
                Text(currentCount.toString(), style: StylesManager.bold36White),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
