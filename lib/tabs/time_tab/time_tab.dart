import 'package:flutter/material.dart';
import 'package:islami_v2/core/assets_manager.dart';
import 'package:islami_v2/core/colors_manager.dart';
import 'package:islami_v2/core/styles_manager.dart';
import 'package:islami_v2/models/pray_response.dart';
import 'package:islami_v2/tabs/time_tab/pray_item_widget.dart';

class TimeTab extends StatelessWidget {
  TimeTab({super.key});

  final PrayResponse prayResponse = PrayResponse();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PrayItemWidget(),
          const SizedBox(height: 15),
          Text("Azkar", style: StylesManager.bold16White),
          const SizedBox(height: 15),
          _buildAzkarRow([
            _AzkarCard(
              title: "Evening Azkar",
              imagePath: AssetsManager.azkar2,
            ),
            _AzkarCard(
              title: "Morning Azkar",
              imagePath: AssetsManager.azkar1,
            ),
          ]),
          const SizedBox(height: 15),
          _buildAzkarRow([
            _AzkarCard(
              title: "Waking Azkar",
              imagePath: AssetsManager.azkar3,
            ),
            _AzkarCard(
              title: "Sleeping Azkar",
              imagePath: AssetsManager.azkar4,
            ),
          ]),
        ],
      ),
    );
  }

  Widget _buildAzkarRow(List<Widget> children) {
    return Row(
      children: [
        Expanded(child: children[0]),
        const SizedBox(width: 20),
        Expanded(child: children[1]),
      ],
    );
  }
}

class _AzkarCard extends StatelessWidget {
  final String title;
  final String imagePath;

  const _AzkarCard({
    required this.title,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 260,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: ColorsManager.black,
        border: Border.all(color: ColorsManager.gold),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Expanded(
            child: Image.asset(imagePath, fit: BoxFit.fill),
          ),
          const SizedBox(height: 15),
          Text(
            title,
            style: StylesManager.bold16White.copyWith(fontSize: 20),
          ),
        ],
      ),
    );
  }
}
