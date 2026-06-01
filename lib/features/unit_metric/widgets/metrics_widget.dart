import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gritti_app/constants/text_font_style.dart';

class MetricsWidget extends StatelessWidget {
  final String weight;
  final String height;
  const MetricsWidget({super.key, required this.weight, required this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.sw,
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Color(0xFFE2E8E0)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Weight & Height Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Weight",
                style: TextFontStyle.headLine16cFFFFFFWorkSansW600.copyWith(
                  color: Color(0xFF64748B),
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text(
                weight,
                style: TextFontStyle.headLine16cFFFFFFWorkSansW600.copyWith(
                  color: Color(0xFF000000),
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Height",
                style: TextFontStyle.headLine16cFFFFFFWorkSansW600.copyWith(
                  color: Color(0xFF64748B),
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text(
                height,
                style: TextFontStyle.headLine16cFFFFFFWorkSansW600.copyWith(
                  color: Color(0xFF000000),
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
