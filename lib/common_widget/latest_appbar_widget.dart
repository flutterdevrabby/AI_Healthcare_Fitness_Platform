import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gritti_app/common_widget/custom_button.dart';

import '../constants/text_font_style.dart';
import '../gen/assets.gen.dart';
import '../gen/colors.gen.dart';
import '../helpers/navigation_service.dart';

class CustomAppBarWidget extends StatelessWidget
    implements PreferredSizeWidget {
  final String? titleText;
  final VoidCallback onPressed;
  final bool isButton;

  const CustomAppBarWidget({
    super.key,
    this.titleText,
    required this.onPressed,
    this.isButton = true,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: AppColors.cFFFFFF,
      centerTitle: true,

      // LEFT ICON
      leading: InkWell(
        onTap: () {
          NavigationService.goBack;
        },
        child: Padding(
          padding: EdgeInsets.all(12.w),
          child: SvgPicture.asset(Assets.icons.icon, fit: BoxFit.contain),
        ),
      ),

      // CENTER TITLE
      title: Text(
        titleText ?? 'No title here',
        style: TextFontStyle.headLine18c051F42PoppinsW600,
      ),

      // RIGHT BUTTON
      actions: [
        if (isButton)
          Padding(
            padding: EdgeInsets.only(right: 12.w),
            child: CustomButton(
              onPressed: onPressed,
              minWidth: 0,
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 0.h),
              borderRadius: 10.r,
              borderSide: BorderSide.none,
              style: TextFontStyle.headLine16cFFFFFFWorkSansW600.copyWith(
                fontSize: 14.sp,
                color: Colors.white,
              ),
              text: "Save",
            ),
          ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(56.h);
}
