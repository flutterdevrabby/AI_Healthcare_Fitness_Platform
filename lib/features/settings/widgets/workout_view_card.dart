import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gritti_app/constants/text_font_style.dart';

class WorkoutCardWidget extends StatelessWidget {
  final String workoutComplete;
  final String totalCalories;
  final String activaDays;
  const WorkoutCardWidget({
    super.key,
    required this.workoutComplete,
    required this.totalCalories,
    required this.activaDays,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),
      decoration: ShapeDecoration(
        color: const Color(0xFFFAFAFA),
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 1.w, color: const Color(0xFFE4E4E7)),
          borderRadius: BorderRadius.circular(16.r),
        ),
      ),

      child: Column(
        spacing: 10.h,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            spacing: 16.w,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Total Workouts Completed ",
                style: TextFontStyle.headLine16cFFFFFFWorkSansW600.copyWith(
                  color: const Color(0xFF27272A),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                workoutComplete,
                style: TextFontStyle.headLine16cFFFFFFWorkSansW600.copyWith(
                  color: const Color(0xFF27272A),
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),

          Row(
            spacing: 16.w,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Total Calories Burned ",
                style: TextFontStyle.headLine16cFFFFFFWorkSansW600.copyWith(
                  color: const Color(0xFF27272A),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                totalCalories,
                style: TextFontStyle.headLine16cFFFFFFWorkSansW600.copyWith(
                  color: const Color(0xFF27272A),
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),

          Row(
            spacing: 16.w,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Active Days",
                style: TextFontStyle.headLine16cFFFFFFWorkSansW600.copyWith(
                  color: const Color(0xFF27272A),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                activaDays,
                style: TextFontStyle.headLine16cFFFFFFWorkSansW600.copyWith(
                  color: const Color(0xFF27272A),
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
