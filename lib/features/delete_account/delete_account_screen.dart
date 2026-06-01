import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gritti_app/common_widget/custom_button.dart';
import 'package:gritti_app/constants/app_constants.dart';
import 'package:gritti_app/constants/text_font_style.dart';
import 'package:gritti_app/helpers/all_routes.dart';
import 'package:gritti_app/helpers/di.dart';
import 'package:gritti_app/helpers/loading_helper.dart';
import 'package:gritti_app/helpers/navigation_service.dart';
import 'package:gritti_app/helpers/toast.dart';

import '../../common_widget/latest_appbar_widget.dart';
import '../../networks/api_acess.dart';

class DeleteAccountScreen extends StatelessWidget {
  const DeleteAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWidget(
        titleText: "Delete Account",
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
            Text("Danger Zone", style: TextFontStyle.headLine16c0F172AnterW600),

            Text(
              "Danger Account",
              style: TextFontStyle.headLine16c0F172AnterW600.copyWith(
                fontSize: 14.sp,
                fontWeight: FontWeight.w200,
              ),
            ),

            Text(
              "Permanently delete your account and all associated data. This action cannot be undone.",
              style: TextFontStyle.headLine16c0F172AnterW600.copyWith(
                fontSize: 14.sp,
                fontWeight: FontWeight.w200,
                color: Color(0xFF64748B),
              ),
            ),

            CustomButton(
              color: Color(0xFFEF4444),

              onPressed: () {
                deleteAccoutRxObj.deleteAccoutRx().waitingForFuture().then((
                  success,
                ) {
                  if (success) {
                    appData.write(kKeyAccessToken, '');
                    appData.write(kKeyIsLoggedIn, false);

                    ToastUtil.showLongToast(
                      "You have deleted your account permanently",
                    );

                    NavigationService.navigateToReplacement(
                      Routes.signUpScreen,
                    );
                  }
                });
              },
              text: "Delete My Account",
            ),
          ],
        ),
      ),
    );
  }
}
