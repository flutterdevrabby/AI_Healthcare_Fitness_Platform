import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../common_widget/latest_appbar_widget.dart';
import '../../helpers/navigation_service.dart';
import 'plan_widget.dart';

class SubscriptionScreen extends StatelessWidget {
  const SubscriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWidget(
        titleText: "Subscription",
        onPressed: () {
          NavigationService.goBack;
        },
      ),

      body: ListView.builder(
        itemCount: 2,
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        itemBuilder: (_, index) {
          return Container(
            padding: EdgeInsets.all(16.sp),
            margin: EdgeInsets.only(bottom: 10.h),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFFE5EAF3)),
            ),
            child: PlanWidget(),
          );
        },
      ),
    );
  }
}
