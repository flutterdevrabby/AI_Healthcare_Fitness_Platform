import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants/text_font_style.dart';

class PrivacyCardWidget extends StatelessWidget {
  final Map<String, dynamic> data;
  final VoidCallback onTap;
  const PrivacyCardWidget({super.key, required this.data, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),

        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),

          border: BoxBorder.all(color: Color(0xFFE2E8F0)),
        ),
        margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),

        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 10.h,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(data["title"], style: TextFontStyle.headLine16c0F172AnterW600),

            Text(
              data["subtitle"],
              style: TextFontStyle.headLine16c0F172AnterW600.copyWith(
                fontSize: 14.sp,
                fontWeight: FontWeight.w200,
              ),
            ),

            Text(
              data["content"],
              style: TextFontStyle.headLine16c0F172AnterW600.copyWith(
                fontSize: 12.sp,
                fontWeight: FontWeight.w200,
                color: Color(0xFF64748B),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
