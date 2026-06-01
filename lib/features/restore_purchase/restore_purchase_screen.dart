import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gritti_app/common_widget/custom_button.dart';
import 'package:gritti_app/common_widget/latest_appbar_widget.dart';
import 'package:gritti_app/gen/assets.gen.dart';
import 'package:gritti_app/helpers/ui_helpers.dart';

class RestorePurchaseScreen extends StatelessWidget {
  const RestorePurchaseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWidget(
        onPressed: () {},
        titleText: "Restore Purchases",
      ),

      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          children: [
            Image.asset(Assets.images.res.path, width: 1.sw, fit: BoxFit.cover),

            UIHelper.verticalSpace(30.h),

            CustomButton(onPressed: () {}, text: "Restore Purchases"),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 48.w),
              child: Image.asset(
                Assets.images.tribleShort.path,
                width: 1.sw,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
