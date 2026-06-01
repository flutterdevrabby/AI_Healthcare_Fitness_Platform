import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gritti_app/common_widget/custom_button.dart';
import 'package:gritti_app/constants/text_font_style.dart';
import 'package:gritti_app/helpers/all_routes.dart';
import 'package:gritti_app/helpers/loading_helper.dart';
import 'package:gritti_app/helpers/navigation_service.dart';
import 'package:gritti_app/helpers/toast.dart';
import 'package:gritti_app/networks/dio/dio.dart';
import 'package:gritti_app/networks/stream_cleaner.dart';

import '../../common_widget/latest_appbar_widget.dart';
import '../../networks/api_acess.dart';

class SignoutScreen extends StatelessWidget {
  const SignoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWidget(
        titleText: "Signout Account",
        onPressed: () {},
        isButton: false,
      ),

      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),

        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),

          border: BoxBorder.all(color: Color(0xFFE2E8F0)),
        ),
        margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),

        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 10.h,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Sign Out", style: TextFontStyle.headLine16c0F172AnterW600),

            Text(
              "End Current Session",
              style: TextFontStyle.headLine16c0F172AnterW600.copyWith(
                fontSize: 14.sp,
                fontWeight: FontWeight.w200,
              ),
            ),

            Text(
              "You will be signed out of your account and redirected to the login page. Any unsaved changes will be lost.",
              style: TextFontStyle.headLine16c0F172AnterW600.copyWith(
                fontSize: 14.sp,
                fontWeight: FontWeight.w200,
                color: Color(0xFF64748B),
              ),
            ),

            CustomButton(
              color: Color(0xFFEF4444),

              onPressed: () {
                signoutRxObj.signoutRx().waitingForFuture().then((success) {
                  if (success) {
                    DioSingleton.instance.update('');
                    totalDataClean();
                    ToastUtil.showShortToast("Signout Successfully");
                    NavigationService.navigateToReplacement(
                      Routes.signInScreen,
                    );
                  }
                });
              },
              text: "Sign Out",
            ),
          ],
        ),
      ),
    );
  }
}
