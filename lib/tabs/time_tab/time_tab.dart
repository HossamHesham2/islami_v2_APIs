import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
          SizedBox(height: 15.h),
          Text("Azkar", style: StylesManager.bold16White),
          SizedBox(height: 15.h),
          _buildAzkarRow([
            _AzkarCard(
              title: "Evening Azkar",
              imagePath: AssetsManager.azkar2,
              onTap: () {
                print("Evening Azkar");
              },
            ),
            _AzkarCard(
              title: "Morning Azkar",
              imagePath: AssetsManager.azkar1,
              onTap: () {
                print("Morning Azkar");
              },
            ),
          ]),
          SizedBox(height: 15.h),
          _buildAzkarRow([
            _AzkarCard(
              title: "Waking Azkar",
              imagePath: AssetsManager.azkar3,
              onTap: () {
                print("Waking Azkar");
              },
            ),
            _AzkarCard(
              onTap: () {
                print("Sleeping Azkar");
              },
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
        SizedBox(width: 20.w),
        Expanded(child: children[1]),
      ],
    );
  }
}

class _AzkarCard extends StatelessWidget {
  final String title;
  final String imagePath;
  final void Function()? onTap;

  const _AzkarCard({
    required this.title,
    required this.imagePath,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 260.h,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: ColorsManager.black,
          border: Border.all(color: ColorsManager.gold),
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Column(
          children: [
            Expanded(child: Image.asset(imagePath, fit: BoxFit.fill)),
            SizedBox(height: 15.h),
            Text(
              title,
              style: StylesManager.bold16White.copyWith(fontSize: 20.sp),
            ),
          ],
        ),
      ),
    );
  }
}
