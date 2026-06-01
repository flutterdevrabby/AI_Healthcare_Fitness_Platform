import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gritti_app/common_widget/custom_network_image.dart';
import 'package:gritti_app/common_widget/waiting_widget.dart';
import 'package:gritti_app/constants/text_font_style.dart';
import 'package:gritti_app/gen/assets.gen.dart';
import 'package:gritti_app/helpers/all_routes.dart';
import 'package:gritti_app/helpers/navigation_service.dart';
import 'package:gritti_app/helpers/ui_helpers.dart';

import '../../../networks/api_acess.dart';
import '../data/rx_get_profile_info/model/user_info_response.dart';
import '../widgets/settings_title_widget.dart';
import '../widgets/user_info_widget.dart';
import '../widgets/workout_view_card.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  void initState() {
    super.initState();
    userInfoRxObj.userInfoRx();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        // padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: StreamBuilder<UserInfoResponse>(
          stream: userInfoRxObj.userInfoRxStream,
          builder: (context, asyncSnapshot) {
            if (asyncSnapshot.connectionState == ConnectionState.waiting) {
              return Center(child: WaitingWidget());
            } else if (asyncSnapshot.hasData) {
              UserInfoResponse? model = asyncSnapshot.data;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      //
                      Container(
                        width: 1.sw,
                        height: 140.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(20.r),
                            bottomRight: Radius.circular(20.r),
                          ),
                          color: Color(0xFFF566A9),
                        ),
                      ),

                      // Profile text
                      Positioned(
                        left: 0,
                        right: 0,
                        child: Center(
                          child: SafeArea(
                            child: Text(
                              "Profile",
                              style: TextFontStyle
                                  .headline30c27272AtyleWorkSansW700
                                  .copyWith(
                                    color: Colors.white,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                          ),
                        ),
                      ),

                      Positioned(
                        left: 0,
                        right: 0,
                        bottom: -40,
                        child: Center(
                          child: Container(
                            width: 80.w,
                            height: 100.h,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.white,
                                width: 3.w,
                              ),
                            ),
                            clipBehavior: Clip.antiAlias,
                            child: CustomCachedNetworkImage(
                              width: 80.w,
                              height: 80.h,
                              imageUrl: model?.data?.avatar ?? "",
                            ),
                          ),
                        ),
                      ),

                      Positioned(
                        left: 0,
                        right: 0,
                        child: Container(
                          padding: EdgeInsets.all(8.w),
                          color: Colors.transparent,
                          child: SvgPicture.asset(
                            Assets.icons.upload,
                            width: 28.w,
                            height: 28.h,
                          ),
                        ),
                      ),
                    ],
                  ),

                  UIHelper.verticalSpace(40.h),

                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      model?.data?.name ?? "",
                      style: TextFontStyle.headLine16cFFFFFFWorkSansW600
                          .copyWith(
                            color: const Color(0xFF27272A),
                            fontSize: 24.sp,

                            fontWeight: FontWeight.w700,
                          ),
                    ),
                  ),
                  UIHelper.verticalSpace(30.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: UserInfoWidget(
                          icon: Assets.icons.cake,
                          subtitle: "years",
                          title: model?.data?.userInfo?.age.toString() ?? "",
                        ),
                      ),
                      SizedBox(
                        height: 80.h,
                        child: VerticalDivider(
                          color: Color(0xFFD4D4D8),
                          thickness: 1,
                        ),
                      ),
                      Expanded(
                        child: UserInfoWidget(
                          icon: Assets.icons.cake,
                          subtitle: "kilograms",
                          title:
                              model?.data?.userInfo?.currentWeight.toString() ??
                              "",
                        ),
                      ),
                      SizedBox(
                        height: 80.h,
                        child: VerticalDivider(
                          color: Color(0xFFD4D4D8),
                          thickness: 1,
                        ),
                      ),
                      Expanded(
                        child: UserInfoWidget(
                          icon: Assets.icons.cake,
                          subtitle: "Height",
                          title: model?.data?.userInfo?.height.toString() ?? "",
                        ),
                      ),
                    ],
                  ),

                  UIHelper.verticalSpace(32.h),

                  // Workout Card Widget
                  WorkoutCardWidget(
                    activaDays:
                        model?.data?.userInfo?.activeDays.toString() ?? "",
                    workoutComplete:
                        model?.data?.userInfo?.totalWorkoutsCompleted
                            .toString() ??
                        "",
                    totalCalories:
                        model?.data?.userInfo?.totalCaloriesBurned.toString() ??
                        "",
                  ),

                  UIHelper.verticalSpace(20.h),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Text(
                      "General Settings",
                      style: TextFontStyle.headLine16cFFFFFFWorkSansW600
                          .copyWith(
                            color: const Color(0xFF27272A),
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                  ),
                  UIHelper.verticalSpace(16.h),
                  SettingsTitleWidget(
                    onTap: () {
                      NavigationService.navigateToWithArgs(
                        Routes.editProfileScreen,
                        {"data": model?.data},
                      );
                    },
                    icon: Assets.icons.userSingle,
                    title: "Profile Settings",
                  ),
                  UIHelper.verticalSpace(12.h),

                  // SettingsTitleWidget(
                  //   onTap: () {
                  //     NavigationService.navigateTo(Routes.subscriptionScreen);
                  //   },
                  //   icon: Assets.icons.vector,
                  //   title: "Subscription & Billing",
                  // ),
                  //    UIHelper.verticalSpace(12.h),
                  SettingsTitleWidget(
                    onTap: () {
                      NavigationService.navigateTo(Routes.unitMetricScreen);
                    },
                    icon: Assets.icons.ruler,
                    title: "Units & Metrics",
                  ),
                  UIHelper.verticalSpace(32.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Text(
                      "Notifications",
                      style: TextFontStyle.headLine16cFFFFFFWorkSansW600
                          .copyWith(
                            color: const Color(0xFF27272A),
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                  ),
                  UIHelper.verticalSpace(12.h),
                  SettingsTitleWidget(
                    onTap: () {
                      NavigationService.navigateTo(Routes.notificationScreen);
                    },
                    icon: Assets.icons.vector1,
                    title: "General Notification",
                  ),
                  UIHelper.verticalSpace(12.h),
                  // SettingsTitleWidget(
                  //   onTap: () {},
                  //   icon: Assets.icons.envelopeEmail,
                  //   title: "Email Notification",
                  // ),
                  // UIHelper.verticalSpace(12.h),
                  // SettingsTitleWidget(
                  //   onTap: () {},
                  //   icon: Assets.icons.soundOn,
                  //   title: "Sound Notiifcation",
                  // ),

                  ///
                  UIHelper.verticalSpace(32.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Text(
                      "Security & Privacy",
                      style: TextFontStyle.headLine16cFFFFFFWorkSansW600
                          .copyWith(
                            color: const Color(0xFF27272A),
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                  ),
                  UIHelper.verticalSpace(12.h),
                  SettingsTitleWidget(
                    onTap: () {
                      NavigationService.navigateTo(Routes.changePasswordScreen);
                    },
                    icon: Assets.icons.lockLocked,
                    title: "Change password",
                  ),
                  UIHelper.verticalSpace(12.h),
                  SettingsTitleWidget(
                    onTap: () {
                      NavigationService.navigateTo(Routes.privacyScreen);
                    },
                    icon: Assets.icons.arrowRepeat,
                    title: "Privacy",
                  ),
                  UIHelper.verticalSpace(32.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Text(
                      "Help & Support",
                      style: TextFontStyle.headLine16cFFFFFFWorkSansW600
                          .copyWith(
                            color: const Color(0xFF27272A),
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                  ),
                  UIHelper.verticalSpace(12.h),
                  SettingsTitleWidget(
                    onTap: () {
                      NavigationService.navigateTo(Routes.faqScreen);
                    },
                    icon: Assets.icons.questionMarkCircle,
                    title: "FAQs",
                  ),

                  UIHelper.verticalSpace(32.h),

                  // Danger Zone
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Text(
                      "Danger Zone",
                      style: TextFontStyle.headLine16cFFFFFFWorkSansW600
                          .copyWith(
                            color: const Color(0xFF27272A),
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                  ),
                  UIHelper.verticalSpace(12.h),
                  SettingsTitleWidget(
                    onTap: () {
                      NavigationService.navigateTo(Routes.deleteAccountScreen);
                    },
                    icon: Assets.icons.trash,
                    title: "Delete Account",
                  ),

                  UIHelper.verticalSpace(20.h),

                  InkWell(
                    onTap: () {
                      NavigationService.navigateTo(Routes.signoutScreen);
                    },
                    child: SvgPicture.asset(
                      Assets.icons.frame3,
                      width: 24.w,
                      height: 24.h,
                      fit: BoxFit.contain,
                    ),
                  ),

                  UIHelper.verticalSpaceExtraLarge,
                ],
              );
            } else {
              return SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}
